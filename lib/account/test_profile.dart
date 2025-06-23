import 'package:flutter/material.dart';
import 'profile_screen.dart'; // already uses Firebase

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Test',
      home: UserProfileScreen(), // no parameters
      debugShowCheckedModeBanner: false,
    );
  }
}
