import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        userData = snapshot.data() as Map<String, dynamic>?;
      });
    }
  }

  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<String?> uploadImage(XFile image) async {
    try {
      final String fileName =
          'user_${_auth.currentUser!.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference storageRef =
          _storage.ref().child('profile_pictures').child(fileName);
      final UploadTask uploadTask = storageRef.putFile(File(image.path));
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("<<<<<<Error uploading image: $e");
      return null;
    }
  }

  Future<void> _updateUserData(String field, String newValue) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({field: newValue});
      _loadUserData(); // Reload the data to reflect changes
    }
  }

  void _editField(BuildContext context, String field, String? initialValue) {
    TextEditingController controller =
        TextEditingController(text: initialValue ?? '');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: field),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateUserData(field, controller.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _changeProfilePicture() async {
    final XFile? image = await pickImage();
    if (image != null) {
      final String? downloadUrl = await uploadImage(image);
      if (downloadUrl != null) {
        //_updateUserData('profilePictureUrl', downloadUrl);
        await _updateUserProfilePicture(downloadUrl);
      }
    }
  }

  Future<void> _updateUserProfilePicture(String downloadUrl) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'profilePictureUrl': downloadUrl,
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: userData!['profilePictureUrl'] != null &&
                          userData!['profilePictureUrl'].isNotEmpty
                      ? NetworkImage(userData!['profilePictureUrl'])
                      : AssetImage('images/default_profile_picture.jpeg')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: _changeProfilePicture,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '${userData!['firstName'] ?? ''} ${userData!['lastName'] ?? ''}'
                  .trim(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
             Text(
              userData!['role'] ?? 'No first name', // Replace with actual role if needed
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
              title: const Text('First Name'),
              subtitle: Text(userData!['firstName'] ?? 'No first name'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () =>
                    _editField(context, 'firstName', userData!['firstName']),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Last Name'),
              subtitle: Text(userData!['lastName'] ?? 'No last name'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () =>
                    _editField(context, 'lastName', userData!['lastName']),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Contact'),
              subtitle: Text(userData!['phone'] ?? 'No contact'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () =>
                    _editField(context, 'phone', userData!['phone']),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: Text(userData!['email'] ?? 'No email'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () =>
                    _editField(context, 'email', userData!['email']),
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
            // Social media icons or additional information can go here
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
}
