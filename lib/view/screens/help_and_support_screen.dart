import 'package:flutter/material.dart';
import 'package:foodforgood/view/widgets/contact_support_widget.dart';
import 'package:foodforgood/view/widgets/faq_widget.dart';
import 'package:foodforgood/view/widgets/feedback_wiget.dart';
import 'package:foodforgood/view/widgets/help_center_widget.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            title: const Text('FAQs'),
            subtitle: const Text('Frequently Asked Questions'),
            leading: const Icon(Icons.help_outline),
            onTap: () {
              // Navigate to FAQs page or show FAQs dialog
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaqsPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Contact Support'),
            subtitle: const Text('Get in touch with our support team'),
            leading: const Icon(Icons.support_agent),
            onTap: () {
              // Navigate to contact support page or show contact form
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactSupportPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Help Center'),
            subtitle: const Text('Access the help center'),
            leading: const Icon(Icons.help),
            onTap: () {
              // Navigate to Help Center page or show help center
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpCenterPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Send Feedback'),
            subtitle: const Text('Provide feedback about the app'),
            leading: const Icon(Icons.feedback),
            onTap: () {
              // Navigate to feedback page or show feedback form
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedbackPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}





