'use client';

import React from 'react';
import { AdminShell } from '../../components/layout/AdminShell';

export default function OrganizationsPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-white">Organizations & Teams</h1>
        <p className="text-xs text-slate-400">Manage enterprise organizations, seat limits, and team access</p>
      </div>
    </AdminShell>
  );
}
