import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'About This App',
            ),
            const SizedBox(height: 10),
            const Text(
              'Version: 1.0.0',
            ),
            const SizedBox(height: 20),
            const Text(
              'Developed by:',
            ),
            const Text(
              'Food for Good',
            ),
            const Text(
              '820 N 17th st, Suite 100Lincoln, Nebraska, 68508',
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact Us:',
            ),
            const Text(
              'Email: support@foodforgood.com\nPhone: +20 1090825437',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to a page with more detailed information, if needed
              },
              child: const Text('Learn More'),
            ),
          ],
        ),
      ),
    );
  }
}
