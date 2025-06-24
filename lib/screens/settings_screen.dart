import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
//
import '../widgets/profile_card.dart';
import '../widgets/section_tile.dart';
import 'privacy_screen.dart';
import 'about_screen.dart';
import 'language_screen.dart';
import 'notification_screen.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onToggleDarkMode;
  final Function(Locale) onLocaleChange;
  final Locale currentLocale; // Add currentLocale here to pass down

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.onLocaleChange,
    required this.currentLocale,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedToggleIndex = 1; // 0 for User Profile, 1 for Settings

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
        padding: const EdgeInsets.all(16), // Add some padding around
        child: Column(
          children: [
            ToggleButtons(
              isSelected: [
                _selectedToggleIndex == 0,
                _selectedToggleIndex == 1,
              ],
              onPressed: (index) {
                setState(() {
                  _selectedToggleIndex = index;
                });
              },
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
                value: widget.isDarkMode,
                onChanged: widget.onToggleDarkMode,
              ),
            ),
            SectionTile(
              icon: Icons.notifications,
              title: loc.notifications ?? 'Notification', // Use localization
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
                      onLocaleChange: widget.onLocaleChange,
                      currentLocale: widget.currentLocale.languageCode,
                    ),
                  ),
                );
              },
            ),
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
