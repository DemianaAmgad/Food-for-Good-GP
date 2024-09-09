import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _emailNotifications = true;
  bool _pushNotifications = false;
  bool _smsNotifications = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationSettings();
  }

  // Load notification settings from SharedPreferences
  Future<void> _loadNotificationSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailNotifications = prefs.getBool('emailNotifications') ?? true;
      _pushNotifications = prefs.getBool('pushNotifications') ?? false;
      _smsNotifications = prefs.getBool('smsNotifications') ?? true;
    });
  }

  // Save notification settings to SharedPreferences
  Future<void> _saveNotificationSettings(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Save notification settings to Firestore in a separate collection
  Future<void> _saveToFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('userNotifications').doc(user.uid).set({
        'emailNotifications': _emailNotifications,
        'pushNotifications': _pushNotifications,
        'smsNotifications': _smsNotifications,
      }, SetOptions(merge: true)); // Merging ensures only these fields are updated
    }
  }

  @override
  Widget build(BuildContext context) {
    return notificationWidget();
  }

  Scaffold notificationWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          SwitchListTile(
            title: const Text('Email Notifications'),
            subtitle: const Text('Receive notifications via email'),
            value: _emailNotifications,
            onChanged: (bool value) {
              setState(() {
                _emailNotifications = value;
              });
              _saveNotificationSettings('emailNotifications', value);
              _showSnackBar('Email Notifications', value);
              _saveToFirestore();
            },
            secondary: const Icon(Icons.email),
          ),
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive notifications on your device'),
            value: _pushNotifications,
            onChanged: (bool value) {
              setState(() {
                _pushNotifications = value;
              });
              _saveNotificationSettings('pushNotifications', value);
              _showSnackBar('Push Notifications', value);
              _saveToFirestore();
            },
            secondary: const Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: const Text('SMS Notifications'),
            subtitle: const Text('Receive notifications via SMS'),
            value: _smsNotifications,
            onChanged: (bool value) {
              setState(() {
                _smsNotifications = value;
              });
              _saveNotificationSettings('smsNotifications', value);
              _showSnackBar('SMS Notifications', value);
              _saveToFirestore();
            },
            secondary: const Icon(Icons.sms),
          ),
        ],
      ),
    );
  }

  // Show a snackbar when a setting is changed
  void _showSnackBar(String notificationType, bool isEnabled) {
    final snackBar = SnackBar(
      content: Text(
        '$notificationType ${isEnabled ? 'Enabled' : 'Disabled'}',
      ),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
