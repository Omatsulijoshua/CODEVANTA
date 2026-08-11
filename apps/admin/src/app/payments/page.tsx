'use client';

import React from 'react';
import { AdminShell } from '../../components/layout/AdminShell';

export default function PaymentsPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-white">Transactions & Payments</h1>
        <p className="text-xs text-slate-400">View Stripe transactions, refunds, chargebacks, and revenue events</p>
      </div>
    </AdminShell>
  );
}
