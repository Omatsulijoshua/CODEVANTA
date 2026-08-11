'use client';

import React from 'react';
import { AdminShell } from '../../components/layout/AdminShell';

export default function GitHubIntegrationsPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-white">GitHub OAuth Integration Metadata</h1>
        <p className="text-xs text-slate-400">View connected GitHub accounts, sync status, and repository counts</p>
      </div>
    </AdminShell>
  );
}
