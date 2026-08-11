'use client';

import React from 'react';
import { AdminShell } from '../../components/layout/AdminShell';

export default function PlansPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-white">Tier Plans & Feature Entitlements</h1>
        <p className="text-xs text-slate-400">Configure Free, Pro, AI Pro, Team, and Enterprise quotas</p>
      </div>
    </AdminShell>
  );
}
