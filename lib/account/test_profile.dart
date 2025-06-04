import 'package:flutter/material.dart';
import 'profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Test',
      home: UserProfileScreen(
        userName: "Anna Jennifer",
        userEmail: "annajennifer@gmail.com",
        userImage: "https://picsum.photos/200/200?random=1",
        followerCount: 1000,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
