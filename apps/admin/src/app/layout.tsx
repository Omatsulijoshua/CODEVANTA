import './globals.css';
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'CodeVanta Admin Dashboard',
  description: 'Management & Analytics Platform for CodeVanta Mobile AI IDE',
  icons: {
    icon: '/favicon.svg',
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className="bg-[#12121A] text-white antialiased">{children}</body>
    </html>
  );
}
