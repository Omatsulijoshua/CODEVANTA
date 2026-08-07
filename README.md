# ⚡ CODEVANTA — MOBILE AI DEVELOPMENT IDE
### *"YOUR IDE. YOUR CODE. YOUR AI."*

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/Omatsulijoshua/CODEVANTA)
[![Backend API](https://img.shields.io/badge/NestJS-v10.3.0-E0234E.svg)](https://codevanta-backend-api.onrender.com/api/docs)
[![Mobile Engine](https://img.shields.io/badge/Flutter-v3.44+-02569B.svg)](https://github.com/Omatsulijoshua/CODEVANTA)
[![Admin Control](https://img.shields.io/badge/Next.js-v14.2.35-000000.svg)](https://github.com/Omatsulijoshua/CODEVANTA)
[![License](https://img.shields.io/badge/license-UNLICENSED-purple.svg)](https://github.com/Omatsulijoshua/CODEVANTA)

CodeVanta is a professional, mobile-first development environment built for iPhone, iPad, Android, and Web, inspired by desktop workflows (VS Code, Sublime Text) but engineered specifically for touchscreens, external keyboards, and autonomous mobile AI workflows.

---

## 🌐 Live Production API & Deployment Links

- 🚀 **Live NestJS Backend API (Render)**: [`https://codevanta-backend-api.onrender.com`](https://codevanta-backend-api.onrender.com)
- 📖 **API Swagger Documentation**: [`https://codevanta-backend-api.onrender.com/api/docs`](https://codevanta-backend-api.onrender.com/api/docs)
- 🏥 **Health Telemetry Check**: [`https://codevanta-backend-api.onrender.com/api/v1/health`](https://codevanta-backend-api.onrender.com/api/v1/health)

---

## 🏛️ Monorepo Workspace Structure

```
CODEVANTA MONOREPO
├── apps/
│   ├── mobile/           # Flutter Mobile Client (iOS, Android & Web)
│   │   ├── lib/
│   │   │   ├── core/     # Theme, AppConfig (Render API), AES-256 Security & Prompt Sanitizer
│   │   │   ├── shared/   # Reusable Atomic UI Component Library
│   │   │   └── features/ # Projects, Editor, Workspace, Search, Git, GitHub, AI, Cloud, Terminal, Palette, Extensions, Billing
│   │   └── test/         # 27 Widget & Unit Test Suites (100% Passing)
│   ├── backend/          # NestJS Microservice API Gateway
│   │   ├── src/
│   │   │   ├── core/     # Prisma PostgreSQL & Redis Client Modules
│   │   │   └── modules/  # Auth, Health, GitHub, AI Gateway, Cloud Runner, Subscriptions, Security
│   │   └── test/         # Jest Unit Test Suite (7/7 Suites, 18/18 Tests Passing)
│   └── admin/            # Next.js 14 Web Admin Control Panel
│       └── src/app/      # Overview Telemetry, User Management & AI Provider Credentials
├── docker-compose.yml     # PostgreSQL 16 & Redis 7 Container Stack
├── README.md             # Project Documentation & Deployment Guide
└── package.json          # Monorepo Workspace Configuration
```

---

## ✨ Features & Architecture Highlights

### 🎨 1. Design System & Ergonomics
- **Curated Color Tokens**: Electric Violet (`#6E00FF`), Cyber Cyan (`#00F0FF`), Dark Graphite (`#12121A`), Warning Amber (`#FFB800`), Success Green (`#00E676`).
- **Modern Typography**: Google Fonts `Inter` for interface elements and `Fira Code` for code syntax highlighting.
- **Responsive Layout Switcher**:
  - **Style A (Classic)**: Professional desktop IDE rail, collapsible file explorer, editor tabs, and AI panel.
  - **Style B (Minimal)**: Full-screen editor viewport with floating glassmorphic action palette.
  - **Style C (Focus)**: Full-screen gesture-driven editor with iOS edge swipe drawers.

### 💾 2. Local-First Project System & Code Editor
- **Local File System**: 100% offline file CRUD, project creation wizards, local backup snapshots, and `.zip` archive exports.
- **Code Editor Engine**: High-performance syntax highlighter supporting 20+ programming languages, line numbers, dirty file tracking, undo/redo stack, and find & replace all.

### 🌿 3. Touch-Friendly Git Client & GitHub Sync
- **On-Device Git Client**: `git init`, file staging/unstaging, `git commit`, branch management, stash manager, commit log timeline, and side-by-side visual diff viewer.
- **GitHub Platform Integration**: GitHub OAuth token exchange, remote repository browser, one-tap clone, issue tracker, and Pull Request manager with one-tap merge.

### 🤖 4. Multi-Provider AI Gateway & Autonomous Code Agent
- **AI Gateway Platform**: Standardized agent protocol adapter supporting **OpenAI** (GPT-4o), **Anthropic** (Claude 3.5 Sonnet), **Google Gemini** (Gemini 1.5 Pro), and **OpenRouter** (for any custom or open-weights model).
- **AI Chat & Context Engine**: Multi-session conversation history, context attachment pills (`@file`, `@folder`, `@selection`, `@terminal`, `@error`), and one-tap "Apply to File" triggers.
- **Autonomous AI Code Agent**: Granular security permission scopes (`READ`, `SEARCH`, `EDIT`, `CREATE`, `DELETE`, `TERMINAL`, `NETWORK`), pre-edit snapshot recovery, and visual diff review screens (`Accept File`, `Reject File`, `Rollback`).

### ☁️ 5. Cloud Runner & Terminal Engine
- **Cloud Sandbox Execution**: Remote Docker container provisioning, live WebSocket stdout/stderr log streaming, and container resource telemetry bar (vCPU %, RAM MB, mapped web ports).
- **Mobile Terminal**: Multi-tab shell sessions, ANSI color output, command history, and a touch **MobileQuickKeyBar** (`Tab`, `Esc`, `Ctrl+C`, `|`, `/`, `-`, `~`, `$`, `Up`, `Down`, `Left`, `Right`).

### 🧩 6. Extension System, Billing & Admin Control
- **Extension Marketplace**: Extension manifests (`ID`, `publisher`, `permissions`), sandboxed runtime execution, and marketplace discovery for Themes, Syntax, AI Agents, and Tools.
- **Monetization Tiers**: Free, Pro (\$19/mo), and Team (\$49/mo) plans, Stripe checkout, usage meters, and Paywall modal.
- **Next.js 14 Admin Panel**: Executive KPI metrics (Total Users, DAU, MRR, AI Tokens), User account management with suspension toggle, AI provider API key configuration, and real-time infrastructure telemetry.

---

## 🧪 Quality & Automated Testing Results

```
========================= MONOREPO VERIFICATION SUMMARY =========================

1. NestJS Backend Gateway (apps/backend):
   - Test Suites: 7 passed, 7 total
   - Unit Tests:  18 passed, 18 total (100% Pass Rate)
   - Modules:     Auth, Health, GitHub, AI Gateway, Cloud Runner, Subscriptions, Security

2. Next.js Admin Panel (apps/admin):
   - Build Status: Compiled successfully (4/4 static pages optimized)

3. Flutter Mobile IDE (apps/mobile):
   - Static Analysis: flutter analyze -> NO ISSUES FOUND! (0 warnings / 0 errors)
   - Test Suites:     27 passed, 27 total (100% Pass Rate across all features)

================================================================================
```

---

## 🚀 Deployment Instructions

### 1. Render Deployment (NestJS Backend API)
- **Root Directory**: `apps/backend`
- **Build Command**: `npm ci --include=dev && npx prisma generate && npm run build`
- **Start Command**: `npx prisma db push && npm run start:prod`
- **Environment Variables**:
  - `NODE_ENV`: `production`
  - `PORT`: `3000`
  - `DATABASE_URL`: `postgresql://codevanta:password@host:5432/codevanta_db`
  - `JWT_SECRET`: `codevanta_super_secret_jwt_key_prod_2026`

### 2. Vercel Deployment (Next.js Admin Dashboard)
- **Framework Preset**: Next.js
- **Root Directory**: `apps/admin`
- **Build Command**: `npm run build`
- Configuration file included in [`apps/admin/vercel.json`](file:///c:/Users/Joshua/Desktop/My%20Projects/apps/CODEVANTA/apps/admin/vercel.json).

### 3. Vercel Deployment (Flutter Web Mobile Client)
- **Framework Preset**: Other
- **Root Directory**: `apps/mobile`
- **Build Command**: `flutter build web`
- Configuration file included in [`apps/mobile/vercel.json`](file:///c:/Users/Joshua/Desktop/My%20Projects/apps/CODEVANTA/apps/mobile/vercel.json).

---

## 🔒 Security & Privacy

- All developer credentials, OAuth tokens, and secret keys are encrypted at rest using **AES-256-GCM**.
- Built-in **Prompt Injection Defense** automatically redacts raw API key strings (`sk-`, `ghp_`, `bearer`) before prompt payloads are dispatched to LLM providers.
- Local project files and snapshots remain 100% private on-device.

---

© 2026 CodeVanta Team. All rights reserved.
