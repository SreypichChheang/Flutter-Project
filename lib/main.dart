import 'package:flutter/material.dart';
import 'authentication/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // no package: prefix needed

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // 👈 uses your firebase_options.dart
  );
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
