import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ContactSupportPage extends StatefulWidget {
  const ContactSupportPage({super.key});

  @override
  _ContactSupportPageState createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  final TextEditingController _concernController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  Future<void> _submitConcern() async {
    // Ensure Firebase is initialized
    await Firebase.initializeApp();

    // Get the text from the controllers
    String concern = _concernController.text;
    String contactInfo = _contactController.text;

    // Reference to Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add the concern to the 'concerns' collection
    try {
      await firestore.collection('concerns').add({
        'concern': concern,
        'contact_info': contactInfo,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show a success message or navigate away
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your concern has been submitted.')),
      );

      // Clear the text fields
      _concernController.clear();
      _contactController.clear();
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit concern.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Send your concern',
            ),
            const SizedBox(height: 20),
            const Text(
              'We value your concerns. Please let us know your thoughts:',
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _concernController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your concern here',
              ),
              maxLines: 6,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contactController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your contact info to reach you back',
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitConcern,
              child: const Text('Submit concern'),
            ),
          ],
        ),
      ),
    );
  }
}
