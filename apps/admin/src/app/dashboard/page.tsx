'use client';

import React from 'react';
import { AdminShell } from '../../components/layout/AdminShell';
import { Users, DollarSign, Cpu, Activity, Server } from 'lucide-react';

export default function DashboardPage() {
  return (
    <AdminShell>
      <div className="space-y-8">
        {/* Page Header */}
        <div>
          <h1 className="text-2xl font-extrabold text-white">Platform Operational Overview</h1>
          <p className="text-xs text-slate-400">Real-time metrics, telemetry, and infrastructure health</p>
        </div>

        {/* Top Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <div className="p-6 bg-[#12141F] rounded-xl border border-[#1E2235]">
            <div className="flex justify-between items-center mb-4">
              <span className="text-xs font-semibold text-slate-400">Total Users & DAU</span>
              <Users className="w-5 h-5 text-[#8B5CF6]" />
            </div>
            <div className="text-3xl font-extrabold text-white">12,480</div>
            <p className="text-xs text-emerald-400 mt-2 font-medium">3,420 Active Daily (DAU)</p>
          </div>

          <div className="p-6 bg-[#12141F] rounded-xl border border-[#1E2235]">
            <div className="flex justify-between items-center mb-4">
              <span className="text-xs font-semibold text-slate-400">Monthly Recurring (MRR)</span>
              <DollarSign className="w-5 h-5 text-emerald-400" />
            </div>
            <div className="text-3xl font-extrabold text-emerald-400">$42,800</div>
            <p className="text-xs text-emerald-400 mt-2 font-medium">+18% growth from last month</p>
          </div>

          <div className="p-6 bg-[#12141F] rounded-xl border border-[#1E2235]">
            <div className="flex justify-between items-center mb-4">
              <span className="text-xs font-semibold text-slate-400">AI Tokens Processed</span>
              <Cpu className="w-5 h-5 text-[#22D3EE]" />
            </div>
            <div className="text-3xl font-extrabold text-white">48.2M</div>
            <p className="text-xs text-slate-400 mt-2">Across 4 AI Adapters</p>
          </div>

          <div className="p-6 bg-[#12141F] rounded-xl border border-[#1E2235]">
            <div className="flex justify-between items-center mb-4">
              <span className="text-xs font-semibold text-slate-400">Cloud Sandbox Envs</span>
              <Activity className="w-5 h-5 text-purple-400" />
            </div>
            <div className="text-3xl font-extrabold text-white">42</div>
            <p className="text-xs text-slate-400 mt-2">Active runner containers</p>
          </div>
        </div>

        {/* System Health */}
        <div className="p-6 bg-[#12141F] rounded-xl border border-[#1E2235] space-y-4">
          <h2 className="text-base font-bold flex items-center gap-2 text-white">
            <Server className="w-5 h-5 text-[#8B5CF6]" /> Infrastructure Telemetry
          </h2>
          <div className="space-y-3">
            <div className="flex items-center justify-between p-4 bg-[#0B0D12] rounded-lg border border-[#1E2235]">
              <div>
                <p className="font-semibold text-sm text-white">NestJS API Gateway (Render)</p>
                <p className="text-xs text-slate-400">https://codevanta-backend-api.onrender.com/api/v1/health (Latency: 14ms)</p>
              </div>
              <span className="px-3 py-1 bg-emerald-500/10 text-emerald-400 text-xs font-bold rounded-md border border-emerald-500/20">OPERATIONAL</span>
            </div>
          </div>
        </div>
      </div>
    </AdminShell>
  );
}
