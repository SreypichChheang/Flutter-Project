import 'package:flutter/material.dart';
import 'package:settingv2/l10n/app_localizations.dart';
import 'screens/settings_screen.dart';
import 'screens/language_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  Locale _locale = const Locale('en'); // Track current locale

  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale; // Update locale and trigger rebuild
    });
  }

  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/': (context) => SettingsScreen(
              isDarkMode: isDarkMode,
              onToggleDarkMode: toggleDarkMode,
              onLocaleChange: changeLocale,
            ),
        '/language': (context) => LanguageScreen(
              currentLocale: _locale.languageCode,
              onLocaleChange: changeLocale,
            ),
      },
    );
  }
}