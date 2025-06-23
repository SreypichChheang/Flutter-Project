import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:app/setting/settings_screen.dart';
import 'edit_profile.dart' hide ChangePasswordScreen;
import 'changePsw_profile.dart';
import 'info_profile.dart';
import 'update_profile.dart';

class UserProfileScreen extends StatefulWidget {
  final String? userName;
  final String? userEmail;
  final String? userImage;
  final int? followerCount;

  const UserProfileScreen({
    Key? key,
    this.userName,
    this.userEmail,
    this.userImage,
    this.followerCount,
  }) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late String displayName;
  late String displayEmail;
  late String displayImage;
  late int displayFollowers;

  @override
  void initState() {
    super.initState();
    displayName = widget.userName ?? "Anna Jennifer";
    displayEmail = widget.userEmail ?? "annajennifer@gmail.com";
    displayImage = widget.userImage ?? 'https://picsum.photos/200/200?random=1';
    displayFollowers = widget.followerCount ?? 1000;
  }

  ImageProvider _getImageProvider() {
    if (displayImage.isNotEmpty) {
      if (displayImage.startsWith('data:')) {
        try {
          final base64Data = displayImage.split(',')[1];
          final bytes = base64Decode(base64Data);
          return MemoryImage(bytes);
        } catch (e) {
          print('Error loading base64 image: $e');
          return NetworkImage('https://picsum.photos/200/200?random=1');
        }
      } else {
        return NetworkImage(displayImage);
      }
    }
    return NetworkImage('https://picsum.photos/200/200?random=1');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // COLORS: Black & White theme adapted for light/dark mode
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color cardColor = isDarkMode ? Colors.grey[900]! : Colors.grey[200]!;
    final Color primaryColor = isDarkMode ? Colors.white : Colors.black;
    final Color scaffoldBackground = isDarkMode ? Colors.black : Colors.white;
    final Color onPrimaryColor = isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'User Profile',
                            style: TextStyle(
                              color: onPrimaryColor,
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
                                  onToggleDarkMode: (bool value) {},
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
                              color: cardColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Setting',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Profile Image
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _getImageProvider(),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      color: onPrimaryColor,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              displayName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$displayFollowers Followers',
                style: TextStyle(
                  color: onPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 40),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _buildMenuItem(
                      theme: theme,
                      icon: Icons.edit_outlined,
                      title: 'Edit Profile',
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                              initialName: displayName,
                              initialEmail: displayEmail,
                              initialImage: displayImage,
                            ),
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            displayName = result['name'] ?? displayName;
                            displayEmail = result['email'] ?? displayEmail;
                            if (result['image'] != null) {
                              displayImage = result['image'];
                            }
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMenuItem(
                      theme: theme,
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMenuItem(
                      theme: theme,
                      icon: Icons.info_outline,
                      title: 'Information',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InformationScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMenuItem(
                      theme: theme,
                      icon: Icons.sync_outlined,
                      title: 'Update',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateScreen(),
                          ),
                        );
                      },
                    ),

                    const Spacer(),

                    // Logout Button
                    Container(
                      width: double.infinity,
                      height: 56,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          _showLogoutDialog(context, theme);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout, color: onPrimaryColor),
                            const SizedBox(width: 8),
                            Text(
                              'Log out',
                              style: TextStyle(
                                color: onPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required ThemeData theme,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final isDarkMode = theme.brightness == Brightness.dark;

    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color cardColor = isDarkMode ? Colors.grey[900]! : Colors.grey[200]!;
    final Color iconBgColor = isDarkMode ? Colors.white : Colors.black;
    final Color iconColor = isDarkMode ? Colors.black : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (!isDarkMode)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: textColor.withOpacity(0.6),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, ThemeData theme) {
    final isDarkMode = theme.brightness == Brightness.dark;

    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color cardColor = isDarkMode ? Colors.grey[900]! : Colors.grey[200]!;
    final Color primaryColor = isDarkMode ? Colors.white : Colors.black;
    final Color onPrimaryColor = isDarkMode ? Colors.black : Colors.white;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: theme.copyWith(
            dialogTheme: DialogThemeData(
              backgroundColor: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: AlertDialog(
            title: Text(
              'Log Out',
              style: TextStyle(color: textColor),
            ),
            content: Text(
              'Are you sure you want to log out?',
              style: TextStyle(color: textColor.withOpacity(0.7)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: primaryColor),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Handle logout logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Log Out',
                  style: TextStyle(color: onPrimaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
