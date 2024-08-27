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
              backgroundImage: NetworkImage(''), // image path
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
              children: [
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
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Username'),
              subtitle: const Text('Morgan.JamesDesigner'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Add your edit action here
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Contact'),
              subtitle: const Text('+24500000000'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Add your edit action here
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('mjdesigner@gmail.com'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Add your edit action here
                },
              ),
            ),
            const Divider(),
            const Text(
              'Other Ways People Can Find Me',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Column(
              children: [
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
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
