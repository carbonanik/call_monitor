import 'package:call_monitor/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../components/gradient_button.dart';
import 'contact_selection_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Column(
                children: [
                  // App Icon / Logo
                  Assets.images.logoIconText.image(
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 42),
                  Text(
                    'Remember to connect with the people who matter.',
                    textAlign: TextAlign.center,
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Assets.images.splashArt.image(
                    width: 200,
                    height: 200,
                  ),
                  // Small copy from prompt
                  const SizedBox(height: 24),
                  Text(
                    '“This app gently reminds you to call the people you care about. No tracking. No judgment. Just reminders.”',
                    textAlign: TextAlign.center,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  GradientButton(
                    text: 'Choose who matters',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const ContactSelectionScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Skip to Home if already have contacts, but for now just go to selection
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: AppTheme.secondaryTextColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
