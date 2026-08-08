import 'package:flutter/material.dart';
import '../../../../core/theme/codevanta_colors.dart';
import '../../../../shared/widgets/brand/codevanta_logo.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/buttons/ghost_button.dart';

class OnboardingItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;

  const OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
  });
}

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _slides = const [
    OnboardingItem(
      title: 'YOUR IDE. YOUR CODE. YOUR AI.',
      subtitle: 'Welcome to CodeVanta — the premier mobile development environment built for touchscreen ergonomics & AI coding power.',
      icon: Icons.code_rounded,
      accentColor: CodeVantaColors.electricViolet,
    ),
    OnboardingItem(
      title: 'Multi-Provider AI Agents',
      subtitle: 'Switch seamlessly between Claude 3.5 Sonnet, GPT-4o, and Gemini 1.5 Pro with context tags (@file, @selection, @terminal).',
      icon: Icons.psychology_rounded,
      accentColor: CodeVantaColors.cyanAccent,
    ),
    OnboardingItem(
      title: 'Local-First & Cloud Sandboxes',
      subtitle: 'Manage local Git repositories 100% offline or provision remote Docker containers for cloud builds & live web preview.',
      icon: Icons.cloud_done_rounded,
      accentColor: CodeVantaColors.successGreen,
    ),
  ];

  void _finishOnboarding() {
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CodeVantaColors.darkGraphite,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Skip Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CodeVantaLogo(size: 32),
                  GhostButton(
                    label: _currentPage == _slides.length - 1 ? 'Start' : 'Skip',
                    onPressed: _finishOnboarding,
                  ),
                ],
              ),
            ),

            // Page View Slider
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  final isLast = index == _slides.length - 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: isLast ? _finishOnboarding : null,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: slide.accentColor.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: slide.accentColor.withValues(alpha: 0.3),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              slide.icon,
                              size: 60,
                              color: slide.accentColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          slide.subtitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: CodeVantaColors.textDarkSecondary,
                                height: 1.5,
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Navigation & Page Indicators
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Indicator Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (index) => GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? CodeVantaColors.electricViolet
                                : CodeVantaColors.darkSurfaceBorder,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Next / Get Started Button
                  PrimaryButton(
                    label: _currentPage == _slides.length - 1 ? 'Get Started' : 'Next',
                    icon: _currentPage == _slides.length - 1 ? Icons.rocket_launch_rounded : Icons.arrow_forward_rounded,
                    onPressed: () {
                      if (_currentPage < _slides.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _finishOnboarding();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
