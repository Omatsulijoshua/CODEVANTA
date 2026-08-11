# ⚡ CODEVANTA — MOBILE AI DEVELOPMENT IDE
### *"YOUR IDE. YOUR CODE. YOUR AI."*

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/Omatsulijoshua/CODEVANTA)
[![Web IDE App](https://img.shields.io/badge/Web_IDE-Live_v1.0.0-6E00FF.svg)](https://codevanta-app.vercel.app)
[![Admin Control](https://img.shields.io/badge/Next.js_Admin-Live_v14.2.35-000000.svg)](https://codevanta-admin.vercel.app)
[![Backend API](https://img.shields.io/badge/NestJS_Backend-v10.3.0-E0234E.svg)](https://codevanta-backend-api.onrender.com/api/docs)
[![Mobile Engine](https://img.shields.io/badge/Flutter-v3.44+-02569B.svg)](https://github.com/Omatsulijoshua/CODEVANTA)
[![License](https://img.shields.io/badge/license-UNLICENSED-purple.svg)](https://github.com/Omatsulijoshua/CODEVANTA)

CodeVanta is a professional, cross-platform mobile AI development environment built for iPhone, iPad, Android, and Web. Inspired by modern desktop IDEs (VS Code, Sublime Text), CodeVanta is engineered specifically for touchscreens, external keyboards, Termux local terminal integration, and autonomous mobile AI coding workflows.

---

## 🌐 Live Production Deployments & API Endpoints

| Platform Module | Production Live URL | Description |
| :--- | :--- | :--- |
| 📱 **Web IDE App** | [`https://codevanta-app.vercel.app`](https://codevanta-app.vercel.app) | Full Flutter Web IDE (Onboarding, File Explorer, Editor, Terminal, AI Agents, Git, Extensions) |
| 👑 **Admin Dashboard** | [`https://codevanta-admin.vercel.app`](https://codevanta-admin.vercel.app) | Production SaaS Admin Control Panel (User management, AI Multi-Key pools, Telemetry, Subscriptions) |
| 🌐 **Landing Page Website** | [`https://codevanta-website.vercel.app`](https://codevanta-website.vercel.app) | Official product landing page with iOS & Android download links |
| ⚡ **NestJS Backend API Gateway** | [`https://codevanta-backend-api.onrender.com`](https://codevanta-backend-api.onrender.com) | Render Microservices API Gateway & AI Provider Adapter |
| 📖 **Swagger API Docs** | [`https://codevanta-backend-api.onrender.com/api/docs`](https://codevanta-backend-api.onrender.com/api/docs) | Interactive OpenAPI / Swagger API Documentation |
| 🏥 **Health Telemetry Check** | [`https://codevanta-backend-api.onrender.com/api/v1/health`](https://codevanta-backend-api.onrender.com/api/v1/health) | API Gateway & Database Health Check Endpoint |

---

## 🏛️ Monorepo Workspace Architecture

```text
CODEVANTA MONOREPO
├── apps/
│   ├── mobile/           # Flutter Mobile IDE Client (iOS, Android & Web)
│   │   ├── lib/
│   │   │   ├── core/     # Theme, AppConfig, Termux Launcher, AES-256 Security & Prompt Sanitizer
│   │   │   ├── shared/   # Reusable Atomic UI Component Library
│   │   │   └── features/ # Onboarding, Projects, Editor, Workspace, Search, Git, GitHub, AI, Cloud, Terminal, Extensions, Billing
│   │   └── test/         # 28 Widget & Unit Test Suites (100% Passing)
│   ├── backend/          # NestJS Microservices & AI Gateway API
│   │   ├── src/
│   │   │   ├── core/     # Prisma PostgreSQL & Redis Client Modules
│   │   │   └── modules/  # Auth, Health, GitHub, AI Gateway, Cloud Runner, Subscriptions, Security
│   │   └── test/         # Jest Unit Test Suite (7/7 Suites, 17/17 Tests Passing)
│   └── admin/            # Next.js 14 SaaS Admin Platform
│       └── src/
│           ├── app/      # 24 App Router pages (Dashboard, Users, AI Providers, Security, Subscriptions, Audit)
│           ├── components/ # AdminSidebar, AdminTopNav, AdminShell, Data Tables, Charts
│           └── types/    # Role-Based Access Control (RBAC) Matrix
├── websites/             # Static Marketing & Download Site (HTML5/CSS3)
├── docker-compose.yml     # PostgreSQL 16 & Redis 7 Container Stack
├── README.md             # Platform Documentation & Guide
└── package.json          # Monorepo Workspace Configuration
```

---

## ✨ Key Features & Architecture Highlights

### 🧠 1. Multi-API Key Pooling & AI Gateway Load-Balancing
- **Multi-API Key Pooling**: Admins can configure comma-separated API key pools per provider (e.g. 2 Groq keys, 2 Gemini keys, 2 OpenAI keys) to maximize free API tier limits and prevent `429 Rate Limit` errors.
- **Round-Robin Key Rotation**: Automatically rotates sequentially through available active keys (`getNextApiKey()`) on every prompt execution to distribute load.
- **Smart Fallback Chain**: Automatic cascade routing (Primary Provider -> Fallback 1 -> Fallback 2) if a primary provider hits rate limits or experiences downtime.
- **Supported Adapters**: **Groq** (Llama 3.3 70B), **Google Gemini** (Gemini 1.5 Pro/Flash), **OpenAI** (GPT-4o), **Anthropic** (Claude 3.5 Sonnet), and **OpenRouter**.

### 📱 2. Termux Deep-Linking & Touch Ergonomics
- **Termux Integration**: On Android devices, tapping the Terminal icon automatically launches **Termux** (`termux://open?cd=...`) pointing directly to the active project working directory.
- **Smart Fallback Bottom Sheet**: If Termux is not installed (or running on Web/iOS), CodeVanta prompts the user with options to:
  - ⚡ Launch In-App Cloud Terminal (`TerminalScreen`) with multi-tab shell sessions and the touch **MobileQuickKeyBar** (`Tab`, `Esc`, `Ctrl+C`, `|`, `~`, `$`).
  - 🤖 Download Termux from Google Play Store (`com.termux`).
  - 📦 Download Termux from F-Droid.

### 🎨 3. Design System & Ergonomic Workspace Layouts
- **Curated Color Palette**: Electric Violet (`#6D28D9`), Cyber Cyan (`#22D3EE`), Dark Graphite (`#0B0D12`), Surface Card (`#12141F`).
- **3 Dynamic Workspace Layouts**:
  - **Style A (Classic)**: Desktop IDE layout with Activity Rail, Explorer, Editor Tabs, and AI Panel.
  - **Style B (Minimal)**: Full-screen editor viewport with floating glassmorphic command palette.
  - **Style C (Focus)**: Full-screen gesture-driven editor with edge swipe drawers.

### 💾 4. Local-First Project System & Dynamic File Editor
- **Local File System**: 100% offline file CRUD, project wizards (Dart/Flutter, TypeScript/Node, Python, HTML/CSS/JS, **Solidity / Web3**, Rust, Go, **Other Custom Stacks**), local backup snapshots, and ZIP exports.
- **Code Editor Engine**: Line numbers, dirty file tracking, undo/redo stack, and find & replace bar.

### 🌿 5. Touch-Friendly Git Client & GitHub Sync
- **On-Device Git Client**: Staging/unstaging, `git commit`, branch manager, stash manager, and visual diff viewer.
- **GitHub Platform Integration**: OAuth token exchange, remote repository browser, one-tap clone, issue tracker, and Pull Request manager.

### 👑 6. Production SaaS Admin Dashboard Platform
- **Role-Based Access Control (RBAC)**: 6 granular admin scopes (`SUPER_ADMIN`, `PLATFORM_ADMIN`, `AI_ADMIN`, `BILLING_ADMIN`, `SUPPORT_ADMIN`, `SECURITY_ADMIN`).
- **System Administration**: User account management with suspension toggle, AI provider key manager, cloud environment monitoring, subscription management, security alerts, and immutable audit logs.

---

## 🧪 Quality & Automated Testing Results

```text
========================= MONOREPO VERIFICATION METRICS =========================

1. NestJS Backend Gateway (apps/backend):
   - Test Suites: 7 passed, 7 total (100% Pass Rate)
   - Unit Tests:  17 passed, 17 total
   - Modules:     Auth, Health, GitHub, AI Gateway, Cloud Runner, Subscriptions, Security

2. Next.js Admin Dashboard (apps/admin):
   - Build Status: Compiled successfully (24/24 static pages optimized cleanly)

3. Flutter Mobile IDE (apps/mobile):
   - Static Analysis: flutter analyze -> NO ISSUES FOUND! (0 warnings / 0 errors)
   - Test Suites:     28 passed, 28 total (100% Pass Rate across all feature modules)

================================================================================
```

---

## 💻 Local Development Setup

```bash
# 1. Clone Repository & Install Root Dependencies
git clone https://github.com/Omatsulijoshua/CODEVANTA.git
cd CODEVANTA
npm install

# 2. Run NestJS Backend Gateway API (Port 3000)
cd apps/backend
npm run start:dev

# 3. Run Next.js Admin Dashboard (Port 3001)
cd apps/admin
npm run dev

# 4. Run Flutter Mobile Client (Web / Device)
cd apps/mobile
flutter run -d chrome
```

---

## 🔒 Security & Data Defense

- All developer credentials, OAuth tokens, and secret keys are encrypted at rest using **AES-256-GCM**.
- Built-in **Prompt Injection Defense** automatically redacts raw API key strings (`sk-`, `ghp_`, `bearer`) before prompt payloads are dispatched to LLM providers.
- Local project files and snapshots remain 100% private on-device.

---

© 2026 CodeVanta Team. All rights reserved.
