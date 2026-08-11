'use client';

import React from 'react';
import { AdminShell } from '../../../components/layout/AdminShell';

export default function AiAgentsPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-[#22D3EE]">AI Agent Management & Permissions</h1>
        <p className="text-xs text-slate-400">Configure coding agents, system instructions, tools, and marketplace status</p>
      </div>
    </AdminShell>
  );
}
