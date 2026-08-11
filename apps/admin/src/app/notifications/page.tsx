'use client';

import React from 'react';
import { AdminShell } from '../../components/layout/AdminShell';

export default function NotificationsPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-white">System Broadcasts & Notifications</h1>
        <p className="text-xs text-slate-400">Schedule in-app alerts, push notifications, and email announcements</p>
      </div>
    </AdminShell>
  );
}
