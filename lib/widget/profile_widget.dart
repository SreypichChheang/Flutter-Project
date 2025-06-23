import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    
    if (user == null) {
      return const CircleAvatar(
        radius: 24,
        child: Icon(Icons.person),
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.exists) {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final userName = userData['name'] ?? user.displayName ?? 'User';
          final userEmail = userData['email'] ?? user.email ?? '';
          
          return GestureDetector(
            onTap: () => _showUserMenu(context, userName, userEmail),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: user.photoURL != null 
                      ? NetworkImage(user.photoURL!)
                      : null,
                  child: user.photoURL == null 
                      ? ClipOval(
                          child: Image.asset(
                            'assets/images/profile.png',
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      userEmail,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        
        // Fallback to basic user info
        return GestureDetector(
          onTap: () => _showUserMenu(
            context, 
            user.displayName ?? 'User',
            user.email ?? '',
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: user.photoURL != null 
                    ? NetworkImage(user.photoURL!)
                    : const AssetImage('assets/images/profile.png') as ImageProvider,
              ),
              const SizedBox(width: 8),
              Text(
                user.displayName ?? 'User',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUserMenu(BuildContext context, String userName, String userEmail) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // User Info Header
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: FirebaseAuth.instance.currentUser?.photoURL != null
                      ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                      : const AssetImage('assets/images/profile.png') as ImageProvider,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userEmail,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Menu Options
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to edit profile screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to help
              },
            ),
            
            const Divider(),
            
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                await _signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // The AuthWrapper will automatically redirect to welcome screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing out: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}