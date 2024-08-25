// restaurant_announcement_screen
import 'package:flutter/material.dart';
import 'package:foodforgood/view/widgets/resturant_announcment_widget.dart';

class ResturantAnnouncmentScreen extends StatefulWidget {
  const ResturantAnnouncmentScreen({super.key});

  @override
  State<ResturantAnnouncmentScreen> createState() => _ResturantAnnouncmentScreenState();
}

class _ResturantAnnouncmentScreenState extends State<ResturantAnnouncmentScreen> {
  @override
  Widget build(BuildContext context) {
    return const NewAnnouncementScreen(restaurantName: 'Resturant A',);
  }
}
