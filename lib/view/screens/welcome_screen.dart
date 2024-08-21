import 'package:flutter/material.dart';

import '../../theme/app_styles.dart';
import '../widgets/custom_button_widget.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 180,
              child: Image.asset('images/logo.png'),
            ),
            const Text(
              'Save food ... Save the world',
              style: TextStyle(
                color: AppColors.buttonTextColor,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(
              height: 50,
            ),
            // login button
            SizedBox(
              width: double.infinity,
              child: CustomButtonWidget(
                text: 'Login',
                onButtonPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ),
            // signup button
            SizedBox(
              width: double.infinity,
              child: CustomButtonWidget(
                text: 'Sign up',
                onButtonPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
