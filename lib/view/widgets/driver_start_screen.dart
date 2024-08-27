import 'package:flutter/material.dart';
import 'package:foodforgood/view/screens/driver_orders_screen.dart';
import '../../theme/app_styles.dart';
import '../screens/accepted_requests_screen.dart';

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
        title: Text(
          'Hi, $driverName!',
          style: TextStyles.titleStyle.copyWith(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: AppColors.titleColor
          ),
        ),
        centerTitle: true,
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
