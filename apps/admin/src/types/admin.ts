export type AdminRole =
  | 'SUPER_ADMIN'
  | 'PLATFORM_ADMIN'
  | 'AI_ADMIN'
  | 'BILLING_ADMIN'
  | 'SUPPORT_ADMIN'
  | 'SECURITY_ADMIN';

export interface AdminUser {
  id: string;
  name: string;
  email: string;
  role: AdminRole;
  avatarUrl?: string;
  mfaEnabled: boolean;
  lastActive: string;
}

export interface NavItem {
  title: string;
  href: string;
  icon: string;
  allowedRoles?: AdminRole[];
  badge?: string;
  children?: NavItem[];
}
