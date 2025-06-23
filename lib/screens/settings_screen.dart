import 'package:flutter/material.dart';
import 'package:settingv2/l10n/app_localizations.dart';

import '../widgets/profile_card.dart';
import '../widgets/section_tile.dart';
import 'privacy_screen.dart';
import 'about_screen.dart';
import 'language_screen.dart';
import 'notification_screen.dart'; // Import the new screen

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onToggleDarkMode;
  final Function(Locale) onLocaleChange;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.onLocaleChange,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settings),
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
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("User Profile"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(loc.settings),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const ProfileCard(),
            SectionTile(
              icon: Icons.dark_mode,
              title: loc.darkMode,
              trailing: Switch(
                value: isDarkMode,
                onChanged: onToggleDarkMode,
              ),
            ),
            SectionTile(
              icon: Icons.notifications,
              title: 'Notification', // Update with localization if needed
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationScreen()),
                );
              },
            ),
            SectionTile(
              icon: Icons.lock,
              title: loc.privacy,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacyScreen()),
                );
              },
            ),
            SectionTile(
              icon: Icons.language,
              title: loc.language,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LanguageScreen(
                      onLocaleChange: onLocaleChange,
                      currentLocale: '',
                    ),
                  ),
                );
              },
            ),
            // SectionTile(icon: Icons.bookmark, title: loc.favorite),
            SectionTile(
              icon: Icons.info,
              title: loc.about,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              },
            ),
            SectionTile(
              icon: Icons.logout,
              title: loc.logout,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (Route<dynamic> route) => false,
                );
              },
              textColor: Colors.red,
              iconColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}