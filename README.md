# Maximus Pet Store

Multi-service e-commerce platform for pet supplies.

**Production Domain:** www.maximuspetstore.com

## Tech Stack

### Backend
- **Runtime:** PHP 8.2
- **Framework:** Laravel 12
- **Database:** MySQL 8.0
- **ORM:** Eloquent
- **API Docs:** L5-Swagger

### Frontend
- **Templating:** Blade
- **CSS Framework:** Bootstrap 5

### Payment Gateways
Stripe, Braintree, Square, Authorize.net

## Ports

| Service | Port | Description |
|---------|------|-------------|
| Storefront | 8400 | Customer-facing store |
| Admin Panel | 8401 | Admin dashboard |
| API | 8400/api | REST Backend |
| MySQL | 3308 | Database server |
| phpMyAdmin | 8480 | Database management UI |

## Local Development URLs

- **Storefront:** http://localhost:8400/
- **Admin Panel:** http://localhost:8401/adminpanel

## Docker Setup

```bash
# Start all services
docker compose up -d

# Rebuild and start
docker compose up -d --build

# View logs
docker compose logs -f

# Stop all services
docker compose down
```

## Author

Daniel Siemon
