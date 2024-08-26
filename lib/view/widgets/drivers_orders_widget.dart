import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodforgood/view/widgets/order_card_widget.dart';
import '../../theme/app_styles.dart';

class DriversOrdersWidget extends StatelessWidget {
  const DriversOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Announcements',
          style: TextStyles.titleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('announcements')
              .where('acceptedBy', isEqualTo: null)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final announcements = snapshot.data!.docs;

            if (announcements.isEmpty) {
              return const Center(child: Text('No announcements available.'));
            }

            return ListView.builder(
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final announcement = announcements[index];
                final rejectedBy = List<String>.from(announcement['rejectedBy'] ?? []);

                if (rejectedBy.contains(FirebaseAuth.instance.currentUser!.uid)) {
                  return const SizedBox.shrink(); // Don't show if rejected by current user
                }

                return _buildOrderCard(
                  context,
                  announcement.id, // Pass the document ID for accepting/rejecting
                  announcement['restaurantName'],
                  announcement['location'],
                  announcement['quantity'],
                  announcement['unit'],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrderCard(
      BuildContext context, String announcementId, String restaurantName, String location, int quantity, String unit) {
    return OrderCardWidget(
      restaurantName: restaurantName,
      location: location,
      quantity: quantity,
      unit:unit,
      onAccept: () => _acceptAnnouncement(announcementId),
      onReject: () => _rejectAnnouncement(announcementId),
    );
  }

  void _acceptAnnouncement(String announcementId) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('announcements').doc(announcementId).update({
      'acceptedBy': userId,
    });
  }

  void _rejectAnnouncement(String announcementId) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('announcements').doc(announcementId).update({
      'rejectedBy': FieldValue.arrayUnion([userId]),
    });
  }
}
