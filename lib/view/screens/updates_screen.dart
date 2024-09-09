import 'package:flutter/material.dart';

class UpdatesPage extends StatefulWidget {
  const UpdatesPage({super.key});

  @override
  _UpdatesPageState createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage> {
  bool _hasUpdate = false;
  String _updateVersion = '1.0.0';
  String _currentVersion = '1.0.0';

  void _checkForUpdates() {
    // Simulate checking for updates
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        // Simulate finding an update
        _hasUpdate = true;
        _updateVersion = '1.1.0';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check for Updates'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Current Version'),
              subtitle: Text(_currentVersion),
              leading: const Icon(Icons.info),
            ),
            ListTile(
              title: const Text('Available Update'),
              subtitle: Text(_hasUpdate ? 'Version $_updateVersion' : 'No updates available'),
              leading: const Icon(Icons.update),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkForUpdates,
              child: const Text('Check for Updates'),
            ),
          ],
        ),
      ),
    );
  }
}
