import 'package:flutter/material.dart';
import 'package:foodforgood/theme/app_styles.dart';
import 'package:foodforgood/view/widgets/custom_text_field_widget.dart';
import 'package:foodforgood/view/widgets/password_field_widget.dart';
import 'custom_button_widget.dart';
import 'package:foodforgood/view/screens/driver_screen.dart';
import 'package:foodforgood/view/screens/resturant_announcment_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginFormWidget extends StatefulWidget {
  final VoidCallback onLoginPressed;

  const LoginFormWidget({required this.onLoginPressed, super.key});

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  Future<void> _login() async {
    try {
      // Sign in the user
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Fetch the user data from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          // Retrieve user data
          String firstName = userDoc.get('firstName');
          String lastName = userDoc.get('lastName');
          String role = userDoc.get('role');

          // Build the full name
          String fullName = '$firstName $lastName';

          // Navigate based on the role
          if (role == 'Restaurant Manager') {
            String restaurantName = userDoc.get('restaurantName');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ResturantAnnouncmentScreen(
                  restaurantName: restaurantName,
                ),
              ),
              (route) => false, // Remove all previous routes to stay logged in
            );
          } else if (role == 'Driver') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DriverScreen(driverName: fullName)),
            );
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth errors
      print("Error: ${e.message}");
      setState(() {
        _emailError =
            e.code == 'user-not-found' ? "No user found with this email" : null;
        _passwordError =
            e.code == 'wrong-password' ? "Incorrect password" : null;
      });
    } catch (e) {
      // Handle general errors
      print("An unexpected error occurred: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_validatePassword);
  }

  void _validateEmail() {
    setState(() {
      _emailError = _validateEmailText(_emailController.text);
    });
  }

  void _validatePassword() {
    setState(() {
      _passwordError = _validatePasswordText(_passwordController.text);
    });
  }

  String? _validateEmailText(String email) {
    if (email.isEmpty) {
      return "Email cannot be empty";
    }
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(email)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? _validatePasswordText(String password) {
    if (password.isEmpty) {
      return "Password cannot be empty";
    }
    if (password.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _CustomLabelText("E-mail"),
        const SizedBox(height: 8),
        CustomTextFieldWidget(
          controller: _emailController,
          hintText: "Enter your email",
          errorText: _emailError,
          onChanged: (text) {
            _validateEmail();
          },
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        const _CustomLabelText("Password"),
        const SizedBox(height: 8),
        PasswordFieldWidget(
          controller: _passwordController,
          errorText: _passwordError,
          onChanged: (text) {
            _validatePassword();
          },
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              print("Forgot password tapped");
            },
            child: Text(
              "Forget password?",
              style: TextStyles.normalStyle
                  .copyWith(color: AppColors.forgetPasswordColor),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: CustomButtonWidget(
            text: 'Login',
            onButtonPressed: () {
              _validateEmail();
              _validatePassword();
              if (_emailError == null && _passwordError == null) {
                _login(); // Call _login method when validation passes
              }
            },
            backgroundColor: AppColors.buttonLoginBackgroundColor,
            textColor: AppColors.buttonLoginTextColor,
          ),
        ),
      ],
    );
  }
}

class _CustomLabelText extends StatelessWidget {
  final String text;

  const _CustomLabelText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style:
            TextStyles.subtitleStyle.copyWith(color: AppColors.subtitleColor));
  }
}
