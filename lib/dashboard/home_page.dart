import 'package:app/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/account/profile_screen.dart';
import 'package:app/dashboard/device_screen.dart';
import 'package:app/dashboard/scan_device.dart';
import 'package:app/dashboard/scedule_screen.dart';
import 'package:app/setting/notification.dart';
import 'package:app/account/info_profile.dart';

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

  final List<Widget> _pages = const [
    HomeScreen(),
    DevicesScreen(),
    ScanScreen(),
    ScheduleScreen(),
    AboutUsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _toggleTheme() {
    setState(() => _isDarkMode = !_isDarkMode);
  }

  ThemeData _lightTheme() => ThemeData(
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

  ThemeData _darkTheme() => ThemeData(
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.devices), label: 'Devices'),
            BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
            BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Schedule'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget _customAppBar({
  required BuildContext context,
  required bool isDarkMode,
  required VoidCallback onToggleTheme,
}) {
  final theme = Theme.of(context);

  return AppBar(
    title: Text('Welcome', style: theme.appBarTheme.titleTextStyle),
    leading: Padding(
      padding: const EdgeInsets.only(left: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UserProfileScreen()),
          );
        },
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: Image.network(
              'https://picsum.photos/200/200?random=1',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.notifications_none, color: theme.iconTheme.color),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationScreen()),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final parentState = context.findAncestorStateOfType<_SmartHomeAppState>();

    return Scaffold(
      appBar: _customAppBar(
        context: context,
        isDarkMode: isDark,
        onToggleTheme: parentState?._toggleTheme ?? () {},
      ),
      body: const LandingPage(),
    );
  }
}

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DevicePage(),
    );
  }
}

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AddDevice(),
    );
  }
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Schedule(),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserProfileScreen(),
    );
  }
}
