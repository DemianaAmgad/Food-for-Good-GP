import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();

  Future<void> _submitFeedback() async {
    // Ensure Firebase is initialized
    await Firebase.initializeApp();

    // Get the text from the controller
    String feedback = _feedbackController.text;

    // Reference to Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add the feedback to the 'feedbacks' collection
    try {
      await firestore.collection('feedbacks').add({
        'feedback': feedback,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show a success message or navigate away
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:  Text('Your feedback has been submitted.')),
      );

      // Clear the text field
      _feedbackController.clear();
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit feedback.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Send Feedback',
            ),
            const SizedBox(height: 20),
            const Text(
              'We value your feedback. Please let us know your thoughts:',
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your feedback here',
              ),
              maxLines: 6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitFeedback,
              child: const Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
