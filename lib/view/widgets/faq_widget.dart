import 'package:flutter/material.dart';

class FaqsPage extends StatelessWidget {
  const FaqsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const <Widget>[
            ListTile(
              title: Text(
                'How can I deliver food?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'To deliver food, follow the instructions in the app to start the delivery process.'),
            ),
            ListTile(
              title: Text(
                'How can I contact support?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'You can contact support via the Contact Support page or email us at support@foodforgood.com.'),
            ),
            // Add more FAQs here
          ],
        ),
      ),
    );
  }
}