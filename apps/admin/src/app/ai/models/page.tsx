'use client';

import React from 'react';
import { AdminShell } from '../../../components/layout/AdminShell';

export default function AiModelsPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-[#22D3EE]">AI Models & Pricing Matrix</h1>
        <p className="text-xs text-slate-400">Manage model availability, context windows, input/output rates, and capabilities</p>
      </div>
    </AdminShell>
  );
}
