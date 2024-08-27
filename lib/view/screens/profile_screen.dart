import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://example.com/path_to_image.jpg'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Morgan James',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Driver',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Icon(
                  Icons.circle,
                  color: Colors.green,
                  size: 12,
                ),
                SizedBox(width: 4),
                Text('Active Now'),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Username'),
              subtitle: Text('Morgan.JamesDesigner'),
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('Contact'),
              subtitle: Text('+24500000000'),
            ),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('mjdesigner@gmail.com'),
            ),
            const Divider(),
            const Text(
              'Other Ways People Can Find Me',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialIconButton(Icons.twelve_mp_sharp, Colors.lightBlue),
                _buildSocialIconButton(Icons.ice_skating, Colors.pink),
                _buildSocialIconButton(Icons.facebook, Colors.blue),
                _buildSocialIconButton(Icons.linked_camera, Colors.blueAccent),
              ],
            ),
            const Spacer(),
            const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Help and Feedback'),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIconButton(IconData icon, Color color) {
    return CircleAvatar(
      backgroundColor: color,
      child: Icon(icon, color: Colors.white),
    );
  }
}
