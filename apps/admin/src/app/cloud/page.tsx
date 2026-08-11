'use client';

import React from 'react';
import { AdminShell } from '../../components/layout/AdminShell';

export default function CloudEnvironmentsPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-white">Cloud Development Environments</h1>
        <p className="text-xs text-slate-400">Monitor active Docker containers, CPU/Memory telemetry, and cost allocation</p>
      </div>
    </AdminShell>
  );
}
