import 'package:flutter/material.dart';
import 'package:app/setting/notification.dart';
import 'package:app/setting/privacy_screen.dart';
import 'package:app/setting/favorite.dart';
import 'package:app/widget/profile_widget.dart';
import 'package:app/dashboard/about_us_screen.dart';
import 'package:app/account/profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onToggleDarkMode;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode; // Initialize the dark mode state
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode; // Toggle the dark mode state
    });
    widget.onToggleDarkMode(_isDarkMode); // Pass the new value back to the parent
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: const [SizedBox(width: 20)],
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'User Profile',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Setting',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: const UserProfileWidget(),
            ),
            _buildSectionTile(
              context,
              icon: Icon(
                _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: theme.iconTheme.color,
              ),
              title: "Dark Mode",
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  _toggleTheme(); // Toggle the theme
                },
                activeColor: Colors.black,
              ),
              onTap: () {

              },
            ),
            _buildSectionTile(
              context,
              icon: const Icon(Icons.notifications),
              title: "Notifications",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationScreen()),
                );
              },
            ),
            _buildSectionTile(
              context,
              icon: const Icon(Icons.lock),
              title: "Privacy",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacyScreen()),
                );
              },
            ),
            _buildSectionTile(
              context,
              icon: const Icon(Icons.language),
              title: "Language",
              onTap: () {
                Navigator.pushNamed(context, '/language');
              },
            ),
            _buildSectionTile(
              context,
              icon: const Icon(Icons.bookmark),
              title: "Favorite",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoriteScreen()),
                );
              },
            ),
            _buildSectionTile(
              context,
              icon: const Icon(Icons.info),
              title: "About",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutUsPage()),
                );
              },
            ),
            _buildSectionTile(
              context,
              icon: const Icon(Icons.logout),
              title: "Logout",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTile(
      BuildContext context, {
        required Icon icon,
        required String title,
        Widget? trailing,
        VoidCallback? onTap,
      }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
