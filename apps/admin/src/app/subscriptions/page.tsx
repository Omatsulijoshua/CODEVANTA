'use client';

import React from 'react';
import { AdminShell } from '../../components/layout/AdminShell';

export default function SubscriptionsPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-white">Subscriptions</h1>
        <p className="text-xs text-slate-400">Manage active billing periods, trials, upgrades, and cancellations</p>
      </div>
    </AdminShell>
  );
}
