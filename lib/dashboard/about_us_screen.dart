import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Us Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AboutUsPage(),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // White background for app bar
        elevation: 0, // No shadow
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple, // Purple background for icon
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                // Handle back button press
              },
            ),
          ),
        ),
        title: const Text(
          'About Us',
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
            // Introduction/Description Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Smart home technology is a system that allows users to control home appliances, lighting, etc., allowing homeowners to remotely manage and monitor their systems, integrating with multiple devices for improved automation, enhancing convenience, security and energy savings.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: Container(
                    // Placeholder for the smart home illustration
                    height: 120, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Light grey placeholder
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(Icons.house_siding_outlined,
                        size: 60, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),

            // "Process to do it" Section
            const Text(
              'Process to do it',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20.0),
            _buildProcessTimeline(),
            const SizedBox(height: 30.0),

            // "Why should we use this application?" Section
            const Text(
              'Why should we use this application?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20.0),
            _buildWhyUseAppGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessTimeline() {
    final List<String> processSteps = [
      'Sign Up & Login',
      'Connect Your Smart Devices',
      'Customize Your Settings',
      'Setup a Voice Control',
      'Build & Control',
    ];

    return SizedBox(
      height: 100, // Adjust height to accommodate circles and text
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: processSteps.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple, // Purple circle
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: 80, // Fixed width for text to prevent overflow
                    child: Text(
                      processSteps[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
              if (index < processSteps.length - 1)
                Container(
                  width: 50, // Length of the line
                  height: 2.0,
                  color: Colors.deepPurple[100], // Light purple line
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWhyUseAppGrid() {
    final List<Map<String, dynamic>> features = [
      {'icon': Icons.lightbulb_outline, 'text': 'Energy Saving'},
      {'icon': Icons.devices_other, 'text': 'Smart Control'},
      {'icon': Icons.security, 'text': 'Security'},
      {'icon': Icons.integration_instructions, 'text': 'Easy Integration'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.2, // Adjust as needed for better spacing
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple[50], // Light purple background
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                features[index]['icon'] as IconData,
                size: 40,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 10),
              Text(
                features[index]['text'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}