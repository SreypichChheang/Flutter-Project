import 'package:flutter/material.dart';
import 'package:app/setting/settings_screen.dart';
import 'edit_profile.dart';
import 'changePsw_profile.dart';
import 'info_profile.dart';
import 'update_profile.dart';
import 'dart:convert';
import 'dart:typed_data';

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
    final textColor = theme.colorScheme.onSurface;
    final cardColor = theme.cardColor;
    final primaryColor = theme.colorScheme.primary;
    final scaffoldBackground = theme.scaffoldBackgroundColor;
    bool isProfileSelected = true;

    return Scaffold(
      backgroundColor: scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation
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
                              color: theme.colorScheme.onPrimary,
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
                                  onToggleDarkMode: (bool value) {
                                    // Implement theme change logic
                                  },
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
                              color: isDarkMode 
                                  ? Colors.grey[800] 
                                  : Colors.grey[100],
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
                      color: theme.colorScheme.onPrimary, 
                      size: 16
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // User Name
            Text(
              displayName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),

            const SizedBox(height: 12),

            // Followers Count
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$displayFollowers Followers',
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Menu Items
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

                    // Log out button
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
                            Icon(Icons.logout, color: theme.colorScheme.onPrimary),
                            const SizedBox(width: 8),
                            Text(
                              'Log out',
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
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
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.grey[50],
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
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon, 
                color: theme.colorScheme.onPrimary, 
                size: 20
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios, 
              color: theme.colorScheme.onSurface.withOpacity(0.6), 
              size: 16
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, ThemeData theme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: theme.copyWith(
            dialogTheme: DialogThemeData(
              backgroundColor: theme.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: AlertDialog(
            title: Text(
              'Log Out',
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
            content: Text(
              'Are you sure you want to log out?',
              style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Handle logout logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Log Out', 
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}