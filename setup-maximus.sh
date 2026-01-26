#!/bin/bash
#===============================================================================
# MAXIMUS PET STORE SETUP SCRIPT
# Application: Maximus Pet Store (Laravel Multi-Service)
# Domain: www.maximuspetstore.com
# Main Port: 8400, Admin Port: 8401
# Database: MySQL (Port 3308)
# DB Admin: phpMyAdmin (Port 8480)
# Repository: https://github.com/dsiemon2/Maximus
#===============================================================================

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
APP_NAME="maximus"
REPO_URL="https://github.com/dsiemon2/Maximus.git"
DOMAIN="www.maximuspetstore.com"
DOMAIN_ALT="maximuspetstore.com"
ADMIN_DOMAIN="admin.maximuspetstore.com"
APP_PORT=8400
ADMIN_PORT=8401
DB_PORT=3308
PHPMYADMIN_PORT=8480
DEPLOY_DIR="/home/deploy/apps/Maximus"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  MAXIMUS PET STORE SETUP SCRIPT${NC}"
echo -e "${GREEN}========================================${NC}"

#---------------------------------------
# STEP 1: Clone Repository
#---------------------------------------
echo -e "\n${YELLOW}[STEP 1/6] Cloning repository...${NC}"

if [ -d "$DEPLOY_DIR" ]; then
    echo -e "${YELLOW}Directory exists. Pulling latest changes...${NC}"
    cd "$DEPLOY_DIR"
    git pull origin main || git pull origin master
else
    echo -e "${GREEN}Cloning fresh repository...${NC}"
    mkdir -p /home/deploy/apps
    cd /home/deploy/apps
    git clone "$REPO_URL"
    cd "$DEPLOY_DIR"
fi

#---------------------------------------
# STEP 2: Configure Environment
#---------------------------------------
echo -e "\n${YELLOW}[STEP 2/6] Configuring environment...${NC}"

# Laravel app directories
declare -A APPS=(
    ["Maximus"]="storefront"
    ["maximus-backend-admin-site"]="admin"
    ["maximus-backendadmin-api"]="api"
)

for APP_DIR in "${!APPS[@]}"; do
    APP_PATH="${DEPLOY_DIR}/${APP_DIR}"
    SERVICE_NAME="${APPS[$APP_DIR]}"
    echo -e "${YELLOW}Configuring ${APP_DIR} (${SERVICE_NAME})...${NC}"

    if [ -f "${APP_PATH}/.env" ]; then
        echo -e "${GREEN}  .env already exists${NC}"
    elif [ -f "${APP_PATH}/.env.example" ]; then
        cp "${APP_PATH}/.env.example" "${APP_PATH}/.env"
        echo -e "${GREEN}  Created .env from .env.example${NC}"
    else
        echo -e "${RED}  ERROR: No .env.example found in ${APP_DIR}${NC}"
        exit 1
    fi
done

echo -e "\n${RED}========================================${NC}"
echo -e "${RED}  IMPORTANT: Configure .env files${NC}"
echo -e "${RED}========================================${NC}"
echo -e "\nEdit these files with production values:"
echo -e "  ${DEPLOY_DIR}/Maximus/.env"
echo -e "  ${DEPLOY_DIR}/maximus-backend-admin-site/.env"
echo -e "  ${DEPLOY_DIR}/maximus-backendadmin-api/.env"
echo -e "\n${YELLOW}Required changes for ALL .env files:${NC}"
echo -e "  APP_ENV=production"
echo -e "  APP_DEBUG=false"
echo -e "  DB_HOST=mysql"
echo -e "  DB_DATABASE=maximus_petstore"
echo -e "  DB_USERNAME=root"
echo -e "  DB_PASSWORD=secret"
echo -e "\n${YELLOW}Storefront (Maximus/.env):${NC}"
echo -e "  APP_URL=https://${DOMAIN}"
echo -e "  API_BASE_URL=http://api:9000/api/v1"
echo -e "\n${YELLOW}Admin (maximus-backend-admin-site/.env):${NC}"
echo -e "  APP_URL=https://${ADMIN_DOMAIN}"
echo -e "  API_BASE_URL=http://api:9000/api/v1"
echo -e "  API_PUBLIC_URL=https://${DOMAIN}/api/v1"
echo -e "  STOREFRONT_URL=https://${DOMAIN}"
echo -e "\n${YELLOW}API (maximus-backendadmin-api/.env):${NC}"
echo -e "  APP_URL=https://${DOMAIN}/api"
echo -e "\n${YELLOW}Payment gateways (if using):${NC}"
echo -e "  STRIPE_KEY=pk_live_xxx"
echo -e "  STRIPE_SECRET=sk_live_xxx"
echo -e "  (Configure other gateways as needed)"
echo ""
read -p "Press Enter after editing .env files (or Ctrl+C to abort)..."

#---------------------------------------
# STEP 3: Build and Start Docker
#---------------------------------------
echo -e "\n${YELLOW}[STEP 3/6] Building and starting Docker containers...${NC}"

cd "$DEPLOY_DIR"

# Stop existing containers
docker compose down 2>/dev/null || true

# Build and start
docker compose build --no-cache
docker compose up -d

echo -e "${GREEN}Waiting for containers to initialize...${NC}"
sleep 20

# Verify containers are running
if ! docker compose ps | grep -q "Up"; then
    echo -e "${RED}Containers failed to start. Check logs:${NC}"
    docker compose logs
    exit 1
fi

echo -e "${GREEN}Containers are running!${NC}"

# Install dependencies and configure each Laravel app
echo -e "\n${YELLOW}Installing dependencies and configuring Laravel apps...${NC}"

declare -A CONTAINERS=(
    ["maximus_storefront"]="/var/www/storefront"
    ["maximus_api"]="/var/www/api"
    ["maximus_admin"]="/var/www/admin"
)

for CONTAINER in "${!CONTAINERS[@]}"; do
    WORK_DIR="${CONTAINERS[$CONTAINER]}"
    echo -e "\n${YELLOW}Setting up ${CONTAINER}...${NC}"

    # Install composer dependencies
    echo -e "  Installing composer dependencies..."
    docker exec -w "$WORK_DIR" "$CONTAINER" composer install --no-dev --optimize-autoloader 2>&1 || {
        echo -e "${RED}  Composer install failed for ${CONTAINER}${NC}"
    }

    # Generate app key
    echo -e "  Generating application key..."
    docker exec -w "$WORK_DIR" "$CONTAINER" php artisan key:generate --force 2>&1 || true

    # Cache configuration
    echo -e "  Caching configuration..."
    docker exec -w "$WORK_DIR" "$CONTAINER" php artisan config:cache 2>&1 || true
    docker exec -w "$WORK_DIR" "$CONTAINER" php artisan route:cache 2>&1 || true
    docker exec -w "$WORK_DIR" "$CONTAINER" php artisan view:cache 2>&1 || true

    # Set permissions
    echo -e "  Setting permissions..."
    docker exec -w "$WORK_DIR" "$CONTAINER" chmod -R 775 storage bootstrap/cache 2>&1 || true
    docker exec -w "$WORK_DIR" "$CONTAINER" chown -R www-data:www-data storage bootstrap/cache 2>&1 || true

    echo -e "${GREEN}  ${CONTAINER} configured successfully${NC}"
done

# Run migrations (only on API since it's the main database service)
echo -e "\n${YELLOW}Running database migrations...${NC}"
docker exec -w /var/www/api maximus_api php artisan migrate --force 2>&1 || {
    echo -e "${YELLOW}Migrations may need manual attention${NC}"
}

# Run seeders if needed
echo -e "${YELLOW}Running database seeders...${NC}"
docker exec -w /var/www/api maximus_api php artisan db:seed --force 2>&1 || {
    echo -e "${YELLOW}Seeders may need manual attention or already run${NC}"
}

#---------------------------------------
# STEP 4: Configure Nginx
#---------------------------------------
echo -e "\n${YELLOW}[STEP 4/6] Configuring Nginx reverse proxy...${NC}"

# Main site config
NGINX_CONF="/etc/nginx/sites-available/${DOMAIN}"
sudo tee "$NGINX_CONF" > /dev/null <<EOF
server {
    listen 80;
    server_name ${DOMAIN} ${DOMAIN_ALT};

    location / {
        proxy_pass http://localhost:${APP_PORT};
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
        proxy_read_timeout 86400;
        client_max_body_size 50M;
    }
}
EOF

# Admin site config
NGINX_ADMIN_CONF="/etc/nginx/sites-available/${ADMIN_DOMAIN}"
sudo tee "$NGINX_ADMIN_CONF" > /dev/null <<EOF
server {
    listen 80;
    server_name ${ADMIN_DOMAIN};

    location / {
        proxy_pass http://localhost:${ADMIN_PORT};
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
        proxy_read_timeout 86400;
        client_max_body_size 50M;
    }
}
EOF

# Enable sites
sudo ln -sf "$NGINX_CONF" /etc/nginx/sites-enabled/
sudo ln -sf "$NGINX_ADMIN_CONF" /etc/nginx/sites-enabled/

# Test and reload Nginx
sudo nginx -t
sudo systemctl reload nginx

echo -e "${GREEN}Nginx configured successfully!${NC}"

#---------------------------------------
# STEP 5: SSL Certificates
#---------------------------------------
echo -e "\n${YELLOW}[STEP 5/6] Setting up SSL certificates...${NC}"

# Main domain SSL
sudo certbot --nginx -d ${DOMAIN} -d ${DOMAIN_ALT} --non-interactive --agree-tos --email admin@${DOMAIN_ALT} || {
    echo -e "${YELLOW}Main domain certbot failed. Run manually:${NC}"
    echo -e "sudo certbot --nginx -d ${DOMAIN} -d ${DOMAIN_ALT}"
}

# Admin domain SSL
sudo certbot --nginx -d ${ADMIN_DOMAIN} --non-interactive --agree-tos --email admin@${DOMAIN_ALT} || {
    echo -e "${YELLOW}Admin domain certbot failed. Run manually:${NC}"
    echo -e "sudo certbot --nginx -d ${ADMIN_DOMAIN}"
}

#---------------------------------------
# STEP 6: Verify Deployment
#---------------------------------------
echo -e "\n${YELLOW}[STEP 6/6] Verifying deployment...${NC}"

echo -e "\n${GREEN}Container Status:${NC}"
docker compose ps

echo -e "\n${GREEN}Testing endpoints...${NC}"
sleep 5

# Test main app
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:${APP_PORT} || echo "000")
if [ "$HTTP_STATUS" = "200" ] || [ "$HTTP_STATUS" = "302" ]; then
    echo -e "${GREEN}✓ Main app responding on port ${APP_PORT}${NC}"
else
    echo -e "${YELLOW}⚠ Main app returned HTTP ${HTTP_STATUS}${NC}"
fi

# Test admin
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:${ADMIN_PORT} || echo "000")
if [ "$HTTP_STATUS" = "200" ] || [ "$HTTP_STATUS" = "302" ]; then
    echo -e "${GREEN}✓ Admin panel responding on port ${ADMIN_PORT}${NC}"
else
    echo -e "${YELLOW}⚠ Admin panel returned HTTP ${HTTP_STATUS}${NC}"
fi

# Test API
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:${APP_PORT}/api/v1/products || echo "000")
if [ "$HTTP_STATUS" = "200" ]; then
    echo -e "${GREEN}✓ API responding${NC}"
else
    echo -e "${YELLOW}⚠ API returned HTTP ${HTTP_STATUS}${NC}"
fi

#---------------------------------------
# COMPLETE
#---------------------------------------
echo -e "\n${GREEN}========================================${NC}"
echo -e "${GREEN}  MAXIMUS PET STORE SETUP COMPLETE!${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "\nApplication Details:"
echo -e "  Main URL:     https://${DOMAIN}"
echo -e "  Admin URL:    https://${ADMIN_DOMAIN}/adminpanel"
echo -e "  API URL:      https://${DOMAIN}/api/v1"
echo -e "  Main Port:    ${APP_PORT}"
echo -e "  Admin Port:   ${ADMIN_PORT}"
echo -e "  DB Port:      ${DB_PORT}"
echo -e "  phpMyAdmin:   http://SERVER_IP:${PHPMYADMIN_PORT} (internal only)"
echo -e "  Directory:    ${DEPLOY_DIR}"
echo -e "\n${YELLOW}Test Credentials:${NC}"
echo -e "  Admin Login:  admin@maximus.com / Test1234"
echo -e "  Customer:     test@maximus.com / Test1234"
echo -e "\n${YELLOW}Useful Commands:${NC}"
echo -e "  View logs:      cd ${DEPLOY_DIR} && docker compose logs -f"
echo -e "  Restart:        cd ${DEPLOY_DIR} && docker compose restart"
echo -e "  Stop:           cd ${DEPLOY_DIR} && docker compose down"
echo -e "  Storefront CLI: docker exec -it maximus_storefront php artisan <command>"
echo -e "  API CLI:        docker exec -it maximus_api php artisan <command>"
echo -e "  Admin CLI:      docker exec -it maximus_admin php artisan <command>"
echo -e "  DB Backup:      docker exec maximus_mysql mysqldump -u root -psecret maximus_petstore > backup.sql"
echo -e "\n${YELLOW}Troubleshooting:${NC}"
echo -e "  Check logs:     docker compose logs -f storefront"
echo -e "  Clear cache:    docker exec maximus_storefront php artisan cache:clear"
echo -e "  Rebuild:        docker compose down && docker compose build --no-cache && docker compose up -d"
