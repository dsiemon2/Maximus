# Maximus Pet Store - Backend API

**Laravel 11 RESTful API Service**

Last Updated: 2026-01-15

## Overview

Laravel-based RESTful API providing data and business logic for both customer-facing storefront and admin panel. Handles all database operations, business rules, and data management.

## Quick Access

| Service | URL |
|---------|-----|
| API Base | http://localhost:8400/api/v1 |
| Admin Panel | http://localhost:8401/adminpanel |
| Storefront | http://localhost:8400 |
| phpMyAdmin | http://localhost:8480 |

## Technology Stack

- **Framework**: Laravel 11
- **PHP**: 8.2+
- **Database**: MySQL 8.0
- **Format**: JSON
- **Container**: Docker

## Key Features

### Core Functionality
- RESTful architecture
- JSON request/response
- CORS support
- Error handling
- Input validation
- API versioning (v1)

### Endpoint Categories

**Public** (no auth):
- Products listing and details
- Categories
- Featured categories/products
- Branding/settings
- Footer configuration

**Admin** (auth required):
- Product management
- Order management
- Customer management
- Inventory operations
- Settings & branding
- Featured content management
- Reports & analytics

### Payment Gateway System

Modular payment gateway architecture supporting multiple processors:

| Gateway | SDK Package | Features |
|---------|-------------|----------|
| **Stripe** | stripe/stripe-php v16.x | Cards, Apple Pay, Google Pay, ACH |
| **Braintree** | braintree/braintree_php v6.x | Cards, PayPal, Venmo |
| **PayPal** | (via Braintree) | PayPal Checkout |
| **Square** | square/square v38.x | Cards, Square Wallet, Afterpay |
| **Authorize.net** | authorizenet/authorizenet v2.x | Cards, eCheck/ACH |

**Architecture**:
```
app/
├── Contracts/
│   └── PaymentGatewayInterface.php    # Common interface
├── Services/Payments/
│   ├── PaymentManager.php             # Factory/manager
│   ├── StripeGateway.php
│   ├── BraintreeGateway.php
│   ├── PayPalGateway.php
│   ├── SquareGateway.php
│   └── AuthorizeNetGateway.php
└── Http/Controllers/Api/V1/
    └── PaymentController.php          # API endpoints
```

**Payment API Endpoints**:
```bash
GET  /api/v1/payments/gateways           # List available gateways
POST /api/v1/payments/create             # Create payment
GET  /api/v1/payments/{id}               # Retrieve payment
POST /api/v1/payments/{id}/confirm       # Confirm payment
POST /api/v1/payments/{id}/cancel        # Cancel payment
POST /api/v1/payments/{id}/refund        # Refund payment
POST /api/v1/webhooks/payment/{gateway}  # Webhook handler
```

**Configuration**: Payment gateways are configured via Admin Panel > Features > Payment Gateway Configuration. Settings stored in `settings` table with `setting_group = 'features'`.

## Project Structure

```
maximus-backendadmin-api/
├── app/
│   ├── Http/Controllers/Api/V1/
│   │   ├── ProductController.php
│   │   ├── CategoryController.php
│   │   ├── OrderController.php
│   │   └── Admin/
│   └── Models/
├── database/
│   ├── migrations/
│   └── seeders/
├── routes/api.php
└── .env
```

## API Examples

**Get Products**:
```bash
GET http://localhost:8400/api/v1/products?limit=20
```

**Get Categories**:
```bash
GET http://localhost:8400/api/v1/categories
```

**Get Featured Categories**:
```bash
GET http://localhost:8400/api/v1/featured-categories
```

**Get Branding Settings**:
```bash
GET http://localhost:8400/api/v1/branding
```

**Admin - Update Settings**:
```bash
PUT http://localhost:8400/api/v1/admin/settings/branding
Authorization: Bearer {token}
Content-Type: application/json
```

**Response Format**:
```json
{
  "success": true,
  "data": { ... },
  "message": "Operation successful"
}
```

## Docker Setup

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f api

# Run migrations
docker exec maximus_api php artisan migrate

# Run seeders
docker exec maximus_api php artisan db:seed
```

## Environment Variables

Key settings in `.env`:
```env
APP_URL=http://localhost:8400/api
DB_HOST=mysql
DB_DATABASE=maximus_petstore
DB_USERNAME=root
DB_PASSWORD=secret
```

## Related Projects

- **Storefront**: [Maximus](../Maximus/)
- **Admin Panel**: [maximus-backend-admin-site](../maximus-backend-admin-site/)

## Documentation

- [Setup Guide](docs/SETUP.md)
- [API Endpoints](docs/API_ENDPOINTS.md)
- [API Reference](docs/API_REFERENCE.md)
- [Project Documentation](../CLAUDE.md)

---

**Maximus Pet Store - API Service**
