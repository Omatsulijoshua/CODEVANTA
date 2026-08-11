'use client';

import React, { useState } from 'react';
import { useRouter } from 'next/navigation';
import { ShieldCheck, Lock, Mail, Key, ArrowRight } from 'lucide-react';

export default function AdminLoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState('admin@codevanta.app');
  const [password, setPassword] = useState('••••••••••••');
  const [mfaCode, setMfaCode] = useState('');
  const [showMfa, setShowMfa] = useState(false);
  const [selectedRole, setSelectedRole] = useState('SUPER_ADMIN');

  const handleLoginSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!showMfa) {
      setShowMfa(true);
      return;
    }
    router.push('/dashboard');
  };

  return (
    <div className="min-h-screen bg-[#0B0D12] flex items-center justify-center p-4">
      <div className="w-full max-w-md bg-[#12141F] border border-[#1E2235] rounded-2xl p-8 shadow-2xl space-y-6 relative overflow-hidden">
        {/* Background Ambient Glow */}
        <div className="absolute -top-24 -right-24 w-48 h-48 bg-[#6D28D9]/20 blur-3xl rounded-full pointer-events-none" />

        {/* Brand Header */}
        <div className="text-center space-y-2">
          <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-[#6D28D9] to-[#8B5CF6] flex items-center justify-center text-white font-black text-2xl mx-auto shadow-lg shadow-[#6D28D9]/30">
            V
          </div>
          <h1 className="text-xl font-extrabold text-white tracking-wide">CODEVANTA ADMIN</h1>
          <p className="text-xs text-slate-400">Authorized Personnel Management Gateway</p>
        </div>

        {/* Form */}
        <form onSubmit={handleLoginSubmit} className="space-y-4">
          <div>
            <label className="block text-xs font-semibold text-slate-300 mb-1.5">Admin Email</label>
            <div className="relative">
              <Mail className="w-4 h-4 text-slate-500 absolute left-3 top-1/2 -translate-y-1/2" />
              <input
                type="email"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="w-full pl-9 pr-4 py-2.5 bg-[#0B0D12] border border-[#1E2235] rounded-lg text-xs text-white focus:outline-none focus:border-[#8B5CF6] transition"
              />
            </div>
          </div>

          <div>
            <label className="block text-xs font-semibold text-slate-300 mb-1.5">Password</label>
            <div className="relative">
              <Lock className="w-4 h-4 text-slate-500 absolute left-3 top-1/2 -translate-y-1/2" />
              <input
                type="password"
                required
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="w-full pl-9 pr-4 py-2.5 bg-[#0B0D12] border border-[#1E2235] rounded-lg text-xs text-white focus:outline-none focus:border-[#8B5CF6] transition"
              />
            </div>
          </div>

          <div>
            <label className="block text-xs font-semibold text-slate-300 mb-1.5">Admin Role Scope</label>
            <select
              value={selectedRole}
              onChange={(e) => setSelectedRole(e.target.value)}
              className="w-full px-3 py-2.5 bg-[#0B0D12] border border-[#1E2235] rounded-lg text-xs text-white focus:outline-none focus:border-[#8B5CF6]"
            >
              <option value="SUPER_ADMIN">SUPER_ADMIN (Full Access)</option>
              <option value="PLATFORM_ADMIN">PLATFORM_ADMIN</option>
              <option value="AI_ADMIN">AI_ADMIN</option>
              <option value="BILLING_ADMIN">BILLING_ADMIN</option>
              <option value="SUPPORT_ADMIN">SUPPORT_ADMIN</option>
              <option value="SECURITY_ADMIN">SECURITY_ADMIN</option>
            </select>
          </div>

          {showMfa && (
            <div className="space-y-1.5 pt-2 animate-fadeIn">
              <label className="block text-xs font-semibold text-[#22D3EE] flex items-center gap-1.5">
                <Key className="w-3.5 h-3.5" /> TOTP MFA Code
              </label>
              <input
                type="text"
                maxLength={6}
                placeholder="123456"
                value={mfaCode}
                onChange={(e) => setMfaCode(e.target.value)}
                className="w-full px-4 py-2.5 bg-[#0B0D12] border border-[#22D3EE]/40 rounded-lg text-center font-mono text-lg tracking-widest text-white focus:outline-none focus:border-[#22D3EE]"
              />
            </div>
          )}

          <button
            type="submit"
            className="w-full py-3 bg-[#6D28D9] hover:bg-[#8B5CF6] text-white text-xs font-extrabold rounded-lg transition-all duration-150 flex items-center justify-center gap-2 shadow-lg shadow-[#6D28D9]/25 mt-4"
          >
            <span>{showMfa ? 'Verify MFA & Enter Platform' : 'Continue to Security Check'}</span>
            <ArrowRight className="w-4 h-4" />
          </button>
        </form>

        <div className="text-center text-[10px] text-slate-500 pt-2 border-t border-[#1E2235]">
          CodeVanta Operations Control Center • AES-256 Auth Encryption
        </div>
      </div>
    </div>
  );
}
