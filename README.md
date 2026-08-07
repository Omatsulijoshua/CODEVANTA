# CODEVANTA — Mobile AI Development IDE

> **"YOUR IDE. YOUR CODE. YOUR AI."**

CodeVanta is a professional, mobile-first AI-native development environment for iPhone, iPad, Android, Web, and Desktop. Inspired by modern desktop IDE workflows, designed specifically for touchscreens, external keyboards, and mobile remote development.

---

## 🚀 Features

- **Local-First Code Editing**: Full offline source code management, local snapshots, and zero mandatory cloud lock-in for core editing.
- **AI Coding Agent Platform**: Multi-provider agent orchestration (OpenAI, Anthropic, Google Gemini, OpenRouter) with strict permission scopes (READ, PLAN, EDIT, AGENT, REVIEW).
- **Workspace Styles**: Switch between **Classic** (desktop-style layout), **Minimal**, and **Focus** modes.
- **Git & GitHub Integration**: Touch-friendly Git client with status, branches, diffs, commits, and GitHub PR workflows.
- **Cloud Development Environments**: Isolated remote containers for running Node.js, Python, Flutter, Go, Rust, and live web previews.
- **Web Admin Dashboard**: Dedicated administrative platform for managing users, subscriptions, AI usage metrics, and audit logs.

---

## 🏗 Repository Structure

```
CODEVANTA/
├── apps/
│   ├── mobile/     # Flutter mobile application
│   ├── backend/    # NestJS REST & WebSocket API Gateway
│   └── admin/      # Next.js 14 Admin Dashboard
├── docker-compose.yml
└── ARCHITECTURE.md
```

---

## 🛠 Quick Start (Phase 0)

### 1. Prerequisites
- Node.js `^24.0.0`
- Flutter `^3.44.0`
- Docker Desktop (for PostgreSQL & Redis)

### 2. Start Local Database Services
```bash
docker-compose up -d
```

### 3. Start Backend API
```bash
cd apps/backend
npm install
npx prisma migrate dev
npm run start:dev
```

### 4. Start Mobile App
```bash
cd apps/mobile
flutter pub get
flutter run
```

### 5. Start Admin Dashboard
```bash
cd apps/admin
npm install
npm run dev
```
