import 'package:flutter/material.dart';
import 'package:foodforgood/view/widgets/driver_start_screen.dart';

class DriverScreen extends StatefulWidget {
  //final String driverName;
  final String driverName;
  const DriverScreen({
    super.key,
    required this.driverName,
  });

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  @override
  Widget build(BuildContext context) {
    return DriverStartScreen(driverName: widget.driverName,);
  }
}
