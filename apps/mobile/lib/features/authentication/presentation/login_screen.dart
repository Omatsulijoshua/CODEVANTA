import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/brand/codevanta_logo.dart';
import '../../../shared/widgets/buttons/ghost_button.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../../shared/widgets/buttons/secondary_button.dart';
import '../../../shared/widgets/inputs/codevanta_text_field.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CodeVantaLogo(size: 64, style: LogoStyle.horizontal),
                  const SizedBox(height: 36),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to access your local & cloud AI workspaces',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CodeVantaTextField(
                    label: 'Email Address',
                    hintText: 'developer@codevanta.app',
                    controller: _emailController,
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 16),
                  CodeVantaTextField(
                    label: 'Password',
                    hintText: '••••••••',
                    controller: _passwordController,
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Sign In',
                    isLoading: _isLoading,
                    onPressed: () {
                      setState(() => _isLoading = true);
                      Future.delayed(const Duration(seconds: 1), () {
                        if (mounted) setState(() => _isLoading = false);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('OR CONTINUE WITH', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: CodeVantaColors.textDarkSecondary)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SecondaryButton(
                          label: 'GitHub',
                          icon: Icons.code,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SecondaryButton(
                          label: 'Google',
                          icon: Icons.g_mobiledata,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?', style: TextStyle(fontSize: 13, color: CodeVantaColors.textDarkSecondary)),
                      GhostButton(
                        label: 'Register',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RegisterScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
