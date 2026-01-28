import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Just Call',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Just Call is a gentle reminder to stay in touch with the people you care about.\n\n'
              'Life gets busy. Days pass. Calls get delayed.\n'
              'This app exists to help you remember — without pressure, guilt, or noise.',
            ),
            const SizedBox(height: 24),
            const Text(
              'Built with care by',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Your Name / Studio Name',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                launchUrl(
                  Uri.parse(
                      'https://docs.google.com/forms/d/e/1FAIpQLSfhTYnco6UuMitLYWlkAxNc-4VuWmQXLl1D1xzvXs-O7rNuYQ/viewform?usp=dialog'),
                );
              },
              child: const Text('Privacy & Trust'),
            ),
          ],
        ),
      ),
    );
  }
}
