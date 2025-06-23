// landing_page.dart
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: const SmartHomeScreen(),
    );
  }
}

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
  const SmartHomeScreen({super.key});

  @override
  State<SmartHomeScreen> createState() => _SmartHomeScreenState();
}

class _SmartHomeScreenState extends State<SmartHomeScreen> {
  String selectedTab = 'All';
  final List<String> tabs = [
    'All',
    'Living Room',
    'Bathroom',
    'Kitchen',
    'Bedroom',
    'Office',
    'Outdoor',
  ];

  final Map<String, List<Device>> roomDevices = {
    'All': [
      Device(icon: Icons.ac_unit, title: "Air Conditioner", subtitle: "4 devices"),
      Device(icon: Icons.lightbulb_outline, title: "Main Lighting", subtitle: "4 lamps", isOn: true),
      Device(icon: Icons.speaker_group, title: "Sound System", subtitle: "2 devices"),
      Device(icon: Icons.tv, title: "Smart TV", subtitle: "1 device", isOn: true),
      Device(icon: Icons.camera_alt, title: "Security Camera", subtitle: "3 devices"),
    ],
    'Living Room': [
      Device(icon: Icons.lightbulb_outline, title: "Living Room Lamp", subtitle: "2 lamps", isOn: true),
      Device(icon: Icons.tv, title: "Smart TV", subtitle: "1 device", isOn: true),
      Device(icon: Icons.speaker_group, title: "Sound System", subtitle: "2 devices", isOn: false),
    ],
    'Bathroom': [
      Device(icon: Icons.lightbulb_outline, title: "Bathroom Light", subtitle: "1 lamp", isOn: false),
      Device(icon: Icons.water_drop_outlined, title: "Water Heater", subtitle: "1 device", isOn: false),
    ],
    'Kitchen': [
      Device(icon: Icons.kitchen, title: "Refrigerator", subtitle: "1 device", isOn: true),
      Device(icon: Icons.lightbulb_outline, title: "Kitchen Light", subtitle: "2 lamps", isOn: false),
      Device(icon: Icons.microwave, title: "Microwave", subtitle: "1 device", isOn: false),
    ],
    'Bedroom': [
      Device(icon: Icons.bed, title: "Bedroom Lamp", subtitle: "2 lamps", isOn: true),
      Device(icon: Icons.ac_unit, title: "Bedroom AC", subtitle: "1 device", isOn: false),
      Device(icon: Icons.alarm, title: "Smart Alarm", subtitle: "1 device", isOn: true),
    ],
    'Office': [
      Device(icon: Icons.computer, title: "Office PC", subtitle: "1 device", isOn: true),
      Device(icon: Icons.lightbulb_outline, title: "Desk Lamp", subtitle: "1 lamp", isOn: false),
    ],
    'Outdoor': [
      Device(icon: Icons.outdoor_grill, title: "Garden Lights", subtitle: "3 lamps", isOn: false),
      Device(icon: Icons.local_car_wash, title: "Sprinkler System", subtitle: "1 device", isOn: false),
      Device(icon: Icons.security, title: "Outdoor Camera", subtitle: "1 device", isOn: true),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWeatherCard(isDarkMode),
          _buildTabBar(theme, isDarkMode),
          Expanded(child: _buildDeviceGrid(theme, isDarkMode)),
        ],
      ),
    );
  }

  Widget _buildWeatherCard(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode 
            ? [const Color(0xFF1E3A8A), const Color(0xFF1E40AF)]
            : [const Color(0xFF5B9EE1), const Color(0xFF4C8CD2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '23 °C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              const Column(
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
              const Spacer(),
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/1163/1163624.png',
                width: 60,
                height: 60,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mon, March 31', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text(
                    '28°C',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Humidity', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text(
                    '40%',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Air Quality', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text(
                    'Good',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(ThemeData theme, bool isDarkMode) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = selectedTab == tab;

          return GestureDetector(
            onTap: () => setState(() => selectedTab = tab),
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tab,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isSelected
                        ? theme.colorScheme.onBackground
                        : theme.colorScheme.onBackground.withOpacity(0.6),
                    ),
                  ),
                  if (isSelected)
                    Container(
                      height: 2,
                      width: 20,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
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

  Widget _buildDeviceGrid(ThemeData theme, bool isDarkMode) {
    final currentDevices = roomDevices[selectedTab] ?? [];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentDevices.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.95,
        ),
        itemBuilder: (context, index) {
          final device = currentDevices[index];
          return _deviceCard(theme, device, (newValue) {
            setState(() => device.isOn = newValue);
          });
        },
      ),
    );
  }

  Widget _deviceCard(ThemeData theme, Device device, Function(bool) onSwitchChanged) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              device.icon,
              color: theme.colorScheme.primary,
              size: 30,
            ),
          ),
          const Spacer(),
          Text(
            device.title,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            device.subtitle,
            style: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                device.isOn ? "ON" : "OFF",
                style: TextStyle(
                  color: device.isOn
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: device.isOn,
                  onChanged: onSwitchChanged,
                  activeColor: theme.colorScheme.onPrimary,
                  inactiveThumbColor: theme.colorScheme.onSurfaceVariant,
                  activeTrackColor: theme.colorScheme.primary,
                  inactiveTrackColor: theme.colorScheme.surface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}