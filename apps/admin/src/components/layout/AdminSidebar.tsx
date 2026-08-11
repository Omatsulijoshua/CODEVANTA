'use client';

import React from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import {
  LayoutDashboard,
  Users,
  Building2,
  CreditCard,
  Layers,
  DollarSign,
  Cpu,
  Bot,
  Key,
  Sparkles,
  BarChart2,
  Cloud,
  GitBranch,
  Package,
  Bell,
  LifeBuoy,
  TrendingUp,
  ShieldCheck,
  FileText,
  Settings,
  LogOut,
  ChevronRight,
} from 'lucide-react';
import { ADMIN_NAV_ITEMS } from '../../constants/navigation';
import { AdminRole } from '../../types/admin';

const ICON_MAP: Record<string, React.ComponentType<{ className?: string }>> = {
  LayoutDashboard,
  Users,
  Building2,
  CreditCard,
  Layers,
  DollarSign,
  Cpu,
  Bot,
  Key,
  Sparkles,
  BarChart2,
  Cloud,
  GitBranch,
  Package,
  Bell,
  LifeBuoy,
  TrendingUp,
  ShieldCheck,
  FileText,
  Settings,
};

interface AdminSidebarProps {
  currentRole?: AdminRole;
  adminName?: string;
  adminEmail?: string;
}

export function AdminSidebar({
  currentRole = 'SUPER_ADMIN',
  adminName = 'Joshua Dev',
  adminEmail = 'joshua@codevanta.app',
}: AdminSidebarProps) {
  const pathname = usePathname();

  return (
    <aside className="w-64 bg-[#0B0D12] border-r border-[#1E2235] flex flex-col h-screen sticky top-0 select-none">
      {/* Brand Header */}
      <div className="p-6 border-b border-[#1E2235] flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="w-9 h-9 rounded-xl bg-gradient-to-br from-[#6D28D9] to-[#8B5CF6] flex items-center justify-center font-black text-white text-xl shadow-lg shadow-[#6D28D9]/30">
            V
          </div>
          <div>
            <div className="font-extrabold text-sm tracking-wider text-white">CODEVANTA</div>
            <div className="text-[10px] font-semibold text-[#22D3EE] tracking-widest uppercase">Admin Platform</div>
          </div>
        </div>
      </div>

      {/* Navigation Menu */}
      <nav className="flex-1 p-4 overflow-y-auto space-y-1">
        {ADMIN_NAV_ITEMS.map((item) => {
          const IconComp = ICON_MAP[item.icon] || LayoutDashboard;
          const isActive = pathname === item.href || pathname.startsWith(item.href + '/');

          return (
            <div key={item.href}>
              <Link
                href={item.href}
                className={`flex items-center justify-between px-3 py-2.5 rounded-lg text-xs font-semibold transition-all duration-150 ${
                  isActive
                    ? 'bg-[#6D28D9] text-white shadow-md shadow-[#6D28D9]/20'
                    : 'text-slate-400 hover:text-white hover:bg-[#12141F]'
                }`}
              >
                <div className="flex items-center gap-3">
                  <IconComp className={`w-4 h-4 ${isActive ? 'text-[#22D3EE]' : 'text-slate-400'}`} />
                  <span>{item.title}</span>
                </div>
                {item.children && <ChevronRight className="w-3 h-3 text-slate-500" />}
              </Link>
            </div>
          );
        })}
      </nav>

      {/* Bottom Profile Footer */}
      <div className="p-4 border-t border-[#1E2235] bg-[#12141F]/50">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 rounded-full bg-[#8B5CF6]/20 border border-[#8B5CF6]/40 flex items-center justify-center font-bold text-xs text-[#22D3EE]">
              {adminName.substring(0, 2).toUpperCase()}
            </div>
            <div className="overflow-hidden">
              <div className="text-xs font-bold text-white truncate">{adminName}</div>
              <div className="text-[10px] font-mono text-[#8B5CF6] truncate">{currentRole}</div>
            </div>
          </div>
          <Link href="/login" className="p-1.5 text-slate-400 hover:text-red-400 hover:bg-red-500/10 rounded-md transition">
            <LogOut className="w-4 h-4" />
          </Link>
        </div>
      </div>
    </aside>
  );
}
