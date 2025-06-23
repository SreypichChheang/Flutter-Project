import 'package:app/dashboard/about_us_screen.dart';
import 'package:app/setting/notification.dart';
import 'package:app/widget/profile_widget.dart';
import 'package:app/widget/section_tile.dart';
import 'package:app/setting/privacy_screen.dart';
import 'package:app/setting/favorite.dart';

import 'package:flutter/material.dart';

import 'privacy_screen.dart';

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onToggleDarkMode;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        backgroundColor: Colors.white, // White app bar
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black), // Black text
        ),
        leading: const BackButton(color: Colors.black), // Black back button
        actions: const [SizedBox(width: 50)],
        elevation: 0, // Remove shadow
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    'User Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(
                          isDarkMode: isDarkMode,
                          onToggleDarkMode: onToggleDarkMode,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Text(
                      'Setting',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const UserProfileWidget(),
            _buildSectionTile(
              context,
              icon: Icons.dark_mode,
              title: "Dark Mode",
              trailing: Switch(
                value: isDarkMode,
                onChanged: onToggleDarkMode,
                activeColor: Colors.black, // Black switch when active
              ),
            ),
            _buildSectionTile(
              context,
              icon: Icons.notifications,
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
              icon: Icons.lock,
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
              icon: Icons.language,
              title: "Language",
              onTap: () {
                Navigator.pushNamed(context, '/language');
              },
            ),
            _buildSectionTile(
              context,
              icon: Icons.bookmark,
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
              icon: Icons.info,
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
              icon: Icons.logout,
              title: "Logout",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTile(
    BuildContext context, {
    required IconData icon,
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
        leading: Icon(icon, color: Colors.black),
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