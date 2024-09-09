import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({super.key});

  @override
  _AccessibilityPageState createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  bool _screenReader = false;
  bool _highContrast = false;
  bool _largeText = false;
  bool _extraTouch = false;

  @override
  void initState() {
    super.initState();
    _loadAccessibilitySettings();
  }

  // Load accessibility settings from Firestore
  Future<void> _loadAccessibilitySettings() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userAccessibilityDoc = await FirebaseFirestore.instance
          .collection('userAccessibilitySettings')
          .doc(user.uid)
          .get();
          
      if (userAccessibilityDoc.exists) {
        setState(() {
          _screenReader = userAccessibilityDoc.get('screenReader') ?? false;
          _highContrast = userAccessibilityDoc.get('highContrast') ?? false;
          _largeText = userAccessibilityDoc.get('largeText') ?? false;
          _extraTouch = userAccessibilityDoc.get('extraTouch') ?? false;
        });
      }
    }
  }

  // Save accessibility settings to Firestore
  Future<void> _saveAccessibilitySettings() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('userAccessibilitySettings').doc(user.uid).set({
        'screenReader': _screenReader,
        'highContrast': _highContrast,
        'largeText': _largeText,
        'extraTouch': _extraTouch,
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessibility Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          SwitchListTile(
            title: const Text('Screen Reader'),
            subtitle: const Text('Enable screen reader for visually impaired users'),
            value: _screenReader,
            onChanged: (bool value) {
              setState(() {
                _screenReader = value;
              });
              _saveAccessibilitySettings();
            },
            secondary: const Icon(Icons.screen_search_desktop_rounded),
          ),
          SwitchListTile(
            title: const Text('High Contrast'),
            subtitle: const Text('Enable high contrast mode for better visibility'),
            value: _highContrast,
            onChanged: (bool value) {
              setState(() {
                _highContrast = value;
              });
              _saveAccessibilitySettings();
            },
            secondary: const Icon(Icons.contrast),
          ),
          SwitchListTile(
            title: const Text('Large Text'),
            subtitle: const Text('Use larger text for better readability'),
            value: _largeText,
            onChanged: (bool value) {
              setState(() {
                _largeText = value;
              });
              _saveAccessibilitySettings();
            },
            secondary: const Icon(Icons.text_fields),
          ),
          SwitchListTile(
            title: const Text('Extra Touch Sensitivity'),
            subtitle: const Text('Increase touch sensitivity for users with motor impairments'),
            value: _extraTouch,
            onChanged: (bool value) {
              setState(() {
                _extraTouch = value;
              });
              _saveAccessibilitySettings();
            },
            secondary: const Icon(Icons.touch_app),
          ),
        ],
      ),
    );
  }
}
