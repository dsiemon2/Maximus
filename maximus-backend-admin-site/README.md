# Maximus Pet Store - Admin Panel

**Laravel 11 Administration Dashboard**

Last Updated: 2026-01-07

## Overview

Modern, feature-rich administration panel for managing all aspects of the Maximus Pet Store e-commerce platform. Built with Laravel 11, Bootstrap 5, and API-driven architecture.

## Quick Access

| Service | URL |
|---------|-----|
| Admin Panel | http://localhost:8401/adminpanel |
| Storefront | http://localhost:8400 |
| API | http://localhost:8400/api/v1 |
| phpMyAdmin | http://localhost:8480 |

**Default Login:**
- Email: `admin@maximus.com`
- Password: `Test1234`

## Technology Stack

- **Framework**: Laravel 11
- **PHP**: 8.2+
- **Frontend**: Blade Templates, Bootstrap 5, JavaScript
- **Database**: MySQL 8.0 (via API)
- **Container**: Docker

## Key Features

### Dashboard
- Real-time sales metrics
- Recent order activity
- Inventory alerts
- Quick action buttons

### Product Management
- Complete CRUD operations
- Bulk import/export
- Image management
- Inventory tracking
- Category assignment

### Order Management
- Order listing with filters
- Status updates
- Customer information
- Invoice generation

### Inventory Management
- Stock level monitoring
- Low stock alerts
- Stock movement tracking
- Reorder recommendations

### Customer Management
- Customer database
- Order history
- Account management

### Content Management
- Featured categories/products
- Blog posts
- Events calendar
- FAQ management

### Marketing Tools
- Coupon management
- Gift card administration
- Loyalty program

### Branding & Settings
- Store information
- Logo and header styling
- Theme colors
- Announcement bar
- Feature toggles

### Reports & Analytics
- Sales reports
- Inventory reports
- Customer analytics
- Export functionality

## Project Structure

```
maximus-backend-admin-site/
├── app/
│   ├── Http/Controllers/
│   └── Services/
│       └── ApiService.php
├── resources/views/
│   ├── admin/
│   │   ├── dashboard.blade.php
│   │   ├── products.blade.php
│   │   ├── orders.blade.php
│   │   └── ...
│   └── layouts/
├── routes/web.php
└── .env
```

## Docker Setup

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f admin

# Clear cache
docker exec maximus_admin php artisan cache:clear
```

## Environment Variables

Key settings in `.env`:
```env
APP_URL=http://localhost:8401
API_BASE_URL=http://host.docker.internal:8400/api/v1
API_PUBLIC_URL=http://localhost:8400/api/v1
STOREFRONT_URL=http://localhost:8400
```

## Related Projects

- **Storefront**: [Maximus](../Maximus/)
- **API**: [maximus-backendadmin-api](../maximus-backendadmin-api/)

## Documentation

- [Setup Guide](docs/SETUP.md)
- [Features](docs/FEATURES.md)
- [Settings Page](docs/SETTINGS_PAGE.md)
- [Project Documentation](../CLAUDE.md)

---

**Maximus Pet Store - Admin Panel**
