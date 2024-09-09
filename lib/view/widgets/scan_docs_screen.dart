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
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        print('Image picked: ${pickedFile.path}');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No image selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String scanButtonText = '';
    String setLocationButtonText = '';

    switch (widget.role) {
      case 'Restaurant Manager':
        scanButtonText = 'Scan Restaurant License';
        setLocationButtonText = 'Set Restaurant Location';
        break;
      case 'Driver':
        scanButtonText = 'Scan Driver License';
        setLocationButtonText = 'Set Driver Location';
        break;
      case 'Hotel Manager':
        scanButtonText = 'Scan Hotel License';
        setLocationButtonText = 'Set Hotel Location';
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _pickImage,
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
                  const Icon(Icons.camera_alt, color: Colors.black),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final pickedLocation = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocationPickerScreen(),
                  ),
                );
                if (pickedLocation != null) {
                  print('Picked location: $pickedLocation');
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
                  const Icon(Icons.location_on, color: Colors.black),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
