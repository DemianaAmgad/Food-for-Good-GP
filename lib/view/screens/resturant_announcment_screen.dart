import 'package:flutter/material.dart';
import 'package:foodforgood/view/widgets/resturant_announcment_widget.dart';

class ResturantAnnouncmentScreen extends StatelessWidget {
  final String restaurantName;

  const ResturantAnnouncmentScreen({Key? key, required this.restaurantName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewAnnouncementScreen(restaurantName: restaurantName);
  }
}
