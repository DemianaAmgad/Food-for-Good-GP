import 'package:flutter/material.dart';
import 'package:foodforgood/theme/app_styles.dart';
import 'package:foodforgood/view/screens/driver_screen.dart';
import 'package:foodforgood/view/screens/resturant_announcment_screen.dart';
import 'package:foodforgood/view/widgets/custom_button_widget.dart';
import 'package:foodforgood/view/widgets/scan_docs_screen.dart';

import '../widgets/signup_form_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _showSignupForm = true;
  String? _selectedRole;

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
              ? Center(child: Text('Signup', style: TextStyles.titleStyle.copyWith(color: AppColors.titleColor)))
              : null, // Hide the title when showing ScanDocScreen
          automaticallyImplyLeading: !_showSignupForm, // Show back button only when not showing SignupFormWidget
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: _showSignupForm
                ? SignupFormWidget(
              onContinuePressed: (role) {
                setState(() {
                  _selectedRole = role;
                  _showSignupForm = false; // Switch to ScanDocScreen
                });
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
                  MaterialPageRoute(builder: (context) => _selectedRole == "Driver"? const DriverScreen() : const ResturantAnnouncmentScreen()),
                );
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
