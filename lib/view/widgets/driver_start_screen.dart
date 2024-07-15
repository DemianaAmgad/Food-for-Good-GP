import 'package:flutter/material.dart';
import 'package:foodforgood/view/screens/driver_orders_screen.dart';

import '../../theme/app_styles.dart';

class DriverStartScreen extends StatelessWidget {
  const DriverStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Hi, Sam Harris', style: TextStyles.titleStyle,),
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
                style: TextStyles.subtitleStyle,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 80,
          height: 80,
          child: FloatingActionButton(
            onPressed: () {
              print('Start delivery');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DriverOrdersScreen()),
              );
            },
            backgroundColor: AppColors.buttonLoginBackgroundColor,
            shape: const CircleBorder(),
            child: Text("Start", style: TextStyles.buttonTextStyle.copyWith(color: AppColors.buttonLoginTextColor),),
          ),
        ),
      ),
    );
  }
}