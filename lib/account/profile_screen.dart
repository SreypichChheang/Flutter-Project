import 'package:app/dashboard/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:app/setting/settings_screen.dart';
import 'edit_profile.dart' hide ChangePasswordScreen;
import 'changePsw_profile.dart';
import 'info_profile.dart';
import 'update_profile.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String displayName = 'Loading...';
  String displayEmail = '';
  String displayImage = '';
  int displayFollowers = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = doc.data();
      if (data != null) {
        setState(() {
          displayName = data['name'] ?? user.displayName ?? 'No Name';
          displayEmail = data['email'] ?? user.email ?? 'No Email';
          displayImage = data['profileImage'] ?? '';
          displayFollowers = data['followers'] ?? 0;
          isLoading = false;
        });
      } else {
        setState(() {
          displayName = user.displayName ?? 'No Name';
          displayEmail = user.email ?? 'No Email';
          displayImage = '';
          displayFollowers = 0;
          isLoading = false;
        });
      }
    }
  }

  ImageProvider _getImageProvider() {
    if (displayImage.isNotEmpty) {
      if (displayImage.startsWith('data:')) {
        try {
          final base64Data = displayImage.split(',')[1];
          final bytes = base64Decode(base64Data);
          return MemoryImage(bytes);
        } catch (e) {
          print('Error decoding base64 image: $e');
        }
      } else {
        return NetworkImage(displayImage);
      }
    }
    return const NetworkImage('https://picsum.photos/200/200?random=1');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;


    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(7.0),
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
              onPressed: () {
                // Navigate back to the HomePage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SmartHomeApp()), // Update this with the actual HomePage widget
                );
              },
            ),
          ),
        ),
        actions: const [SizedBox(width: 20)], // Reduced spacing
        elevation: 0, // Remove shadow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
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
                      onToggleDarkMode: (bool value) {},
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Setting',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
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
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.edit,
                        color: theme.colorScheme.onPrimary, size: 16),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$displayFollowers Followers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        if (result != null) _fetchUserData();
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      theme: theme,
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      theme: theme,
                      icon: Icons.info_outline,
                      title: 'Information',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InformationScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      theme: theme,
                      icon: Icons.sync_outlined,
                      title: 'Update',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateScreen()),
                        );
                      },
                    ),
                    const Spacer(),

                    // Logout Button
                    Container(
                      width: double.infinity,
                      height: 40,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          _showLogoutDialog(context, theme);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout,
                                color: theme.colorScheme.onPrimary),
                            const SizedBox(width: 5),
                            Text(
                              'Log out',
                              style: TextStyle(
                                color: Colors.white,
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
    final Color cardColor = isDarkMode ? Colors.grey[900]! : Colors.grey[200]!;
    final Color iconBgColor = isDarkMode ? theme.colorScheme.primary : Colors.black;
    final Color textColor = theme.colorScheme.onSurface;

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
              height: 35,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  color: theme.colorScheme.onPrimary, size: 20),
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
            Icon(Icons.arrow_forward_ios,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                size: 16),
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
            title: Text('Log Out',
                style: TextStyle(color: theme.colorScheme.onSurface)),
            content: Text('Are you sure you want to log out?',
                style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(0.7))),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel',
                    style: TextStyle(color: theme.colorScheme.primary)),
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Log Out',
                    style: TextStyle(color: theme.colorScheme.onPrimary)),
              ),
            ],
          ),
        );
      },
    );
  }
}
