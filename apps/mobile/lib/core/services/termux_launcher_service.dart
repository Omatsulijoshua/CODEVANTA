import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../features/terminal/presentation/terminal_screen.dart';
import '../theme/codevanta_colors.dart';

class TermuxLauncherService {
  static const String termuxPlayStoreUrl = 'https://play.google.com/store/apps/details?id=com.termux';
  static const String termuxFdroidUrl = 'https://f-droid.org/packages/com.termux/';

  static Future<void> openTermuxOrFallback(BuildContext context, {String projectPath = '/local/projects/codevanta_mobile'}) async {
    final termuxUri = Uri.parse('termux://open?cd=${Uri.encodeComponent(projectPath)}');

    bool launched = false;
    try {
      if (await canLaunchUrl(termuxUri)) {
        launched = await launchUrl(termuxUri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      launched = false;
    }

    if (!launched && context.mounted) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          final isDark = Theme.of(ctx).brightness == Brightness.dark;
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              border: Border.all(color: CodeVantaColors.electricViolet.withValues(alpha: 0.3)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: CodeVantaColors.cyanAccent.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.terminal, color: CodeVantaColors.cyanAccent, size: 24),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Termux Terminal Integration',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Native Mobile Linux Shell & Cloud Sandboxes',
                          style: TextStyle(fontSize: 12, color: CodeVantaColors.textDarkSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.cloud_done_rounded, color: CodeVantaColors.electricViolet),
                  title: const Text('Launch In-App Cloud Terminal', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Run bash, node, python, & git in CodeVanta IDE'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {
                    Navigator.pop(ctx);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TerminalScreen()));
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.android, color: Colors.green),
                  title: const Text('Install Termux (Google Play Store)'),
                  subtitle: const Text('Download Android native terminal emulator'),
                  trailing: const Icon(Icons.open_in_new, size: 16),
                  onTap: () async {
                    Navigator.pop(ctx);
                    final url = Uri.parse(termuxPlayStoreUrl);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.get_app_outlined, color: Colors.amber),
                  title: const Text('Install Termux (F-Droid Package)'),
                  subtitle: const Text('Latest updated Termux builds'),
                  trailing: const Icon(Icons.open_in_new, size: 16),
                  onTap: () async {
                    Navigator.pop(ctx);
                    final url = Uri.parse(termuxFdroidUrl);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
