import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodforgood/theme/app_styles.dart';

import '../widgets/custom_button_widget.dart';

class AcceptedRequestsPage extends StatefulWidget {
  const AcceptedRequestsPage({super.key});

  @override
  _AcceptedRequestsPageState createState() => _AcceptedRequestsPageState();
}

class _AcceptedRequestsPageState extends State<AcceptedRequestsPage> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  void _markAsDelivered(String announcementId) {
    FirebaseFirestore.instance.collection('announcements').doc(announcementId).update({
      'delivered': true,
    }).then((_) {
      // Show thank you message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thank you! The delivery has been recorded.')),
      );

      // Remove the delivered item from the list
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accepted Requests'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('announcements')
              .where('acceptedBy', isEqualTo: userId)
              .where('delivered', isEqualTo: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final acceptedAnnouncements = snapshot.data!.docs;

            if (acceptedAnnouncements.isEmpty) {
              return const Center(child: Text('No accepted requests.'));
            }

            return ListView.builder(
              itemCount: acceptedAnnouncements.length,
              itemBuilder: (context, index) {
                final announcement = acceptedAnnouncements[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              announcement['restaurantName'],
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: AppColors.iconColor),
                                const SizedBox(width: 5.0),
                                Text(
                                  announcement['location'],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: AppColors.iconColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                const Icon(Icons.fastfood, color: AppColors.iconColor),
                                const SizedBox(width: 5.0),
                                Text(
                                  '${announcement['quantity']} ${announcement['unit']}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: AppColors.iconColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            announcement['pickedUp']
                                ? const Text('Picked up! Go to factory', style: TextStyle(color: AppColors.buttonTextColor))
                                : CustomButtonWidget(
                                  backgroundColor: AppColors.buttonTextColor,
                                    text: 'Pick up',
                                    textColor: Colors.white,
                                    onButtonPressed: () {
                                      setState(() {
                                        FirebaseFirestore.instance
                                            .collection('announcements')
                                            .doc(announcement.id)
                                            .update({'pickedUp': true});
                                      });
                                    },
                                  ),
                            if (announcement['pickedUp'])
                              CustomButtonWidget(
                                text: 'Delivered',
                                backgroundColor: AppColors.buttonTextColor,
                                textColor: Colors.white,
                                onButtonPressed: () {
                                  _markAsDelivered(announcement.id);
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
