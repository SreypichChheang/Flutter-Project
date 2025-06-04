import 'package:flutter/material.dart';

void main() => runApp(LandingPage());

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SmartHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Define a simple Device class
class Device {
  final IconData icon;
  final String title;
  final String subtitle;
  bool isOn;

  Device({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isOn = false,
  });
}

class SmartHomeScreen extends StatefulWidget {
  @override
  _SmartHomeScreenState createState() => _SmartHomeScreenState();
}

class _SmartHomeScreenState extends State<SmartHomeScreen> {
  String selectedTab = 'All'; // Default selected tab
  List<String> tabs = [
    'All',
    'Living Room',
    'Bathroom',
    'Kitchen',
    'Bedroom',
    'Office',
    'Outdoor',
  ];

  // Map to store devices for each room/tab
  final Map<String, List<Device>> roomDevices = {
    'All': [
      Device(
        icon: Icons.ac_unit,
        title: "Air Conditioner",
        subtitle: "4 devices",
        isOn: false,
      ),
      Device(
        icon: Icons.lightbulb_outline,
        title: "Main Lighting",
        subtitle: "4 lamps",
        isOn: true,
      ),
      Device(
        icon: Icons.speaker_group,
        title: "Sound System",
        subtitle: "2 devices",
        isOn: false,
      ),
      Device(
        icon: Icons.tv,
        title: "Smart TV",
        subtitle: "1 device",
        isOn: true,
      ),
      Device(
        icon: Icons.camera_alt,
        title: "Security Camera",
        subtitle: "3 devices",
        isOn: false,
      ),
    ],
    'Living Room': [
      Device(
        icon: Icons.lightbulb_outline,
        title: "Living Room Lamp",
        subtitle: "2 lamps",
        isOn: true,
      ),
      Device(
        icon: Icons.tv,
        title: "Smart TV",
        subtitle: "1 device",
        isOn: true,
      ),
      Device(
        icon: Icons.speaker_group,
        title: "Sound System",
        subtitle: "2 devices",
        isOn: false,
      ),
    ],
    'Bathroom': [
      Device(
        icon: Icons.lightbulb_outline,
        title: "Bathroom Light",
        subtitle: "1 lamp",
        isOn: false,
      ),
      Device(
        icon: Icons.water_drop_outlined,
        title: "Water Heater",
        subtitle: "1 device",
        isOn: false,
      ),
    ],
    'Kitchen': [
      Device(
        icon: Icons.kitchen,
        title: "Refrigerator",
        subtitle: "1 device",
        isOn: true,
      ),
      Device(
        icon: Icons.lightbulb_outline,
        title: "Kitchen Light",
        subtitle: "2 lamps",
        isOn: false,
      ),
      Device(
        icon: Icons.microwave,
        title: "Microwave",
        subtitle: "1 device",
        isOn: false,
      ),
    ],
    'Bedroom': [
      Device(
        icon: Icons.bed,
        title: "Bedroom Lamp",
        subtitle: "2 lamps",
        isOn: true,
      ),
      Device(
        icon: Icons.ac_unit,
        title: "Bedroom AC",
        subtitle: "1 device",
        isOn: false,
      ),
      Device(
        icon: Icons.alarm,
        title: "Smart Alarm",
        subtitle: "1 device",
        isOn: true,
      ),
    ],
    'Office': [
      Device(
        icon: Icons.computer,
        title: "Office PC",
        subtitle: "1 device",
        isOn: true,
      ),
      Device(
        icon: Icons.lightbulb_outline,
        title: "Desk Lamp",
        subtitle: "1 lamp",
        isOn: false,
      ),
    ],
    'Outdoor': [
      Device(
        icon: Icons.outdoor_grill,
        title: "Garden Lights",
        subtitle: "3 lamps",
        isOn: false,
      ),
      Device(
        icon: Icons.local_car_wash,
        title: "Sprinkler System",
        subtitle: "1 device",
        isOn: false,
      ),
      Device(
        icon: Icons.security,
        title: "Outdoor Camera",
        subtitle: "1 device",
        isOn: true,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWeatherCard(),
            _buildTabBar(),
            Expanded(
              child: _buildDeviceGrid(),
            ), // This widget will now adapt based on selectedTab
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(20),
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5B9EE1), Color(0xFF4C8CD2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '23 °C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phnom Penh, Cambodia',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Cloudy',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Image.network(
                  'https://cdn-icons-png.flaticon.com/512/1163/1163624.png', // Example URL for a cloudy icon
                  width: 60,
                  height: 60,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _weatherInfo("Mon, March 31", "28°C"),
                _weatherInfo("Humidity", "40%"),
                _weatherInfo("Air Quality", "Good"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _weatherInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 36,
      margin: EdgeInsets.only(left: 16, top: 20, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = selectedTab == tab;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = tab; // Update the selected tab
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tab,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isSelected ? Colors.black : Colors.grey[600],
                    ),
                  ),
                  if (isSelected)
                    Container(
                      height: 2,
                      width: 20,
                      margin: EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDeviceGrid() {
    // Get the list of devices for the currently selected tab
    final List<Device> currentDevices = roomDevices[selectedTab] ?? [];

    return Padding(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        // Use GridView.builder for dynamic lists
        itemCount: currentDevices.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.95,
        ),
        itemBuilder: (context, index) {
          final device = currentDevices[index];
          return _deviceCard(
            device.icon,
            device.title,
            device.subtitle,
            device.isOn,
            // Pass a callback to update the device state
            (newValue) {
              setState(() {
                device.isOn = newValue;
              });
            },
          );
        },
      ),
    );
  }

  // Modified _deviceCard to accept an onChanged callback for the Switch
  Widget _deviceCard(
    IconData icon,
    String title,
    String subtitle,
    bool isOn,
    Function(bool) onSwitchChanged,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          Spacer(),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(subtitle, style: TextStyle(color: Colors.white54, fontSize: 12)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isOn ? "ON" : "OFF",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: isOn,
                  onChanged: onSwitchChanged, // Use the provided callback
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  activeTrackColor: Colors.blueAccent,
                  inactiveTrackColor: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
