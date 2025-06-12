import 'package:flutter/material.dart';

// You can run this file directly to see this specific UI
void main() {
  runApp(const AddDevice());
}

class AddDevice extends StatelessWidget {
  const AddDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Device Page',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.grey, // For app bar and general theme
      ),
      home: const AddDevicePage(),
    );
  }
}

class AddDevicePage extends StatelessWidget {
  const AddDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          'Add Device',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // QR Code Placeholder
              Container(
                width: 200, // Adjust size as needed
                height: 200, // Adjust size as needed
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2), // QR scan frame
                  color: Colors.black, // Placeholder for QR code
                ),
                child: const Center(
                  child: Icon(Icons.qr_code, color: Colors.white, size: 150),
                ),
              ),
              const SizedBox(height: 40.0),
              const Text(
                "Let's scanning your smart device",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50.0),
              // Scan Button
              SizedBox(
                width: double.infinity, // Full width button
                height: 55, // Height of the button
                child: ElevatedButton(
                  onPressed: () {
                    // Handle scan button press (e.g., launch QR scanner)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Black button background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scan',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}