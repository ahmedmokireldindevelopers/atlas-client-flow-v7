# Atlas Client Flow / Baileys Assistant

A powerful WhatsApp management and automation platform integrating **Atlas Client Flow** and **Baileys Assistant**. This application combines a modern React frontend with a robust Express/Baileys backend to provide a complete solution for WhatsApp marketing, CRM, and automation.

## 🚀 Features

### Core Capabilities
- **WhatsApp Automation:** Send and receive messages, manage automated replies.
- **Multi-Session Support:** Manage multiple WhatsApp accounts simultaneously.
- **Message Templates:** Create and use templates for consistent messaging (Text, Buttons, Lists, Carousels).
- **CRM Integration:** Seamlessly integrate with external systems via Webhooks.
- **Live Chat:** Real-time chat interface for interacting with customers.

### Integrations
- **E-commerce:** Shopify, WooCommerce, WordPress, Salla, Zid.
- **Security:** OTP (One-Time Password) flows.
- **Backup:** Google Drive integration for session backups.
- **API:** Comprehensive Private API for programmatic access.

---

## 🏗️ Architecture

The project is structured as a monorepo containing both the frontend and backend:

- **Frontend:** Built with [Vite](https://vitejs.dev/), [React](https://react.dev/), [TypeScript](https://www.typescriptlang.org/), and [shadcn/ui](https://ui.shadcn.com/).
- **Backend:** Node.js [Express](https://expressjs.com/) server using [Baileys](https://github.com/WhiskeySockets/Baileys) for WhatsApp connectivity.
- **Database:** Uses a file-based session store and local JSON databases (in `server/data`), scaleable to production DBs.

---

## 🛠️ Setup & Installation

### Prerequisites
- Node.js (v18 or higher recommended)
- npm or yarn

### Setup & Installation

For detailed installation instructions using Local Development, Docker, or Manual Production builds, please refer to our **[Installation Guide](docs/INSTALLATION.md)**.

### Quick Start (Local Dev)
```bash
npm install
npm run dev
```

### Production Build
```bash
npm run build
node server/index.js
```

---

## 📂 Project Structure

```
atlasclientflow/
├── dist/               # Production build output
├── docs/               # Documentation files
├── server/             # Backend Express application
│   ├── data/           # JSON databases (contacts, settings, etc.)
│   ├── modules/        # API route handlers and business logic
│   ├── sessions/       # WhatsApp session files
│   ├── scripts/        # Utility scripts (e.g., debug tools)
│   └── index.js        # Server entry point
├── src/                # Frontend React application
│   ├── components/     # Reusable UI components
│   ├── pages/          # Application pages/routes
│   └── lib/            # Utilities and helpers
├── .env                # Environment variables
├── package.json        # Project dependencies and scripts
└── vite.config.ts      # Vite configuration
```

---

## 🐳 Docker Deployment

The project includes Docker support for easy deployment.

1.  **Build and Run with Docker Compose:**
    ```bash
    docker-compose up -d --build
    ```

2.  **Nginx Proxy Manager:**
    Configuration for reverse proxy is available in `docs/NGINX_PROXY_MANAGER.md`.

---

## 📝 API Documentation

The backend provides a RESTful API for managing sessions and sending messages.

- **Base URL:** `/api`
- **Key Endpoints:**
    - `POST /api/sessions/add` - Create a new WhatsApp session
    - `GET /api/sessions` - List active sessions
    - `POST /api/messages/send` - Send a message

*(See internally generated API docs for full details)*

---

## 🤝 Contributing

1.  Fork the repository
2.  Create your feature branch (`git checkout -b feature/amazing-feature`)
3.  Commit your changes (`git commit -m 'Add some amazing feature'`)
4.  Push to the branch (`git push origin feature/amazing-feature`)
5.  Open a Pull Request
