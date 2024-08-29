import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildSection(
              title: 'FAQs',
              content: 'Here you will find answers to the most frequently asked questions. We cover a wide range of topics to help you better understand our app. If you have a question, it is likely answered in this section.',
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Contact Support',
              content: 'If you need further assistance or have specific issues, you can reach out to our support team. Our support team is available to help you with any problems or concerns you might have.',
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Tutorials',
              content: 'Access a collection of tutorials designed to help you get the most out of our app. From basic features to advanced functionalities, these tutorials will guide you through various aspects of the app.',
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Troubleshooting',
              content: 'If you encounter any issues, this section provides solutions to common problems. We offer step-by-step instructions to help you resolve issues quickly and effectively.',
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Additional Resources',
              content: 'Explore additional resources including user guides, video tutorials, and community forums. These resources are designed to provide you with more in-depth knowledge and support.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}
