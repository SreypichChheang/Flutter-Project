import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'set_new_password.dart';

class OTPVerifyScreen extends StatefulWidget {
  final String email;
  const OTPVerifyScreen({super.key, required this.email});

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  final _otpController = TextEditingController();
  bool isLoading = false;

  Future<void> verifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final callable = FirebaseFunctions.instance.httpsCallable('verifyOtpAndReturnToken');
      final result = await callable.call({
        'email': widget.email,
        'otp': otp,
      });

      final token = result.data['token'];
      await FirebaseAuth.instance.signInWithCustomToken(token);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SetNewPasswordScreen(email: widget.email),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Verification failed: ${e.toString()}")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text("We sent an OTP to ${widget.email}"),
            const SizedBox(height: 20),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter OTP",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: isLoading ? null : verifyOtp,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Verify & Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
