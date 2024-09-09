import 'package:flutter/material.dart';
import 'package:foodforgood/view/screens/about_screen.dart';
import 'package:foodforgood/view/screens/accessibility_screen.dart';
import 'package:foodforgood/view/screens/help_and_support_screen.dart';
import 'package:foodforgood/view/screens/languages_screen.dart';
import 'package:foodforgood/view/screens/notification_screen.dart';
import 'package:foodforgood/view/screens/privacy_screen.dart';
import 'package:foodforgood/view/screens/profile_screen.dart';
import 'package:foodforgood/view/screens/themes_screen.dart';
import 'package:foodforgood/view/screens/updates_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        // backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          // Account Section
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Account'),
            subtitle: const Text('Manage your account'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          // Notifications Section
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Manage notification settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  NotificationsPage()),
              );
            },
          ),
          // Privacy Section
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Privacy'),
            subtitle: const Text('Manage privacy settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  PrivacyPage()),
              );
            },
          ),
          // Language Section
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: const Text('Change app language'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  LanguagePage()),
              );
            },
          ),
          // Theme Section
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Theme'),
            subtitle: const Text('Change app theme'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ThemesPage()),
              );
            },
          ),
          // Accessibility section
          ListTile(
            leading: const Icon(Icons.accessibility),
            title: const Text('Accessibility'),
            subtitle: const Text('Check for accessibility'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  AccessibilityPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.update),
            title: const Text('Updates'),
            subtitle: const Text('Check app updates'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  UpdatesPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help and support'),
            subtitle: const Text('Ask for help'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  HelpSupportPage()),
              );
            },
          ),
          // About Section
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            subtitle: const Text('Learn more about the app'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  AboutPage()),
              );
            },
          ),
          // Sign Out Section
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sign Out'),
            onTap: () {
              // Implement sign-out logic
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}