# AtlasFlow - WhatsApp Business Platform

## Overview
AtlasFlow is a full-stack WhatsApp Business Assistant application built with React (Vite) frontend and Express.js backend. It enables WhatsApp session management, messaging, campaign management, and integrates with various e-commerce platforms.

## Project Structure
```
.
├── src/                    # React frontend (TypeScript)
├── server/                 # Express.js backend
│   ├── modules/           # API modules (billing, campaigns, chat, etc.)
│   ├── lib/               # Utilities (db, prisma)
│   ├── prisma/            # Database schema
│   └── data/              # JSON file-based storage
├── public/                # Static assets
└── docs/                  # Documentation
```

## Tech Stack
- **Frontend**: React 18, Vite, TypeScript, TailwindCSS, Radix UI, Three.js
- **Backend**: Express.js, Prisma ORM
- **Database**: PostgreSQL (via Replit)
- **Messaging**: WhiskeySockets/Baileys (WhatsApp Web API)

## Running the Application
The app runs with `npm run dev` which starts:
1. Vite dev server on port 5000 (frontend)
2. Express server on port 3002 (backend)

The Vite proxy forwards `/api` requests to the backend.

## Key Features
- WhatsApp session management (QR code login)
- Contact and group sync
- Message sending (text, templates, interactive)
- Campaign management
- E-commerce integrations (Shopify, WooCommerce, Salla, Zid, etc.)
- Multi-tenant support with RBAC

## Environment Variables
- `DATABASE_URL`: PostgreSQL connection string (managed by Replit)
- `VITE_SUPABASE_URL`: Optional Supabase URL
- `VITE_SUPABASE_ANON_KEY`: Optional Supabase anon key

## Payment Gateways
The application supports two payment providers:
- **Stripe** - Full implementation with checkout sessions, payment verification, and webhooks
- **PayPal** - Full implementation with checkout orders, payment capture, and webhooks

### API Endpoints
- `POST /api/billing/checkout` - Create checkout session (requires planId, optional provider)
- `POST /api/billing/verify-payment` - Verify payment status
- `POST /api/billing/webhooks/stripe` - Stripe webhook handler
- `POST /api/billing/webhooks/paypal` - PayPal webhook handler
- `GET /api/billing/providers` - List supported payment providers

### Required Environment Variables for Payments
- `STRIPE_API_KEY` - Stripe secret key
- `STRIPE_WEBHOOK_SECRET` - Stripe webhook signing secret
- `FRONTEND_URL` - Base URL for payment redirects

## OTP Verification System
The registration page includes WhatsApp-based OTP verification:
- `POST /api/auth/send-otp` - Send 6-digit OTP to WhatsApp number
- `POST /api/auth/verify-otp` - Verify OTP code (5 attempts max, 5 min expiry)
- `POST /api/auth/register` - Create new user account (requires verified phone)

## Admin Features
- **Member Management** (`/dashboard/members`) - Invite team members, assign roles, remove members
- **Payment Gateway Settings** (`/dashboard/payment-gateways`) - Configure Stripe, PayPal, Tap Payments, Moyasar
- **Profile Settings Dropdown** - Access profile, API keys, subscription from header avatar
- **Unlimited Device Connections** - Admin/super_admin/owner roles have no device limits

### Admin API Endpoints
- `GET /api/admin/members` - List all team members (admin only)
- `POST /api/admin/members/invite` - Invite a new member (admin only)
- `PATCH /api/admin/members/:id/role` - Update member role (admin only)
- `DELETE /api/admin/members/:id` - Remove member (admin only)
- `GET /api/admin/payment-gateways` - List payment gateways with masked secrets (admin only)
- `PUT /api/admin/payment-gateways/:id` - Configure payment gateway (admin only)
- `PATCH /api/admin/payment-gateways/:id/toggle` - Enable/disable gateway (admin only)
- `GET /api/auth/me` - Get current user info and role

### Security
- Admin endpoints protected with `requireAdmin` middleware (checks for admin/super_admin/owner roles)
- Payment gateway secrets masked in GET responses (first 4 + **** + last 4 characters)
- Role-based access control for sensitive operations

## Recent Changes
- 2026-01-21: Complete SaaS Platform Redesign
  - **Landing Page**: Modern design with Hero section, features grid, pricing plans, integrations showcase, and CTA section
  - **Authentication Pages**: Professional split-screen login page with email/WhatsApp OTP options
  - **Forgot Password**: New password reset flow with email verification
  - **Multi-language Support**: Full Arabic (RTL) and English translations for all pages
  - **Dashboard**: Enhanced overview with System Health widget, metrics cards, analytics charts
  - **Sidebar Navigation**: Organized into sections (Overview, Devices, Messaging, Automation, Integrations, Settings, Developers, Administration, Support)
  - **Device Connection Success Dialog**: Animated success confirmation with "Done" button
  - **Super Admin System**: Email-based super admin (ahmedmokireldin.developers@gmail.com) with unlimited device access
- 2026-01-21: Added admin SaaS features
  - Member Management system with invite, role assignment, removal
  - Payment Gateway Settings for Stripe, PayPal, Tap, Moyasar
  - Profile dropdown with settings navigation
  - Admin role-based middleware (requireAdmin) for API security
  - Secret key masking for payment gateway responses
  - Admins have unlimited device connections
- 2026-01-21: Configured for Replit environment
  - Updated Vite to run on port 5000 with allowedHosts: true
  - Switched Prisma from SQLite to PostgreSQL
  - Fixed Prisma imports in settings.js and users.js
  - Added Supabase credentials for authentication
  - Fixed API URLs across all dashboard pages (removed hardcoded localhost:3001)
  - Fixed unused variable warnings in Login.tsx
  - Added PayPal payment provider
  - Enhanced payment service with multi-provider support
  - Added checkout, verify-payment, and providers endpoints
  - Improved WhatsApp session stability:
    - Increased MAX_RETRIES from 3 to 15
    - Added exponential backoff with jitter for reconnection
    - Added heartbeat system to keep connections alive
    - Improved connection configuration (keepAlive, timeouts)
    - Added more reconnectable status codes handling
- 2026-01-22: Data Sync Reliability Improvements
  - **Batch Database Operations**: Fixed race conditions in groups/contacts sync by implementing batch upsert functions
  - **Async Write Operations**: All database writes now properly await completion before proceeding
  - **Groups Sync**: `batchUpsertGroups()` processes all groups in single write operation (54+ groups now sync correctly)
  - **Contacts Sync**: `batchUpsertContacts()` prevents data loss during bulk contact updates
  - **Device Page Loading**: Immediate data fetch with SSE fallback for real-time updates
  - **WebSocket Proxy**: Added WS support in Vite proxy configuration for SSE compatibility
- 2026-01-22: Signal Protocol Bad MAC Error Handling System
  - **SessionHealthMonitor** (`server/lib/sessionHealth.js`): Tracks MAC errors per session with health scores (0-100)
  - **SessionRecoveryManager** (`server/lib/sessionRecovery.js`): Automatic backup, recovery, and session restore
  - **Automatic Recovery**: Triggers when MAC_ERROR_THRESHOLD (5 errors) reached
  - **API Endpoints** (protected with API key + session ownership):
    - `GET /api/monitoring/sessions/health` - Get all sessions health status
    - `POST /api/monitoring/sessions/:sessionId/recover` - Trigger manual recovery
    - `POST /api/monitoring/sessions/:sessionId/reset` - Force session reset
    - `GET /api/monitoring/sessions/:sessionId/backups` - List session backups
    - `POST /api/monitoring/sessions/:sessionId/restore` - Restore from backup
  - Periodic health checks every 30 seconds
  - Session backups (max 3 per session) stored in server/sessions/backups/
  - Removed session credentials from git tracking (.gitignore updated)
