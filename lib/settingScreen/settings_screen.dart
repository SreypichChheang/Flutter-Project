import 'package:flutter/material.dart';
import '../widgets/profile_card.dart';
import '../widgets/section_tile.dart';
import 'privacy_screen.dart';
import 'about_screen.dart';

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
      appBar: AppBar(
        title: const Text("Settings"),
        leading: const BackButton(),
        actions: const [SizedBox(width: 50)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ToggleButtons(
              isSelected: [false, true],
              onPressed: (index) {},
              borderRadius: BorderRadius.circular(20),
              selectedColor: Colors.white,
              fillColor: Theme.of(context).colorScheme.primary,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("User Profile"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Setting"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const ProfileCard(),
            SectionTile(
              icon: Icons.dark_mode,
              title: "Dark Mode",
              trailing: Switch(
                value: isDarkMode,
                onChanged: onToggleDarkMode,
              ),
            ),
            SectionTile(icon: Icons.notifications, title: "Notifications"),
            SectionTile(
              icon: Icons.lock, 
              title: "Privacy",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacyScreen()),
                );
              },
            ),
            SectionTile(
              icon: Icons.language, 
              title: "Language",
              onTap: (){
                Navigator.pushNamed(context, '/language');
              },
            ),
            SectionTile(icon: Icons.bookmark, title: "Favorite"),
            SectionTile(
              icon: Icons.info, 
              title: "About",
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              },
            ),
            SectionTile(icon: Icons.logout, title: "Logout"),
          ],
        ),
      ),
    );
  }
}
