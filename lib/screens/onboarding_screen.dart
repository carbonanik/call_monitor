import 'package:call_monitor/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/theme.dart';
import '../components/gradient_button.dart';
import '../services/onboarding_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 5) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    await OnboardingService.completeOnboarding();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  Future<void> _requestContactsPermission() async {
    final status = await Permission.contacts.request();
    if (status.isDenied && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No problem — you can enable this later in Settings.'),
        ),
      );
    }
    _nextPage();
  }

  Future<void> _requestCallLogPermission() async {
    final status = await Permission.phone.request();
    if (status.isDenied && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('App still works! You can manually mark as called.'),
        ),
      );
    }
    _nextPage();
  }

  Future<void> _requestNotificationPermission() async {
    await Permission.notification.request();
    await OnboardingService.completeOnboarding();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            _buildWelcomeScreen(),
            _buildHowItWorksScreen(),
            _buildYourControlScreen(),
            _buildContactsPermissionScreen(),
            _buildCallLogPermissionScreen(),
            _buildNotificationPermissionScreen(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Assets.images.logoIconText.image(width: 200, height: 200),
          const SizedBox(height: 24),
          Assets.images.onboardingArt1.image(
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 24),
          Text(
            'Stay connected with the people who matter — without stress, guilt, or noise.',
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.secondaryTextColor,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          GradientButton(
            text: '👉 Get started',
            onPressed: _nextPage,
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How It Works',
            style: AppTheme.lightTheme.textTheme.displayLarge
                ?.copyWith(fontSize: 28),
          ),
          const SizedBox(height: 32),
          Assets.images.onboardingArt2.image(),
          const SizedBox(height: 24),
          _buildBulletItem(
            Icons.wb_sunny_outlined,
            'Start the day with a gentle reminder',
          ),
          const SizedBox(height: 24),
          _buildBulletItem(
            Icons.phone_outlined,
            'Few thoughtful nudge when the time feels right',
          ),
          const SizedBox(height: 24),
          _buildBulletItem(
            Icons.nightlight_outlined,
            'End the day with calm reflection',
          ),
          const Spacer(),
          Center(
            child: Text(
              'No spam. No pressure. Ever.',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),
          GradientButton(
            text: '👉 Sounds good',
            onPressed: _nextPage,
          ),
        ],
      ),
    );
  }

  Widget _buildBulletItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: AppTheme.lightTheme.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildYourControlScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You’re always in control',
            style: AppTheme.lightTheme.textTheme.displayLarge
                ?.copyWith(fontSize: 28),
          ),
          const SizedBox(height: 32),
          _buildTrustItem('We limit notifications by design'),
          const SizedBox(height: 16),
          _buildTrustItem('Nothing is shared or uploaded'),
          const SizedBox(height: 16),
          _buildTrustItem('You can change or stop reminders anytime'),
          const Spacer(),
          GradientButton(
            text: '👉 Continue',
            onPressed: _nextPage,
          ),
        ],
      ),
    );
  }

  Widget _buildTrustItem(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle_outline, color: AppTheme.primaryColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTheme.lightTheme.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildContactsPermissionScreen() {
    return _buildPermissionBase(
      title: 'Choose who matters',
      description:
          'We use your contacts so you can easily select the people you want to stay connected with.\n\nWe only read names and numbers — nothing is stored online.',
      buttonText: '👉 Allow contacts',
      onPressed: _requestContactsPermission,
    );
  }

  Widget _buildCallLogPermissionScreen() {
    return _buildPermissionBase(
      title: 'Stay accurate, without manual work',
      description:
          'We check your call history so we don’t remind you to call someone you already spoke to.\n\nWe never record calls.\nWe only check when a call happened.',
      buttonText: '👉 Allow call access',
      onPressed: _requestCallLogPermission,
    );
  }

  Widget _buildNotificationPermissionScreen() {
    return _buildPermissionBase(
      title: 'Gentle reminders — only when needed',
      description:
          'We send:\n• 1 morning summary\n• Few gentle nudge throughout the day\n• A calm end-of-day message\n\nNo spam. No guilt.',
      buttonText: '👉 Enable notifications',
      onPressed: _requestNotificationPermission,
    );
  }

  Widget _buildPermissionBase({
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.displayLarge
                ?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 32),
          Text(
            description,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.textColor.withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
          const Spacer(),
          GradientButton(
            text: buttonText,
            onPressed: onPressed,
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: _nextPage,
              child: const Text(
                'Not now',
                style: TextStyle(color: AppTheme.secondaryTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
