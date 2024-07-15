import 'package:flutter/material.dart';
import 'package:foodforgood/theme/app_styles.dart';
import 'package:foodforgood/view/screens/signup_screen.dart';
import 'package:foodforgood/view/widgets/login_form_widget.dart';

import '../widgets/custom_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  void _validateAndSubmit() {
    print("logged in");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const _Title("Login"),
                const SizedBox(height: 24),
                LoginFormWidget(onLoginPressed: _validateAndSubmit), // Use the LoginForm
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const _signUpNavigation(),
    );
  }
}

class _Title extends StatelessWidget {
  final String text;

  const _Title(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyles.titleStyle.copyWith(color: AppColors.titleColor),
      ),
    );
  }
}

class _signUpNavigation extends StatelessWidget {
  const _signUpNavigation();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              // Handle sign up navigation
            },
            child: Text(
              "Don't have an account?",
              style: TextStyles.normalStyle.copyWith(color: AppColors.doYouHaveAccountColor),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: CustomButtonWidget(
              text: 'Sign up',
              onButtonPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
