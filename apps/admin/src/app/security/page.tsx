'use client';

import React from 'react';
import { AdminShell } from '../../components/layout/AdminShell';

export default function SecurityPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-[#8B5CF6]">Security Center & Threat Intelligence</h1>
        <p className="text-xs text-slate-400">Monitor suspicious logins, token abuse alerts, and prompt injection defense</p>
      </div>
    </AdminShell>
  );
}
