import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodforgood/view/screens/announcement_details_screen.dart';
import 'package:foodforgood/view/screens/profile_screen.dart';
import 'package:foodforgood/view/screens/settings_screen.dart';

import '../../theme/app_styles.dart';

class NewAnnouncementScreen extends StatelessWidget {
  final String restaurantName;

  const NewAnnouncementScreen({super.key, required this.restaurantName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.signupColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              restaurantName,
              style: TextStyles.titleStyle.copyWith(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.titleColor),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              size: 28.0,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              } else if (value == 'Settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
              } else if (value == 'Logout') {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Profile',
                  child: Row(
                    children: [
                      Icon(Icons.account_circle, color: Colors.black),
                      SizedBox(
                          width: 8), // Adds some space between icon and text
                      Text('Profile'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: Colors.black),
                      SizedBox(
                          width: 8), // Adds some space between icon and text
                      Text('Settings'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.black),
                      SizedBox(
                          width: 8), // Adds some space between icon and text
                      Text('Logout'),
                    ],
                  ),
                )
              ];
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the details screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AnnouncementDetailsScreen(
                  restaurantName: restaurantName,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(36.0),
            backgroundColor: AppColors.buttonLoginBackgroundColor,
            minimumSize:
                const Size(200, 200), // Increase the size of the button
          ),
          child: Text(
            'Set a \nNew Announcement',
            textAlign: TextAlign.center,
            style: TextStyles.buttonTextStyle.copyWith(
              color: AppColors.buttonLoginTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
