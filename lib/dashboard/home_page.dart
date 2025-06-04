import 'package:app/dashboard/about_us_screen.dart';
import 'package:app/dashboard/dashboard_screen.dart';
import 'package:app/dashboard/device_screen.dart';
import 'package:app/dashboard/scan_device.dart';
import 'package:app/dashboard/scedule_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Controller());

class Controller extends StatelessWidget {
  const Controller({super.key});

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
  bool _isDarkMode = false;

  final List<Widget> _pages = [
    const HomeScreen(),
    const DevicesScreen(),
    const ScanScreen(),
    const ScheduleScreen(),
    const AboutUsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
      ),
    );
  }
}

PreferredSizeWidget _customAppBar({VoidCallback? onToggleTheme, bool isDarkMode = false}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.only(left: 12),
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: Image.asset(
            'assets/images/profile.png',
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    title: const Text(
      'Ronny Jin',
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.notifications_none, color: Colors.black),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode, color: Colors.black),
        onPressed: onToggleTheme,
      ),
      IconButton(
        icon: Icon(isDarkMode ? Icons.dark_mode : Icons.settings, color: Colors.black),
        onPressed: onToggleTheme,
      ),
    ],
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parentState = context.findAncestorStateOfType<_SmartHomeAppState>();
    return Scaffold(
      appBar: _customAppBar(
        onToggleTheme: parentState?._toggleTheme,
        isDarkMode: parentState?._isDarkMode ?? false,
      ),
      body: LandingPage(),
    );
  }
}

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parentState = context.findAncestorStateOfType<_SmartHomeAppState>();
    return Scaffold(
      appBar: _customAppBar(
        onToggleTheme: parentState?._toggleTheme,
        isDarkMode: parentState?._isDarkMode ?? false,
      ),
      body: const DevicePage(),
    );
  }
}

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parentState = context.findAncestorStateOfType<_SmartHomeAppState>();
    return Scaffold(
      appBar: _customAppBar(
        onToggleTheme: parentState?._toggleTheme,
        isDarkMode: parentState?._isDarkMode ?? false,
      ),
      body: const AddDevice(),
    );
  }
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parentState = context.findAncestorStateOfType<_SmartHomeAppState>();
    return Scaffold(
      appBar: _customAppBar(
        onToggleTheme: parentState?._toggleTheme,
        isDarkMode: parentState?._isDarkMode ?? false,
      ),
      body: const schedule(),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parentState = context.findAncestorStateOfType<_SmartHomeAppState>();
    return Scaffold(
      appBar: _customAppBar(
        onToggleTheme: parentState?._toggleTheme,
        isDarkMode: parentState?._isDarkMode ?? false,
      ),
      body: const AboutUsPage(),
    );
  }
}
