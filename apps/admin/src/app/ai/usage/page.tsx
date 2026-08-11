'use client';

import React from 'react';
import { AdminShell } from '../../../components/layout/AdminShell';

export default function AiUsagePage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-[#22D3EE]">AI Token Usage & Cost Management</h1>
        <p className="text-xs text-slate-400">Track token volume, latency, gross margins, and provider costs</p>
      </div>
    </AdminShell>
  );
}
