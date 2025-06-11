import 'package:app/dashboard/home_page.dart';
import 'package:app/device/add_device_screen.dart';
import 'package:flutter/material.dart';
import 'authentication/welcome_screen.dart';

void main() {
  runApp(const SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),  // call the welcome page here
    );
  }
}