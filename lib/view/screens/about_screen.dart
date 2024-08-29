import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'About This App',
            ),
            SizedBox(height: 10),
            Text(
              'Version: 1.0.0',
            ),
            SizedBox(height: 20),
            Text(
              'Developed by:',
            ),
            Text(
              'Food for Good',
            ),
            Text(
              '820 N 17th st, Suite 100\Lincoln, Nebraska, 68508',
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us:',
            ),
            Text(
              'Email: support@foodforgood.com\nPhone: +20 1090825437',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to a page with more detailed information, if needed
              },
              child: Text('Learn More'),
            ),
          ],
        ),
      ),
    );
  }
}
