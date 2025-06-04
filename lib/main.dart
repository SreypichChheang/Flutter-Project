import 'package:app/dashboard/about_us_screen.dart';
import 'package:app/dashboard/device_screen.dart';
import 'package:flutter/material.dart';
import 'dashboard/dashboard_screen.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SmartHomeApp(),
    );
  }
}

class SmartHomeApp extends StatefulWidget {
  const SmartHomeApp({super.key});

  @override
  State<SmartHomeApp> createState() => _SmartHomeAppState();
}

class _SmartHomeAppState extends State<SmartHomeApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    DevicesScreen(),
    StatsScreen(),
    AutomationScreen(),
    AboutUsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.devices_other), label: 'Devices'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_remote), label: 'Automation'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(),
      body: const LandingPage(),
    );
  }
}

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(),
      body: const DevicePage() ,
    );
  }
}

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(),
      body: const Center(child: Text("📊 Stats Screen")),
    );
  }
}

class AutomationScreen extends StatelessWidget {
  const AutomationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(),
      body: const Center(child: Text("⚙️ Automation Screen")),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(),
      body: const AboutUsPage(),
    );
  }
}

PreferredSizeWidget _customAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: const Padding(
      padding: EdgeInsets.only(left: 12),
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/profile.jpg'),
      ),
    ),
    title: const Text(
      'Ronny Jin',
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    actions: const [
      Icon(Icons.notifications_none, color: Colors.black),
      SizedBox(width: 16),
      Icon(Icons.settings, color: Colors.black),
      SizedBox(width: 16),
    ],
  );
}
