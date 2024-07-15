import 'package:flutter/material.dart';

import '../../theme/app_styles.dart';

class ScanDocScreen extends StatelessWidget {
  final String? role;

  const ScanDocScreen({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String scanButtonText = '';
    String setLocationButtonText = '';

    switch (role) {
      case 'Restaurant Manager':
        scanButtonText = 'Scan Restaurant License';
        setLocationButtonText = 'Set Restaurant Location';
        break;
      case 'Driver':
        scanButtonText = 'Scan Driver License';
        setLocationButtonText = 'Set Driver Location';
        break;
      case 'Factory Manager':
        scanButtonText = 'Scan Factory License';
        setLocationButtonText = 'Set Factory Location';
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Handle scanning license based on role
                print(scanButtonText);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      scanButtonText,
                      textAlign: TextAlign.left,
                      style: TextStyles.buttonTextStyle.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(Icons.camera_alt, color: Colors.black),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Handle setting location based on role
                print(setLocationButtonText);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      setLocationButtonText,
                      textAlign: TextAlign.left,
                      style: TextStyles.buttonTextStyle.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(Icons.location_on, color: Colors.black,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
