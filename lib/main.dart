import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodforgood/view/screens/welcome_screen.dart';
import 'package:foodforgood/view/screens/login_screen.dart';
import 'package:foodforgood/view/screens/driver_screen.dart'; 
import 'package:foodforgood/view/screens/resturant_announcment_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              // User is signed in
              final User? user = snapshot.data;
              // Fetch user role from Firestore
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid)
                    .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.done) {
                    if (userSnapshot.hasData) {
                      final userDoc = userSnapshot.data!;
                      final role = userDoc.get('role');
                      if (role == 'Restaurant Manager') {
                        final restaurantName = userDoc.get('restaurantName');
                        return ResturantAnnouncmentScreen(restaurantName: restaurantName);
                      } else if (role == 'Driver') {
                        final firstName = userDoc.get('firstName');
                        final lastName = userDoc.get('lastName');
                        final fullName = '$firstName $lastName';
                        return DriverScreen(driverName: fullName);
                      }
                    }
                  }
                  // Default to WelcomeScreen if role or data is not found
                  return WelcomeScreen();
                },
              );
            } else {
              // User is not signed in
              return LoginScreen();
            }
          }
          // While loading
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
