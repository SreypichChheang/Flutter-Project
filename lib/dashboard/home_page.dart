import 'package:flutter/material.dart';
import 'package:app/account/profile_screen.dart';
import 'package:app/dashboard/dashboard_screen.dart';
import 'package:app/dashboard/device_screen.dart';
import 'package:app/dashboard/scan_device.dart';
import 'package:app/dashboard/scedule_screen.dart';
import 'package:app/setting/notification.dart';
import 'package:app/account/info_profile.dart';

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
    setState(() => _isDarkMode = !_isDarkMode);
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blueGrey,
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.blue[200],
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.devices_other), label: 'Devices'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Scan'),
            BottomNavigationBarItem(icon: Icon(Icons.settings_remote), label: 'Schedule'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget _customAppBar({
  required VoidCallback onToggleTheme,
  required bool isDarkMode,
  required BuildContext context,
}) {
  final theme = Theme.of(context);
  
  return AppBar(
    backgroundColor: theme.appBarTheme.backgroundColor,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.only(left: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserProfileScreen()),
          );
        },
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
    ),
    title: Text(
      'Ronny Jin',
      style: theme.appBarTheme.titleTextStyle?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.notifications_none,
          color: theme.iconTheme.color,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationScreen()),
          );
        },
      ),
      IconButton(
        icon: Icon(
          isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: theme.iconTheme.color,
        ),
        onPressed: onToggleTheme,
      ),
    ],
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    return Scaffold(
      appBar: _customAppBar(
        onToggleTheme: () {
          final state = context.findAncestorStateOfType<_SmartHomeAppState>();
          state?._toggleTheme();
        },
        isDarkMode: isDarkMode,
        context: context,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Builder(
        builder: (context) {
          return LandingPage(); // Make sure LandingPage uses theme colors
        },
      ),
    );
  }
}

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: const DevicePage(), // Make sure DevicePage uses theme colors
    );
  }
}

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: const AddDevice(), // Make sure AddDevice uses theme colors
    );
  }
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: const Schedule(), // Make sure Schedule uses theme colors
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: const UserProfileScreen(), // Make sure UserProfileScreen uses theme colors
    );
  }
}