import 'package:flutter/material.dart';

class ThemesPage extends StatefulWidget {
  const ThemesPage({super.key});

  @override
  _ThemesPageState createState() => _ThemesPageState();
}

class _ThemesPageState extends State<ThemesPage> {
  // Default theme choice
  ThemeMode _selectedTheme = ThemeMode.light;

  void _setTheme(ThemeMode themeMode) {
    setState(() {
      _selectedTheme = themeMode;
    });
    // You might want to persist this setting in a more permanent way, like shared preferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          RadioListTile<ThemeMode>(
            title: Text('Light Theme'),
            subtitle: Text('A light theme with a white background'),
            value: ThemeMode.light,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                _setTheme(value);
              }
            },
            secondary: Icon(Icons.light_mode),
          ),
          RadioListTile<ThemeMode>(
            title: Text('Dark Theme'),
            subtitle: Text('A dark theme with a black background'),
            value: ThemeMode.dark,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                _setTheme(value);
              }
            },
            secondary: Icon(Icons.dark_mode),
          ),
          RadioListTile<ThemeMode>(
            title: Text('System Default'),
            subtitle: Text('Follow the system’s theme setting'),
            value: ThemeMode.system,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                _setTheme(value);
              }
            },
            secondary: Icon(Icons.device_thermostat),
          ),
        ],
      ),
    );
  }
}
