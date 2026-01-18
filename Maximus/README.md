# Maximus Pet Store - Customer Storefront

**Laravel 11 E-Commerce Frontend**

Last Updated: 2026-01-07

## Overview

Modern, responsive customer-facing storefront for Maximus Pet Store. Built with Laravel 11 and Bootstrap 5, featuring dynamic theming, API-driven content, and a seamless shopping experience.

## Quick Access

| Service | URL |
|---------|-----|
| Storefront | http://localhost:8400 |
| Admin Panel | http://localhost:8401/adminpanel |
| API | http://localhost:8400/api/v1 |
| phpMyAdmin | http://localhost:8480 |

## Technology Stack

- **Framework**: Laravel 11
- **PHP**: 8.2+
- **Frontend**: Blade Templates, Bootstrap 5, JavaScript
- **Database**: MySQL 8.0
- **Container**: Docker

## Key Features

### Shopping Experience
- Product catalog with search and filters
- Category browsing
- Product detail pages with images
- Shopping cart
- Checkout process

### Dynamic Theming
- API-driven branding (logo, colors)
- Configurable header/footer
- Featured categories/products from admin
- Announcement bar support

### Customer Features
- User registration/login
- Order history
- Wishlist
- Product reviews

## Project Structure

```
Maximus/
├── app/
│   ├── Http/Controllers/
│   ├── Models/
│   └── Services/
│       ├── BrandingService.php
│       ├── FeaturesService.php
│       └── HomepageService.php
├── resources/views/
│   ├── layouts/
│   ├── components/
│   ├── products/
│   └── welcome.blade.php
├── public/
│   └── assets/
├── routes/web.php
└── .env
```

## Docker Setup

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f storefront

# Clear cache
docker exec maximus_storefront php artisan cache:clear
```

## Related Projects

- **Admin Panel**: [maximus-backend-admin-site](../maximus-backend-admin-site/)
- **API**: [maximus-backendadmin-api](../maximus-backendadmin-api/)

## Documentation

See [../CLAUDE.md](../CLAUDE.md) for complete project documentation.

---

**Maximus Pet Store - Your One-Stop Shop for Pet Supplies**
