'use client';

import React, { useState } from 'react';
import { Search, Bell, Shield, Activity, User, Command } from 'lucide-react';

export function AdminTopNav() {
  const [searchQuery, setSearchQuery] = useState('');

  return (
    <header className="h-16 bg-[#0B0D12]/80 backdrop-blur-md border-b border-[#1E2235] px-6 flex items-center justify-between sticky top-0 z-30">
      {/* Global Search Bar */}
      <div className="relative w-96">
        <Search className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
        <input
          type="text"
          placeholder="Global Search (Users, Orgs, Agents, Audit)..."
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          className="w-full pl-9 pr-12 py-2 bg-[#12141F] border border-[#1E2235] rounded-lg text-xs text-white placeholder-slate-500 focus:outline-none focus:border-[#8B5CF6] transition-all"
        />
        <div className="absolute right-3 top-1/2 -translate-y-1/2 flex items-center gap-0.5 text-[10px] text-slate-500 bg-[#0B0D12] px-1.5 py-0.5 rounded border border-[#1E2235]">
          <Command className="w-2.5 h-2.5" /> K
        </div>
      </div>

      {/* Right Controls */}
      <div className="flex items-center gap-4">
        {/* Environment Badge */}
        <span className="px-2.5 py-1 bg-[#8B5CF6]/10 text-[#8B5CF6] border border-[#8B5CF6]/30 text-[10px] font-bold rounded-md tracking-wider">
          PRODUCTION
        </span>

        {/* System Health Status Indicator */}
        <div className="flex items-center gap-2 px-3 py-1 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 rounded-md text-xs font-semibold">
          <span className="w-2 h-2 rounded-full bg-emerald-400 animate-pulse" />
          <span>OPERATIONAL</span>
        </div>

        {/* Notifications Icon */}
        <button className="relative p-2 text-slate-400 hover:text-white hover:bg-[#12141F] rounded-lg border border-transparent hover:border-[#1E2235] transition">
          <Bell className="w-4 h-4" />
          <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-[#22D3EE] rounded-full" />
        </button>

        {/* Admin Avatar */}
        <div className="w-8 h-8 rounded-full bg-[#6D28D9] flex items-center justify-center text-white font-bold text-xs shadow-md border border-[#8B5CF6]/40 cursor-pointer">
          JD
        </div>
      </div>
    </header>
  );
}
