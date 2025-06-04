import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Page',
      theme: ThemeData(
        brightness: Brightness.light, // Overall light theme for the background
        colorSchemeSeed: Colors.blue, // Just a seed, actual colors are defined below
      ),
      home: const DevicePage(),
    );
  }
}

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background as in the image
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // No shadow for the app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          'Devices',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Device Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black, // Dark background for the card
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Click here to add some more devices in your smart home',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Handle Add Device
                          },
                          icon: const Icon(Icons.add, color: Colors.black),
                          label: const Text(
                            'Add Device',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // White button background
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Placeholder for the illustration (replace with actual image asset if available)
                  // For now, a simple container to represent the space
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                     
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset("assets/images/boy.png"),
                    

                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background for search bar
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search Devices',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.black54),
                  hintStyle: TextStyle(color: Colors.black54),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20.0),

            // Browse here section
            const Text(
              'Browse here',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15.0),
            GridView.builder(
              shrinkWrap: true, // Important for GridView inside SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns as in the image
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.9, // Adjust aspect ratio to fit the card content
              ),
              itemCount: 3, // As per the image, there are 3 TV cards
              itemBuilder: (context, index) {
                return DeviceCard(
                  deviceName: 'Tv',
                  // You can add an actual image asset here if you have it
                  // deviceImage: 'assets/tv_placeholder.png',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final String deviceName;
  // final String? deviceImage; // Uncomment if you want to use actual images

  const DeviceCard({
    super.key,
    required this.deviceName,
    // this.deviceImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.black, // Dark background for device cards
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Container(
                // Placeholder for the TV image
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[800], // Dark grey placeholder for TV screen
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(Icons.tv, color: Colors.white70, size: 50), // Generic TV icon
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                deviceName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.black, size: 20),
                  onPressed: () {
                    // Handle adding this specific device
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}