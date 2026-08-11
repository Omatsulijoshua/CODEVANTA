'use client';

import React from 'react';
import { AdminShell } from '../../components/layout/AdminShell';

export default function SettingsPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-white">System Configuration & Maintenance</h1>
        <p className="text-xs text-slate-400">Manage global platform settings, emergency maintenance mode, and credentials</p>
      </div>
    </AdminShell>
  );
}
