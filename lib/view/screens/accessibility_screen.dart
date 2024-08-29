import 'package:flutter/material.dart';

class AccessibilityPage extends StatefulWidget {
  @override
  _AccessibilityPageState createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  bool _screenReader = false;
  bool _highContrast = false;
  bool _largeText = false;
  bool _extraTouch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accessibility Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          SwitchListTile(
            title: Text('Screen Reader'),
            subtitle: Text('Enable screen reader for visually impaired users'),
            value: _screenReader,
            onChanged: (bool value) {
              setState(() {
                _screenReader = value;
              });
            },
            secondary: Icon(Icons.screen_search_desktop_rounded),
          ),
          SwitchListTile(
            title: Text('High Contrast'),
            subtitle: Text('Enable high contrast mode for better visibility'),
            value: _highContrast,
            onChanged: (bool value) {
              setState(() {
                _highContrast = value;
              });
            },
            secondary: Icon(Icons.contrast),
          ),
          SwitchListTile(
            title: Text('Large Text'),
            subtitle: Text('Use larger text for better readability'),
            value: _largeText,
            onChanged: (bool value) {
              setState(() {
                _largeText = value;
              });
            },
            secondary: Icon(Icons.text_fields),
          ),
          SwitchListTile(
            title: Text('Extra Touch Sensitivity'),
            subtitle: Text('Increase touch sensitivity for users with motor impairments'),
            value: _extraTouch,
            onChanged: (bool value) {
              setState(() {
                _extraTouch = value;
              });
            },
            secondary: Icon(Icons.touch_app),
          ),
        ],
      ),
    );
  }
}
