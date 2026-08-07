import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/brand/codevanta_logo.dart';
import '../../../shared/widgets/buttons/ghost_button.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../../shared/widgets/inputs/codevanta_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const CodeVantaLogo(size: 24, style: LogoStyle.horizontal),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Unlock multi-provider AI agents & remote dev environments',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
                    ),
                  ),
                  const SizedBox(height: 28),
                  CodeVantaTextField(
                    label: 'Full Name',
                    hintText: 'Alex Developer',
                    controller: _nameController,
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  CodeVantaTextField(
                    label: 'Email Address',
                    hintText: 'developer@codevanta.app',
                    controller: _emailController,
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 16),
                  CodeVantaTextField(
                    label: 'Password',
                    hintText: 'Minimum 8 characters',
                    controller: _passwordController,
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Create Developer Account',
                    isLoading: _isLoading,
                    onPressed: () {
                      setState(() => _isLoading = true);
                      Future.delayed(const Duration(seconds: 1), () {
                        if (mounted) setState(() => _isLoading = false);
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already registered?', style: TextStyle(fontSize: 13, color: CodeVantaColors.textDarkSecondary)),
                      GhostButton(
                        label: 'Sign In',
                        onPressed: () => Navigator.pop(context),
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
