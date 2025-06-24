import 'package:app/dashboard/home_page.dart';
import 'package:app/device/add_device_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'authentication/auth_service.dart';
import 'authentication/welcome_screen.dart';
import 'authentication/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width for scaling based on device size
    double screenWidth = MediaQuery.of(context).size.width;

    // Set a scaling factor based on screen width
    double scale = screenWidth < 350 ? 0.8 : 1.0; // Example for small devices

    return MaterialApp(
      title: 'Smart Home',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,   // Keep text scale to default for accessibility
            devicePixelRatio: 1.0,  // Force pixel ratio
          ),
          child: Transform.scale(
            scale: scale,  // Apply dynamic scaling based on screen width
            child: child!,
          ),
        );
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 14),
          bodyMedium: TextStyle(fontSize: 12),
          titleLarge: TextStyle(fontSize: 18),
          titleMedium: TextStyle(fontSize: 16),
          titleSmall: TextStyle(fontSize: 14),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 14),
          bodyMedium: TextStyle(fontSize: 12),
          titleLarge: TextStyle(fontSize: 18),
          titleMedium: TextStyle(fontSize: 16),
          titleSmall: TextStyle(fontSize: 14),
        ),
      ),
      home: const AuthWrapper(),
    );
  }
}
