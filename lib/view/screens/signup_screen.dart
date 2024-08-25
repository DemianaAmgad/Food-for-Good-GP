// signup_screen.dart
import 'package:flutter/material.dart';
import 'package:foodforgood/theme/app_styles.dart';
import 'package:foodforgood/view/screens/driver_screen.dart';
import 'package:foodforgood/view/screens/resturant_announcment_screen.dart';
import 'package:foodforgood/view/widgets/scan_docs_screen.dart';
// widgets
import 'package:foodforgood/view/widgets/custom_button_widget.dart';
import '../widgets/signup_form_widget.dart';
// firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _showSignupForm = true;
  String? _selectedRole;

  void _navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _selectedRole == "Driver"
            ? const DriverScreen()  // Navigate to driver screen
            : const ResturantAnnouncmentScreen(), // Navigate to restaurant UX
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!_showSignupForm) {
          setState(() {
            _showSignupForm = true; // Show SignupFormWidget
          });
          return false; // Prevent default back navigation
        }
        return true; // Allow default back navigation (exit app or previous screen)
      },
      child: Scaffold(
        backgroundColor: AppColors.signupColor,
        appBar: AppBar(
          backgroundColor: AppColors.signupColor,
          title: _showSignupForm
              ? Center(
                  child: Text('Signup',
                      style: TextStyles.titleStyle
                          .copyWith(color: AppColors.titleColor)))
              : null, // Hide the title when showing ScanDocScreen
          automaticallyImplyLeading:
              !_showSignupForm, // Show back button only when not showing SignupFormWidget
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: _showSignupForm
                ? SignupFormWidget(
                    onContinuePressed: (role, email, password, firstName,
                        lastName, phone, birthdate) async {
                      setState(() {
                        _selectedRole = role;
                        _showSignupForm = false; // Switch to ScanDocScreen
                      });

                      try {
                        // Create user with email and password
                        UserCredential userCredential =
                            await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        // Handle successful user creation
                        User? user = userCredential.user;
                        if (user != null) {
                          print('User created: ${user.email}');
                          // Store additional user data
                          await _firestore
                              .collection('users')
                              .doc(user.uid)
                              .set({
                            'email': email,
                            'firstName': firstName,
                            'lastName': lastName,
                            'phone': phone,
                            'birthdate': birthdate,
                            'role': role,
                          });

                          _navigateToNextScreen(); // Navigate to the next screen
                        }
                      } catch (e) {
                        // Handle errors
                        print('Error creating user: $e');
                      }
                    },
                  )
                : ScanDocScreen(role: _selectedRole),
          ),
        ),
        bottomNavigationBar: !_showSignupForm
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButtonWidget(
                    text: 'Sign up',
                    onButtonPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => _selectedRole == "Driver"
                                ? const DriverScreen()
                                : const ResturantAnnouncmentScreen()),
                      );
                      // try {
                      //   final newUser =
                      //       await _auth.createUserWithEmailAndPassword(
                      //           email: , password: password);
                      // } catch (e) {
                      //   print(e);
                      // }
                    },
                    backgroundColor: AppColors.buttonLoginBackgroundColor,
                    textColor: AppColors.buttonLoginTextColor,
                  ),
                ),
              )
            : null, // Hide bottom navigation bar when showing SignupFormWidget
      ),
    );
  }
}
