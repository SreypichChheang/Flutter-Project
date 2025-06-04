import 'package:flutter/material.dart';

class BluetoothPairingScreen extends StatelessWidget {
  const BluetoothPairingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please set the device into pairing mode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Choose a 2.4GHz Wi-Fi for device pairing and enter the right password',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'If your 2.4GHz Wi-Fi and 5Ghz Wi-Fi share the same WiFi SSID, you\'re recommended to change your router settings or try compatible pairing mode.',
              style: TextStyle(fontSize: 16),
            ),
            const Divider(height: 30),
            const Text(
              'Support adding WiFi and Bluetooth devices',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('GIC-Student'),
              subtitle: const Text('*********'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  // Handle connection
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}