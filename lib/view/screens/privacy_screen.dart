import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool _profileVisibility = true;
  bool _dataCollection = false;
  bool _advertisingPreferences = true;

  @override
  void initState() {
    super.initState();
    _loadPrivacySettings();
  }

  // Load privacy settings from Firestore
  Future<void> _loadPrivacySettings() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userPrivacyDoc = await FirebaseFirestore.instance
          .collection('userPrivacySettings')
          .doc(user.uid)
          .get();
          
      if (userPrivacyDoc.exists) {
        setState(() {
          _profileVisibility = userPrivacyDoc.get('profileVisibility') ?? true;
          _dataCollection = userPrivacyDoc.get('dataCollection') ?? false;
          _advertisingPreferences = userPrivacyDoc.get('advertisingPreferences') ?? true;
        });
      }
    }
  }

  // Save privacy settings to Firestore
  Future<void> _savePrivacySettings() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('userPrivacySettings').doc(user.uid).set({
        'profileVisibility': _profileVisibility,
        'dataCollection': _dataCollection,
        'advertisingPreferences': _advertisingPreferences,
      }, SetOptions(merge: true));  // Use merge to update specific fields
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          SwitchListTile(
            title: const Text('Profile Visibility'),
            subtitle: const Text('Make your profile visible to others'),
            value: _profileVisibility,
            onChanged: (bool value) {
              setState(() {
                _profileVisibility = value;
              });
              _savePrivacySettings();
            },
            secondary: const Icon(Icons.visibility),
          ),
          SwitchListTile(
            title: const Text('Data Collection'),
            subtitle: const Text('Allow data collection for analytics'),
            value: _dataCollection,
            onChanged: (bool value) {
              setState(() {
                _dataCollection = value;
              });
              _savePrivacySettings();
            },
            secondary: const Icon(Icons.analytics),
          ),
          SwitchListTile(
            title: const Text('Advertising Preferences'),
            subtitle: const Text('Customize advertising preferences'),
            value: _advertisingPreferences,
            onChanged: (bool value) {
              setState(() {
                _advertisingPreferences = value;
              });
              _savePrivacySettings();
            },
            secondary: const Icon(Icons.ad_units),
          ),
        ],
      ),
    );
  }
}
