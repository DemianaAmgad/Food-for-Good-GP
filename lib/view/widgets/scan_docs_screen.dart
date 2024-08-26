import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker for scanning functionality
import 'location_picker_screen.dart'; // Import the new location picker screen

class ScanDocScreen extends StatefulWidget {
  final String? role;

  const ScanDocScreen({super.key, required this.role});

  @override
  _ScanDocScreenState createState() => _ScanDocScreenState();
}

class _ScanDocScreenState extends State<ScanDocScreen> {
  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker for scanning

  // Method to pick an image from the camera
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera); // Open the camera
    if (pickedFile != null) {
      // Handle the picked image, e.g., upload it
      print('Image picked: ${pickedFile.path}'); // Print the path of the picked image
    }
  }

  @override
  Widget build(BuildContext context) {
    String scanButtonText = '';
    String setLocationButtonText = '';

    // Set button texts based on the role
    switch (widget.role) {
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
              onPressed: _pickImage, // Call _pickImage method to scan document
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      scanButtonText,
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(Icons.camera_alt, color: Colors.black), // Camera icon
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                // Navigate to the location picker screen
                final pickedLocation = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocationPickerScreen(), // Create the LocationPickerScreen
                  ),
                );
                if (pickedLocation != null) {
                  print('Picked location: $pickedLocation'); // Print the picked location
                }
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
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(Icons.location_on, color: Colors.black), // Location icon
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
