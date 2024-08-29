import 'package:flutter/material.dart';
import 'package:foodforgood/view/screens/driver_orders_screen.dart';
import 'package:foodforgood/view/screens/settings_screen.dart';
import '../../theme/app_styles.dart';
import '../screens/accepted_requests_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/profile_screen.dart';

class DriverStartScreen extends StatelessWidget {
  final String driverName;

  const DriverStartScreen({super.key, required this.driverName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.signupColor,
      appBar: AppBar(
        backgroundColor: AppColors.signupColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Hi, $driverName!',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Are you available to deliver from restaurants to factories right now?',
                textAlign: TextAlign.center,
                style: TextStyles.subtitleStyle.copyWith(
                  fontSize: 18.0,
                  color: AppColors.titleColor,
                ),
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DriverOrdersScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: AppColors.buttonLoginBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text(
                  'Start',
                  style: TextStyles.buttonTextStyle.copyWith(
                    color: AppColors.confirmButtonTextColor,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AcceptedRequestsPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              backgroundColor: AppColors.confirmButtonTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Text(
              "Go to acccepted announcements",
              style: TextStyles.buttonTextStyle.copyWith(
                color: AppColors.buttonLoginBackgroundColor,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
