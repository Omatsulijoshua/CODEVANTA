'use client';

import React from 'react';
import { AdminShell } from '../../components/layout/AdminShell';

export default function ExtensionsPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-white">Marketplace Extensions & Plugins</h1>
        <p className="text-xs text-slate-400">Review submitted extension manifests, security scan reports, and approval status</p>
      </div>
    </AdminShell>
  );
}
