import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'otp_verify_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();
  bool isLoading = false;

  Future<void> sendOtp() async {
    final email = _emailController.text.trim();

    if (!email.contains('@') || email.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email.")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final callable = FirebaseFunctions.instance.httpsCallable('sendOtp');
      await callable.call({'email': email});

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OTPVerifyScreen(email: email),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send OTP: ${e.toString()}")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text("Enter your email to receive a reset OTP"),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: isLoading ? null : sendOtp,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Send OTP"),
            )
          ],
        ),
      ),
    );
  }
}
