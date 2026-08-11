'use client';

import React from 'react';
import { AdminShell } from '../../components/layout/AdminShell';

export default function SupportPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-white">Support Desk & Incident Tickets</h1>
        <p className="text-xs text-slate-400">Resolve developer inquiries, account recoveries, and system tickets</p>
      </div>
    </AdminShell>
  );
}
