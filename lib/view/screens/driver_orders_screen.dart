import 'package:flutter/material.dart';
import 'package:foodforgood/view/widgets/drivers_orders_widget.dart';

class DriverOrdersScreen extends StatefulWidget {
  const DriverOrdersScreen({super.key});

  @override
  State<DriverOrdersScreen> createState() => _DriverOrdersScreenState();
}

class _DriverOrdersScreenState extends State<DriverOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return const DriversOrdersWidget();
  }
}
