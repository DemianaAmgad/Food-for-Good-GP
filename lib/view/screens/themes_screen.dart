import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemesPage extends StatefulWidget {
  const ThemesPage({super.key});

  @override
  _ThemesPageState createState() => _ThemesPageState();
}

class _ThemesPageState extends State<ThemesPage> {
  // Default theme choice
  ThemeMode _selectedTheme = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  // Load the theme from shared preferences
  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int themeIndex = prefs.getInt('themeMode') ?? 0; // Default to light theme
    setState(() {
      _selectedTheme = ThemeMode.values[themeIndex];
    });
  }

  // Save the selected theme to shared preferences
  Future<void> _saveTheme(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', themeMode.index);
  }

  void _setTheme(ThemeMode themeMode) {
    setState(() {
      _selectedTheme = themeMode;
    });
    _saveTheme(themeMode); // Save the theme
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          RadioListTile<ThemeMode>(
            title: const Text('Light Theme'),
            subtitle: const Text('A light theme with a white background'),
            value: ThemeMode.light,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                _setTheme(value);
              }
            },
            secondary: const Icon(Icons.light_mode),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark Theme'),
            subtitle: const Text('A dark theme with a black background'),
            value: ThemeMode.dark,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                _setTheme(value);
              }
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('System Default'),
            subtitle: const Text('Follow the system’s theme setting'),
            value: ThemeMode.system,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                _setTheme(value);
              }
            },
            secondary: const Icon(Icons.device_thermostat),
          ),
        ],
      ),
    );
  }
}
