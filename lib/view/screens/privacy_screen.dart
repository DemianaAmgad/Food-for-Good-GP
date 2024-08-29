import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool _profileVisibility = true;
  bool _dataCollection = false;
  bool _advertisingPreferences = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          SwitchListTile(
            title: Text('Profile Visibility'),
            subtitle: Text('Make your profile visible to others'),
            value: _profileVisibility,
            onChanged: (bool value) {
              setState(() {
                _profileVisibility = value;
              });
            },
            secondary: Icon(Icons.visibility),
          ),
          SwitchListTile(
            title: Text('Data Collection'),
            subtitle: Text('Allow data collection for analytics'),
            value: _dataCollection,
            onChanged: (bool value) {
              setState(() {
                _dataCollection = value;
              });
            },
            secondary: Icon(Icons.analytics),
          ),
          SwitchListTile(
            title: Text('Advertising Preferences'),
            subtitle: Text('Customize advertising preferences'),
            value: _advertisingPreferences,
            onChanged: (bool value) {
              setState(() {
                _advertisingPreferences = value;
              });
            },
            secondary: Icon(Icons.ad_units),
          ),
        ],
      ),
    );
  }
}
