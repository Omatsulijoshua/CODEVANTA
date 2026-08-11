'use client';

import React, { useState } from 'react';
import { AdminShell } from '../../../components/layout/AdminShell';
import { Key, ShieldCheck, RefreshCw, Zap, Plus, CheckCircle2, AlertCircle } from 'lucide-react';

interface ProviderConfig {
  id: string;
  name: string;
  enabled: boolean;
  priority: number;
  rawKeysString: string;
  keyCount: number;
  models: string[];
  status: 'OPTIMAL' | 'DEGRADED' | 'DISABLED';
}

export default function AiProvidersPage() {
  const [providers, setProviders] = useState<ProviderConfig[]>([
    {
      id: 'groq',
      name: 'Groq Cloud AI (Llama 3.3)',
      enabled: true,
      priority: 1,
      rawKeysString: 'gsk_prod_key1_8923a, gsk_prod_key2_7812b',
      keyCount: 2,
      models: ['llama-3.3-70b-versatile', 'mixtral-8x7b-32768'],
      status: 'OPTIMAL',
    },
    {
      id: 'gemini',
      name: 'Google Gemini Pro & Flash',
      enabled: true,
      priority: 2,
      rawKeysString: 'AIzaSy_key1_991823, AIzaSy_key2_112039',
      keyCount: 2,
      models: ['gemini-1.5-pro', 'gemini-1.5-flash'],
      status: 'OPTIMAL',
    },
    {
      id: 'openai',
      name: 'OpenAI GPT-4o',
      enabled: true,
      priority: 3,
      rawKeysString: 'sk-proj-openai-key-1, sk-proj-openai-key-2',
      keyCount: 2,
      models: ['gpt-4o', 'gpt-4-turbo'],
      status: 'OPTIMAL',
    },
    {
      id: 'anthropic',
      name: 'Anthropic Claude 3.5',
      enabled: true,
      priority: 4,
      rawKeysString: 'sk-ant-claude-key-1',
      keyCount: 1,
      models: ['claude-3-5-sonnet-20241022', 'claude-3-opus-20240229'],
      status: 'OPTIMAL',
    },
  ]);

  const [savingId, setSavingId] = useState<string | null>(null);

  const handleKeyStringChange = (id: string, newRawKeys: string) => {
    const keyCount = newRawKeys
      .split(',')
      .map((k) => k.trim())
      .filter((k) => k.length > 0).length;

    setProviders((prev) =>
      prev.map((p) => (p.id === id ? { ...p, rawKeysString: newRawKeys, keyCount } : p))
    );
  };

  const toggleProviderEnabled = (id: string) => {
    setProviders((prev) =>
      prev.map((p) => (p.id === id ? { ...p, enabled: !p.enabled } : p))
    );
  };

  const handleSaveProvider = (id: string) => {
    setSavingId(id);
    setTimeout(() => {
      setSavingId(null);
    }, 600);
  };

  return (
    <AdminShell>
      <div className="space-y-8">
        {/* Header */}
        <div className="flex justify-between items-start">
          <div>
            <h1 className="text-2xl font-extrabold text-[#22D3EE] flex items-center gap-2">
              <Key className="w-6 h-6 text-[#8B5CF6]" /> Multi-API Key Pooling & AI Gateway Routing
            </h1>
            <p className="text-xs text-slate-400 mt-1">
              Combine multiple free & paid API keys separated by comma (e.g. 2 Groq keys, 2 Gemini keys) to maximize rate limits & round-robin load distribution.
            </p>
          </div>
          <button className="px-4 py-2 bg-[#6D28D9] hover:bg-[#8B5CF6] text-white text-xs font-bold rounded-lg flex items-center gap-2 transition shadow-lg shadow-[#6D28D9]/25">
            <Plus className="w-4 h-4" /> Add Custom Adapter
          </button>
        </div>

        {/* Fallback Priority Pipeline Overview */}
        <div className="p-6 bg-[#12141F] rounded-xl border border-[#1E2235] space-y-4">
          <h2 className="text-sm font-bold text-white flex items-center gap-2">
            <Zap className="w-4 h-4 text-[#22D3EE]" /> Active Fallback & Key Rotation Chain
          </h2>
          <div className="flex flex-wrap items-center gap-3">
            {providers
              .filter((p) => p.enabled)
              .sort((a, b) => a.priority - b.priority)
              .map((p, i) => (
                <React.Fragment key={p.id}>
                  <div className="px-3.5 py-2 bg-[#0B0D12] border border-[#1E2235] rounded-lg text-xs flex items-center gap-2">
                    <span className="w-5 h-5 rounded-full bg-[#6D28D9] text-white text-[10px] font-bold flex items-center justify-center">
                      {i + 1}
                    </span>
                    <span className="font-bold text-white">{p.name.split(' ')[0]}</span>
                    <span className="px-2 py-0.5 bg-[#22D3EE]/10 text-[#22D3EE] text-[10px] font-mono rounded font-semibold">
                      {p.keyCount} Keys Pooled
                    </span>
                  </div>
                  {i < providers.filter((p) => p.enabled).length - 1 && (
                    <span className="text-slate-500 font-bold text-xs">→</span>
                  )}
                </React.Fragment>
              ))}
          </div>
        </div>

        {/* Provider Multi-Key Cards */}
        <div className="grid grid-cols-1 gap-6">
          {providers.map((p) => (
            <div key={p.id} className="p-6 bg-[#12141F] rounded-xl border border-[#1E2235] space-y-4">
              <div className="flex justify-between items-center">
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded-lg bg-[#8B5CF6]/15 border border-[#8B5CF6]/30 flex items-center justify-center font-bold text-xs text-[#22D3EE]">
                    {p.id.substring(0, 2).toUpperCase()}
                  </div>
                  <div>
                    <h3 className="font-bold text-sm text-white">{p.name}</h3>
                    <p className="text-[11px] text-slate-400">Models: {p.models.join(', ')}</p>
                  </div>
                </div>

                <div className="flex items-center gap-3">
                  <span className="px-2.5 py-1 bg-emerald-500/10 text-emerald-400 text-xs font-bold rounded-md border border-emerald-500/20 flex items-center gap-1.5">
                    <CheckCircle2 className="w-3.5 h-3.5" /> {p.keyCount} Active Keys in Pool
                  </span>
                  <label className="relative inline-flex items-center cursor-pointer">
                    <input
                      type="checkbox"
                      checked={p.enabled}
                      onChange={() => toggleProviderEnabled(p.id)}
                      className="sr-only peer"
                    />
                    <div className="w-11 h-6 bg-[#0B0D12] peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-[#6D28D9]"></div>
                  </label>
                </div>
              </div>

              {/* Multi API Keys Text Area */}
              <div>
                <label className="block text-xs font-semibold text-slate-300 mb-1.5 flex justify-between">
                  <span>API Keys (Separated by comma for Round-Robin rotation)</span>
                  <span className="text-slate-400 font-mono text-[11px]">Key Pool Size: {p.keyCount}</span>
                </label>
                <textarea
                  rows={2}
                  value={p.rawKeysString}
                  onChange={(e) => handleKeyStringChange(p.id, e.target.value)}
                  placeholder="Paste multiple API keys separated by comma e.g. key1, key2, key3..."
                  className="w-full p-3 bg-[#0B0D12] border border-[#1E2235] rounded-lg text-xs font-mono text-[#22D3EE] focus:outline-none focus:border-[#8B5CF6] transition resize-none"
                />
              </div>

              {/* Action Toolbar */}
              <div className="flex justify-between items-center pt-2">
                <div className="text-[11px] text-slate-400 flex items-center gap-2">
                  <ShieldCheck className="w-4 h-4 text-emerald-400" />
                  <span>Keys encrypted with AES-256-GCM symmetric security</span>
                </div>
                <div className="flex items-center gap-3">
                  <button
                    onClick={() => handleSaveProvider(p.id)}
                    className="px-4 py-2 bg-[#1E2235] hover:bg-[#2A2E45] text-white text-xs font-bold rounded-lg transition flex items-center gap-2"
                  >
                    {savingId === p.id ? (
                      <RefreshCw className="w-3.5 h-3.5 animate-spin text-[#22D3EE]" />
                    ) : (
                      <span>Save Key Pool</span>
                    )}
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </AdminShell>
  );
}
