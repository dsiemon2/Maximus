# Maximus Pet Store - Project Documentation

## Project Overview

Maximus Pet Store (MPS) is a multi-service e-commerce platform for pet supplies consisting of three Laravel applications communicating via APIs, all containerized with Docker.

## CRITICAL RULE

**NO HARDCODED STORE-SPECIFIC TEXT**: This codebase is designed to be a template. Never hardcode:
- Store names (use `config('app.name')`)
- Email addresses (generate from app name or use settings)
- Physical addresses (use database settings)
- URLs (use `url()`, `route()`, or environment variables)

## Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                         Docker Network                               │
├─────────────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐     │
│  │   Storefront    │  │   Admin Site    │  │   Backend API   │     │
│  │   (Laravel)     │  │   (Laravel)     │  │   (Laravel)     │     │
│  │   Port: 8400    │  │   Port: 8401    │  │  8400/api/v1    │     │
│  │   PHP-FPM 8.2   │  │   PHP-FPM 8.2   │  │   PHP-FPM 8.2   │     │
│  └────────┬────────┘  └────────┬────────┘  └────────┬────────┘     │
│           │                    │                    │               │
│           └────────────────────┴────────────────────┘               │
│                                │                                     │
│                    ┌───────────┴───────────┐                        │
│                    │      MySQL 8.0        │                        │
│                    │      Port: 3300       │                        │
│                    └───────────────────────┘                        │
│                                                                      │
│  ┌─────────────────┐                                                │
│  │   phpMyAdmin    │                                                │
│  │   Port: 8480    │                                                │
│  └─────────────────┘                                                │
└─────────────────────────────────────────────────────────────────────┘
```

## Services & Ports

| Service | Port | URL | Description |
|---------|------|-----|-------------|
| Storefront | 8400 | http://localhost:8400 | Customer-facing store |
| Admin Panel | 8401 | http://localhost:8401/adminpanel | Admin dashboard |
| API | 8400 | http://localhost:8400/api/v1 | Backend REST API |
| MySQL | 3300 | localhost:3300 | Database server |
| phpMyAdmin | 8480 | http://localhost:8480 | Database management |

## Directory Structure

```
Maximus/
├── docker-compose.yml          # Docker orchestration
├── CLAUDE.md                   # This file - project documentation
├── docker/
│   ├── nginx/
│   │   ├── default.conf       # Storefront nginx config
│   │   └── admin.conf         # Admin site nginx config
│   └── mysql/
│       └── init.sql           # Database initialization
├── Maximus/                    # Storefront Laravel app
│   ├── app/
│   │   ├── Services/          # BrandingService, FeaturesService, etc.
│   │   └── Http/Controllers/
│   ├── resources/views/
│   └── .env
├── maximus-backend-admin-site/ # Admin Laravel app
│   ├── app/Http/Controllers/
│   ├── resources/views/admin/
│   └── .env
└── maximus-backendadmin-api/   # API Laravel app
    ├── app/Http/Controllers/Api/V1/
    ├── database/
    │   ├── migrations/
    │   └── seeders/
    └── .env
```

## Test Credentials

### Admin Panel
- URL: http://localhost:8401/adminpanel
- Email: `admin@maximus.com`
- Password: `Test1234`

### Customer Account
- Email: `test@maximus.com`
- Password: `Test1234`

## Environment Variables

### Key .env Settings

**Storefront (.env)**
```env
APP_NAME="Maximus Pet Store"
APP_URL=http://localhost:8400
API_BASE_URL=http://host.docker.internal:8400/api/v1
DB_DATABASE=maximus_petstore
```

**Admin Site (.env)**
```env
APP_NAME="Maximus Admin"
APP_URL=http://localhost:8401
API_BASE_URL=http://host.docker.internal:8400/api/v1
API_PUBLIC_URL=http://localhost:8400/api/v1
STOREFRONT_URL=http://localhost:8400
DB_DATABASE=maximus_petstore
```

**API (.env)**
```env
APP_NAME="Maximus API"
APP_URL=http://localhost:8400/api
DB_DATABASE=maximus_petstore
```

## Key Services

### BrandingService (Storefront)
Location: `Maximus/app/Services/BrandingService.php`

Provides dynamic branding from admin API:
- Logo path
- Site title
- Theme colors (primary, secondary, accent)
- Navbar styling
- Announcement bar

### FeaturesService (Storefront)
Location: `Maximus/app/Services/FeaturesService.php`

Controls feature flags from admin API:
- Loyalty program
- Wishlists
- Gift cards
- Blog
- Events
- FAQ

### HomepageService (Storefront)
Location: `Maximus/app/Services/HomepageService.php`

Provides homepage content from admin API:
- Featured categories
- Featured products
- Banner configuration

## Payment Gateways

All 5 payment gateways are fully integrated in the API service:

| Gateway | Status | Location |
|---------|--------|----------|
| **Stripe** | Full integration | `app/Services/Payments/StripeGateway.php` |
| **PayPal** | Full integration | `app/Services/Payments/PayPalGateway.php` |
| **Braintree** | Full integration | `app/Services/Payments/BraintreeGateway.php` |
| **Square** | Full integration | `app/Services/Payments/SquareGateway.php` |
| **Authorize.net** | Full integration | `app/Services/Payments/AuthorizeNetGateway.php` |

### Payment Services Location
```
maximus-backendadmin-api/app/Services/Payments/
├── StripeGateway.php       # Stripe payment processing
├── PayPalGateway.php       # PayPal order management
├── BraintreeGateway.php    # Braintree transactions
├── SquareGateway.php       # Square payment processing
├── AuthorizeNetGateway.php # Authorize.net processing
└── PaymentManager.php      # Unified payment orchestrator
```

### Database Table
- `payment_gateways` - Payment gateway configuration (provider, credentials, enabled status)

## Database Schema

### Key Tables

- `categories` - Product categories (uses CategoryCode as identifier)
- `products3` - Products (uses UPC as primary identifier)
- `product_images` - Product images
- `users` - Customer accounts
- `orders` / `order_items` - Order management
- `settings` - Dynamic store settings
- `featured_categories` - Homepage featured categories
- `featured_products` - Homepage featured products

### Legacy Schema Notes

- Products use `UPC` (varchar) as the primary identifier
- Categories use `CategoryCode` (int) as the identifier
- Products table is named `products3`

## Docker Commands

```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# Rebuild and start
docker-compose up -d --build

# View logs
docker-compose logs -f storefront
docker-compose logs -f admin
docker-compose logs -f api

# Access container shell
docker exec -it maximus_storefront bash
docker exec -it maximus_admin bash
docker exec -it maximus_api bash
```

## Cache Management

```bash
# Clear storefront cache
docker exec maximus_storefront php artisan cache:clear
docker exec maximus_storefront php artisan config:clear
docker exec maximus_storefront php artisan view:clear

# Clear admin cache
docker exec maximus_admin php artisan cache:clear

# Clear API cache
docker exec maximus_api php artisan cache:clear
```

## Running Seeders

```bash
# Run all seeders
docker exec maximus_api php artisan db:seed

# Run specific seeder
docker exec maximus_api php artisan db:seed --class=SettingsSeeder
docker exec maximus_api php artisan db:seed --class=FeaturedCategoriesSeeder
```

## API Endpoints

### Public Endpoints
- `GET /api/v1/products` - List products
- `GET /api/v1/products/{upc}` - Product detail
- `GET /api/v1/categories` - List categories
- `GET /api/v1/branding` - Get branding settings
- `GET /api/v1/features` - Get feature flags
- `GET /api/v1/footer` - Get footer config
- `GET /api/v1/featured-categories` - Get featured categories
- `GET /api/v1/featured-products` - Get featured products

### Admin Endpoints (require auth)
- `GET /api/v1/admin/products` - Admin product list
- `PUT /api/v1/admin/products/{id}` - Update product
- `GET /api/v1/admin/settings` - Get all settings
- `PUT /api/v1/admin/settings` - Update settings
- `POST /api/v1/admin/login` - Admin login

## Troubleshooting

### Categories/Products Not Showing
1. Check if categories exist in database
2. Check featured_categories table has valid category_id values
3. Verify API is returning data: `curl http://localhost:8400/api/v1/homepage`
4. Clear all caches

### Branding Not Updating
1. Clear storefront cache
2. Check API is running
3. Check settings table has correct values

### Container Issues
1. Check container status: `docker-compose ps`
2. View logs: `docker-compose logs -f [service]`
3. Restart containers: `docker-compose restart`
4. Rebuild if needed: `docker-compose up -d --build`

### Login Issues
1. Verify password hash in database
2. Check API_BASE_URL and API_PUBLIC_URL in admin .env
3. Ensure ApiService.php has `->acceptJson()` on HTTP calls
4. Clear caches and restart containers

## Important Reminders

1. **No Hardcoded Store Names**: Always use `config('app.name')`
2. **No Hardcoded URLs**: Use `url()`, `route()`, or env variables
3. **No Hardcoded Emails**: Generate from app name or use settings
4. **Legacy Schema**: Products use UPC, categories use CategoryCode
5. **API-Driven Branding**: All visual branding comes from admin API
6. **Feature Flags**: Features can be toggled from admin without code changes
7. **Clear Caches**: Always clear caches after configuration changes

---

**Maximus Pet Store - Your One-Stop Shop for Pet Supplies**
