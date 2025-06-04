// welcome_page.dart
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void _onContinueWithEmail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _onSignUpNewAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Black gradient background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[400]!, Colors.black],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const LogoSection(),
              const SizedBox(height: 40),
              const WelcomeTextSection(),
              const Spacer(),
              ButtonSection(
                onContinueWithEmail: () => _onContinueWithEmail(context),
                onSignUpNewAccount: () => _onSignUpNewAccount(context),
              ),
              const SizedBox(height: 20),
              const TermsText(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        SizedBox(
          width: 500,
          height: 250,
          child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}

class WelcomeTextSection extends StatelessWidget {
  const WelcomeTextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,  // full width to stretch container
      alignment: Alignment.bottomLeft,
      child: const Text(
        'WELCOME TO\nSMART EY SMART\nYANG NIS',
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontFamily: 'IBM Plex Mono',
          height: 1.5,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

}

class ButtonSection extends StatelessWidget {
  final VoidCallback onContinueWithEmail;
  final VoidCallback onSignUpNewAccount;

  const ButtonSection({
    super.key,
    required this.onContinueWithEmail,
    required this.onSignUpNewAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onContinueWithEmail,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: const Text('Continue with Email'),
        ),
        const SizedBox(height: 15),
        Row(
          children: const [
            Expanded(child: Divider(color: Colors.white54)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'or',
                style: TextStyle(color: Colors.white54),
              ),
            ),
            Expanded(child: Divider(color: Colors.white54)),
          ],
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: onSignUpNewAccount,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: const Text('Sign Up with New Account'),
        ),
      ],
    );
  }
}

class TermsText extends StatelessWidget {
  const TermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'By Continue using SmartEySmartYangNis, you agree to our Term of Service and Privacy Policy. Personal Data added to application in private',
      style: TextStyle(
        color: Colors.white54,
        fontSize: 10,
      ),
      textAlign: TextAlign.center,
    );
  }
}
