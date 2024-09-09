import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter/material.dart';
import 'package:foodforgood/view/screens/announcement_details_screen.dart';
import 'package:foodforgood/view/screens/login_screen.dart';
import 'package:foodforgood/view/screens/profile_screen.dart';
import 'package:foodforgood/view/screens/settings_screen.dart';

import '../../theme/app_styles.dart';

class NewAnnouncementScreen extends StatelessWidget {
  final String restaurantName;

  const NewAnnouncementScreen({super.key, required this.restaurantName});

  Future<String> _getProfilePictureUrl(String userId) async {
    try {
      // Get user document from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Check if the user document exists and has a profile picture URL
      if (userDoc.exists) {
        String? profilePictureUrl = userDoc['profilePictureUrl'];
        if (profilePictureUrl != null) {
          // Return the profile picture URL
          return profilePictureUrl;
        }
      }

      // Return default profile picture URL if no profile picture URL is found
      return 'images/default_profile_picture.jpeg';
    } catch (e) {
      // Handle any errors (e.g., network issues)
      print('Error fetching profile picture URL: $e');
      return 'images/default_profile_picture.jpeg'; // Return default if error occurs
    }
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

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
          ///////////////////
          FutureBuilder<String>(
            future: _getProfilePictureUrl(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                ); // Show loading spinner while fetching
              } else if (snapshot.hasError) {
                return Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 28.0,
                ); // Show error icon if there's an error
              } else if (snapshot.hasData) {
                return IconButton(
                  icon: CircleAvatar(
                    backgroundImage: snapshot.data != null
                        ? NetworkImage(snapshot.data!)
                        : AssetImage('images/default_profile_picture.jpeg') as ImageProvider,
                    radius: 14.0, // Adjust the radius to fit your needs
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                );
              } else {
                return IconButton(
                  icon: CircleAvatar(
                    backgroundImage: AssetImage('images/default_profile_picture.jpeg'),
                    radius: 14.0, // Adjust the radius to fit your needs
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                ); // Show default image if no data is available
              }
            },
          ),
          /////////////////
          
          // IconButton(
          //   icon: const Icon(
          //     Icons.account_circle,
          //     size: 28.0,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const ProfileScreen()),
          //     );
          //   },
          // ),
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
                // Sign out the user
                FirebaseAuth.instance.signOut().then((_) {
                  // Navigate to login screen after sign out
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                }).catchError((e) {
                  // Handle errors
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to log out: $e')),
                  );
                });
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
