import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../dashboard/home_page.dart';
import 'welcome_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Check if auth state is still loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }

        // If user is logged in, show main app
        if (snapshot.hasData && snapshot.data != null) {
          return const SmartHomeApp();
        }

        // If user is not logged in, show welcome screen
        return const WelcomePage();
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
