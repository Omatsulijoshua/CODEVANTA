import { NavItem } from '../types/admin';

export const ADMIN_NAV_ITEMS: NavItem[] = [
  {
    title: 'Dashboard',
    href: '/dashboard',
    icon: 'LayoutDashboard',
  },
  {
    title: 'Users',
    href: '/users',
    icon: 'Users',
    allowedRoles: ['SUPER_ADMIN', 'PLATFORM_ADMIN', 'SUPPORT_ADMIN'],
  },
  {
    title: 'Organizations',
    href: '/organizations',
    icon: 'Building2',
    allowedRoles: ['SUPER_ADMIN', 'PLATFORM_ADMIN'],
  },
  {
    title: 'Subscriptions',
    href: '/subscriptions',
    icon: 'CreditCard',
    allowedRoles: ['SUPER_ADMIN', 'PLATFORM_ADMIN', 'BILLING_ADMIN'],
  },
  {
    title: 'Plans',
    href: '/plans',
    icon: 'Layers',
    allowedRoles: ['SUPER_ADMIN', 'BILLING_ADMIN'],
  },
  {
    title: 'Payments',
    href: '/payments',
    icon: 'DollarSign',
    allowedRoles: ['SUPER_ADMIN', 'BILLING_ADMIN'],
  },
  {
    title: 'AI Platform',
    href: '/ai/providers',
    icon: 'Cpu',
    allowedRoles: ['SUPER_ADMIN', 'AI_ADMIN'],
    children: [
      { title: 'Agents', href: '/ai/agents', icon: 'Bot' },
      { title: 'Providers', href: '/ai/providers', icon: 'Key' },
      { title: 'Models', href: '/ai/models', icon: 'Sparkles' },
      { title: 'Usage', href: '/ai/usage', icon: 'BarChart2' },
    ],
  },
  {
    title: 'Cloud Envs',
    href: '/cloud',
    icon: 'Cloud',
    allowedRoles: ['SUPER_ADMIN', 'PLATFORM_ADMIN'],
  },
  {
    title: 'GitHub',
    href: '/github',
    icon: 'GitBranch',
    allowedRoles: ['SUPER_ADMIN', 'PLATFORM_ADMIN'],
  },
  {
    title: 'Extensions',
    href: '/extensions',
    icon: 'Package',
    allowedRoles: ['SUPER_ADMIN', 'PLATFORM_ADMIN'],
  },
  {
    title: 'Notifications',
    href: '/notifications',
    icon: 'Bell',
  },
  {
    title: 'Support',
    href: '/support',
    icon: 'LifeBuoy',
    allowedRoles: ['SUPER_ADMIN', 'PLATFORM_ADMIN', 'SUPPORT_ADMIN'],
  },
  {
    title: 'Analytics',
    href: '/analytics',
    icon: 'TrendingUp',
  },
  {
    title: 'Security',
    href: '/security',
    icon: 'ShieldCheck',
    allowedRoles: ['SUPER_ADMIN', 'SECURITY_ADMIN'],
  },
  {
    title: 'Audit Logs',
    href: '/audit',
    icon: 'FileText',
    allowedRoles: ['SUPER_ADMIN', 'SECURITY_ADMIN'],
  },
  {
    title: 'Settings',
    href: '/settings',
    icon: 'Settings',
    allowedRoles: ['SUPER_ADMIN'],
  },
];
