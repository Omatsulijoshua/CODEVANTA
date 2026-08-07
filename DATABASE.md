# CodeVanta Database & Data Architecture

CodeVanta uses **PostgreSQL 16** with **Prisma ORM** for cloud backend persistence, and **Drift / SQLite** for mobile local storage.

## Core Schema Models (Prisma)
- **User**: Core authentication, identity, global subscription tier.
- **Profile**: Preferences, active theme (e.g., Electric Violet Dark Mode), workspace layout settings.
- **Session & Device**: Refresh token storage, active device tracking, security revokability.
- **Project & ProjectFile**: Cloud-synced project structures and metadata.
- **AIProvider & Agent**: AI agent marketplace registry and provider endpoints.
- **AgentSession**: Conversation history, token counts, model parameters.
- **AuditLog**: Immutable security event logs.

## UUID & Soft Deletion Standards
- Primary keys use v4 UUIDs.
- `createdAt` and `updatedAt` track entity timelines.
- `deletedAt` enables safe soft-deletion for projects and user profiles.
