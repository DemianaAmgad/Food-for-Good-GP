import 'package:flutter/material.dart';
import 'package:foodforgood/view/widgets/driver_start_screen.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  @override
  Widget build(BuildContext context) {
    return const DriverStartScreen();
  }
}
