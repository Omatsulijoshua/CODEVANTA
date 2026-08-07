'use client';

import React, { useState } from 'react';
import { Shield, Users, Cpu, Activity, DollarSign, Key, Server } from 'lucide-react';

export default function AdminDashboardPage() {
  const [activeTab, setActiveTab] = useState<'overview' | 'users' | 'providers'>('overview');
  const [searchQuery, setSearchQuery] = useState('');

  const [users, setUsers] = useState([
    { id: 'usr-1', name: 'Alex Johnson', email: 'alex@codevanta.app', tier: 'PRO', status: 'ACTIVE', aiTokens: '1.4M' },
    { id: 'usr-2', name: 'Joshua Dev', email: 'joshua@codevanta.app', tier: 'TEAM', status: 'ACTIVE', aiTokens: '4.8M' },
    { id: 'usr-3', name: 'Demo Test', email: 'demo@test.com', tier: 'FREE', status: 'SUSPENDED', aiTokens: '120K' },
  ]);

  const filteredUsers = users.filter((u) => u.name.toLowerCase().includes(searchQuery.toLowerCase()) || u.email.toLowerCase().includes(searchQuery.toLowerCase()));

  const toggleUserStatus = (id: string) => {
    setUsers((prev) =>
      prev.map((u) => (u.id === id ? { ...u, status: u.status === 'ACTIVE' ? 'SUSPENDED' : 'ACTIVE' } : u))
    );
  };

  return (
    <div className="min-h-screen flex flex-col bg-[#12121A] text-white">
      {/* Top Header */}
      <header className="border-b border-[#2A2A3C] px-8 py-4 flex justify-between items-center bg-[#1A1A26]">
        <div className="flex items-center gap-3">
          <div className="w-9 h-9 rounded-lg bg-[#6E00FF] flex items-center justify-center font-bold text-white text-xl">
            V
          </div>
          <div>
            <h1 className="font-bold text-lg text-white">CODEVANTA ADMIN</h1>
            <p className="text-xs text-gray-400">Control Panel & AI Telemetry</p>
          </div>
        </div>

        {/* Navigation Tabs */}
        <div className="flex items-center gap-2 bg-[#12121A] p-1 rounded-lg border border-[#2A2A3C]">
          <button
            onClick={() => setActiveTab('overview')}
            className={`px-4 py-1.5 rounded-md text-xs font-semibold transition ${activeTab === 'overview' ? 'bg-[#6E00FF] text-white' : 'text-gray-400 hover:text-white'}`}
          >
            Overview
          </button>
          <button
            onClick={() => setActiveTab('users')}
            className={`px-4 py-1.5 rounded-md text-xs font-semibold transition ${activeTab === 'users' ? 'bg-[#6E00FF] text-white' : 'text-gray-400 hover:text-white'}`}
          >
            Users
          </button>
          <button
            onClick={() => setActiveTab('providers')}
            className={`px-4 py-1.5 rounded-md text-xs font-semibold transition ${activeTab === 'providers' ? 'bg-[#6E00FF] text-white' : 'text-gray-400 hover:text-white'}`}
          >
            AI Providers
          </button>
        </div>

        <div className="flex items-center gap-4">
          <span className="px-3 py-1 bg-green-500/10 text-green-400 text-xs rounded-full border border-green-500/20 font-medium flex items-center gap-1.5">
            <span className="w-2 h-2 rounded-full bg-green-400 animate-pulse"></span>
            System Online
          </span>
        </div>
      </header>

      {/* Main Dashboard Content */}
      <main className="flex-1 p-8 max-w-7xl mx-auto w-full space-y-8">
        {/* Metric Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <div className="p-6 bg-[#1A1A26] rounded-xl border border-[#2A2A3C]">
            <div className="flex justify-between items-center mb-4">
              <span className="text-sm font-medium text-gray-400">Total Users & DAU</span>
              <Users className="w-5 h-5 text-[#6E00FF]" />
            </div>
            <div className="text-3xl font-extrabold">12,480</div>
            <p className="text-xs text-green-400 mt-2">3,420 Active Daily (DAU)</p>
          </div>

          <div className="p-6 bg-[#1A1A26] rounded-xl border border-[#2A2A3C]">
            <div className="flex justify-between items-center mb-4">
              <span className="text-sm font-medium text-gray-400">Monthly Recurring (MRR)</span>
              <DollarSign className="w-5 h-5 text-emerald-400" />
            </div>
            <div className="text-3xl font-extrabold text-emerald-400">$42,800</div>
            <p className="text-xs text-green-400 mt-2">+18% growth from last month</p>
          </div>

          <div className="p-6 bg-[#1A1A26] rounded-xl border border-[#2A2A3C]">
            <div className="flex justify-between items-center mb-4">
              <span className="text-sm font-medium text-gray-400">AI Tokens Processed</span>
              <Cpu className="w-5 h-5 text-[#00F0FF]" />
            </div>
            <div className="text-3xl font-extrabold">48.2M</div>
            <p className="text-xs text-gray-400 mt-2">Across 4 AI Adapters</p>
          </div>

          <div className="p-6 bg-[#1A1A26] rounded-xl border border-[#2A2A3C]">
            <div className="flex justify-between items-center mb-4">
              <span className="text-sm font-medium text-gray-400">Cloud Sandbox Envs</span>
              <Activity className="w-5 h-5 text-purple-400" />
            </div>
            <div className="text-3xl font-extrabold">42</div>
            <p className="text-xs text-gray-400 mt-2">Active runner containers</p>
          </div>
        </div>

        {/* Tab View: Overview */}
        {activeTab === 'overview' && (
          <div className="p-6 bg-[#1A1A26] rounded-xl border border-[#2A2A3C]">
            <h2 className="text-lg font-bold mb-4 flex items-center gap-2">
              <Server className="w-5 h-5 text-[#6E00FF]" />
              System Health & Infrastructure Telemetry
            </h2>
            <div className="space-y-4">
              <div className="flex items-center justify-between p-4 bg-[#12121A] rounded-lg border border-[#2A2A3C]">
                <div>
                  <p className="font-semibold text-white">NestJS API Gateway</p>
                  <p className="text-xs text-gray-400">http://localhost:3000/api/v1/health (Latency: 14ms)</p>
                </div>
                <span className="px-3 py-1 bg-emerald-500/10 text-emerald-400 text-xs rounded-full border border-emerald-500/20 font-semibold">
                  OPERATIONAL
                </span>
              </div>

              <div className="flex items-center justify-between p-4 bg-[#12121A] rounded-lg border border-[#2A2A3C]">
                <div>
                  <p className="font-semibold text-white">PostgreSQL Database (Prisma Pool)</p>
                  <p className="text-xs text-gray-400">codevanta_db (Connection Pool: 12/50 active)</p>
                </div>
                <span className="px-3 py-1 bg-emerald-500/10 text-emerald-400 text-xs rounded-full border border-emerald-500/20 font-semibold">
                  CONNECTED
                </span>
              </div>

              <div className="flex items-center justify-between p-4 bg-[#12121A] rounded-lg border border-[#2A2A3C]">
                <div>
                  <p className="font-semibold text-white">Redis Queue & Cache Store</p>
                  <p className="text-xs text-gray-400">localhost:6379 (Memory: 84 MB)</p>
                </div>
                <span className="px-3 py-1 bg-emerald-500/10 text-emerald-400 text-xs rounded-full border border-emerald-500/20 font-semibold">
                  CONNECTED
                </span>
              </div>
            </div>
          </div>
        )}

        {/* Tab View: Users */}
        {activeTab === 'users' && (
          <div className="p-6 bg-[#1A1A26] rounded-xl border border-[#2A2A3C] space-y-4">
            <div className="flex justify-between items-center">
              <h2 className="text-lg font-bold">User Account Management</h2>
              <input
                type="text"
                placeholder="Search user name or email..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="px-4 py-2 bg-[#12121A] border border-[#2A2A3C] rounded-lg text-sm w-72 text-white focus:outline-none focus:border-[#6E00FF]"
              />
            </div>

            <div className="overflow-x-auto">
              <table className="w-full text-left text-sm border-collapse">
                <thead>
                  <tr className="border-b border-[#2A2A3C] text-gray-400">
                    <th className="py-3 px-4">User</th>
                    <th className="py-3 px-4">Tier</th>
                    <th className="py-3 px-4">AI Tokens</th>
                    <th className="py-3 px-4">Status</th>
                    <th className="py-3 px-4 text-right">Actions</th>
                  </tr>
                </thead>
                <tbody>
                  {filteredUsers.map((user) => (
                    <tr key={user.id} className="border-b border-[#2A2A3C]/50 hover:bg-[#12121A]/50 transition">
                      <td className="py-3 px-4">
                        <div className="font-semibold">{user.name}</div>
                        <div className="text-xs text-gray-400">{user.email}</div>
                      </td>
                      <td className="py-3 px-4">
                        <span className="px-2.5 py-1 bg-[#6E00FF]/20 text-[#00F0FF] text-xs font-bold rounded">
                          {user.tier}
                        </span>
                      </td>
                      <td className="py-3 px-4 font-mono">{user.aiTokens}</td>
                      <td className="py-3 px-4">
                        <span className={`px-2.5 py-1 text-xs font-semibold rounded ${user.status === 'ACTIVE' ? 'bg-emerald-500/20 text-emerald-400' : 'bg-red-500/20 text-red-400'}`}>
                          {user.status}
                        </span>
                      </td>
                      <td className="py-3 px-4 text-right">
                        <button
                          onClick={() => toggleUserStatus(user.id)}
                          className="px-3 py-1 bg-[#2A2A3C] hover:bg-[#3A3A4C] text-xs rounded transition"
                        >
                          {user.status === 'ACTIVE' ? 'Suspend' : 'Activate'}
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* Tab View: AI Providers */}
        {activeTab === 'providers' && (
          <div className="p-6 bg-[#1A1A26] rounded-xl border border-[#2A2A3C] space-y-6">
            <h2 className="text-lg font-bold flex items-center gap-2">
              <Key className="w-5 h-5 text-[#6E00FF]" />
              AI Gateway Credentials & Model Availability
            </h2>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="p-4 bg-[#12121A] rounded-lg border border-[#2A2A3C] space-y-3">
                <div className="flex justify-between items-center">
                  <span className="font-bold">OpenAI Adapter</span>
                  <span className="text-xs px-2 py-0.5 bg-emerald-500/20 text-emerald-400 rounded">CONFIGURED</span>
                </div>
                <input type="password" value="sk-proj-xxxxxxxxxxxxxxxxxxxx" readOnly className="w-full px-3 py-1.5 bg-[#1A1A26] border border-[#2A2A3C] rounded text-xs font-mono" />
                <p className="text-xs text-gray-400">Models: gpt-4o, gpt-4-turbo</p>
              </div>

              <div className="p-4 bg-[#12121A] rounded-lg border border-[#2A2A3C] space-y-3">
                <div className="flex justify-between items-center">
                  <span className="font-bold">Anthropic Adapter</span>
                  <span className="text-xs px-2 py-0.5 bg-emerald-500/20 text-emerald-400 rounded">CONFIGURED</span>
                </div>
                <input type="password" value="sk-ant-xxxxxxxxxxxxxxxxxxxx" readOnly className="w-full px-3 py-1.5 bg-[#1A1A26] border border-[#2A2A3C] rounded text-xs font-mono" />
                <p className="text-xs text-gray-400">Models: claude-3-5-sonnet, claude-3-opus</p>
              </div>
            </div>
          </div>
        )}
      </main>
    </div>
  );
}

