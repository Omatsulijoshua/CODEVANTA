'use client';

import React from 'react';
import { AdminShell } from '../../../components/layout/AdminShell';

export default function AiProvidersPage() {
  return (
    <AdminShell>
      <div className="space-y-6">
        <h1 className="text-2xl font-extrabold text-[#22D3EE]">AI Providers & Key Manager</h1>
        <p className="text-xs text-slate-400">Configure OpenAI, Anthropic, Gemini, OpenRouter API credentials</p>
      </div>
    </AdminShell>
  );
}
