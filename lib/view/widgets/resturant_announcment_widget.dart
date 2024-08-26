import 'package:flutter/material.dart';
import 'package:foodforgood/view/screens/announcement_details_screen.dart';

import '../../theme/app_styles.dart';

class NewAnnouncementScreen extends StatelessWidget {
  final String restaurantName;
  
  const NewAnnouncementScreen({super.key, required this.restaurantName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(restaurantName,
          style: TextStyles.titleStyle,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the details screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AnnouncementDetailsScreen(restaurantName: restaurantName,)),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(36.0),
            backgroundColor: AppColors.buttonLoginBackgroundColor,
            minimumSize: const Size(200, 200), // Increase the size of the button
          ),
          child: Text(
            'Set a \nNew Announcement',
            textAlign: TextAlign.center,
            style: TextStyles.buttonTextStyle.copyWith(
              color: AppColors.buttonLoginTextColor
            ),
          ),
        ),
      ),
    );
  }
}

