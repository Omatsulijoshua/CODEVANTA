# CodeVanta System Architecture

CodeVanta is designed as a hybrid local-first mobile client connected to a secure, multi-tenant cloud backend.

```
                          ┌───────────────────────────┐
                          │    CodeVanta Mobile App   │
                          │   (Flutter / Riverpod)    │
                          └─────────────┬─────────────┘
                                        │
                         ┌──────────────┴──────────────┐
                         │  NestJS AI Gateway Backend  │
                         └──────┬──────────────┬───────┘
                                │              │
                   ┌────────────┴───┐     ┌────┴─────────────┐
                   │ PostgreSQL DB  │     │ Redis Queue/Cache│
                   └────────────────┘     └──────────────────┘
```

## Core Principles
1. **Local-First Core**: File editing, syntax highlighting, search, and local snapshots function offline.
2. **Provider Abstraction**: AI agents communicate via a unified API gateway without hard-coded provider SDKs on client.
3. **Sandbox Security**: Secure remote execution containers handle terminal execution and builds that cannot run in the iOS sandbox.
4. **Entitlements Gatekeeping**: Server-enforced feature flags and usage tracking dictate access to premium providers and cloud compute resources.
