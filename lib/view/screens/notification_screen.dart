import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _emailNotifications = true;
  bool _pushNotifications = false;
  bool _smsNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          SwitchListTile(
            title: Text('Email Notifications'),
            subtitle: Text('Receive notifications via email'),
            value: _emailNotifications,
            onChanged: (bool value) {
              setState(() {
                _emailNotifications = value;
              });
            },
            secondary: Icon(Icons.email),
          ),
          SwitchListTile(
            title: Text('Push Notifications'),
            subtitle: Text('Receive notifications on your device'),
            value: _pushNotifications,
            onChanged: (bool value) {
              setState(() {
                _pushNotifications = value;
              });
            },
            secondary: Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: Text('SMS Notifications'),
            subtitle: Text('Receive notifications via SMS'),
            value: _smsNotifications,
            onChanged: (bool value) {
              setState(() {
                _smsNotifications = value;
              });
            },
            secondary: Icon(Icons.sms),
          ),
        ],
      ),
    );
  }
}
