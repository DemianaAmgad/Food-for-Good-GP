import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Import google_maps_flutter for map functionality

class LocationPickerScreen extends StatefulWidget {
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng _pickedLocation = LatLng(37.7749, -122.4194); // Default location (San Francisco)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Location'), // AppBar title
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pickedLocation, // Initial map position
          zoom: 12,
        ),
        onTap: (LatLng location) {
          setState(() {
            _pickedLocation = location; // Update picked location on tap
          });
        },
        markers: {
          Marker(
            markerId: MarkerId('picked_location'),
            position: _pickedLocation, // Marker at picked location
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, _pickedLocation); // Return the picked location to the previous screen
        },
        child: Icon(Icons.check), // Check icon for confirming the location
      ),
    );
  }
}
