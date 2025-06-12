import 'package:flutter/material.dart';
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

  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routes:{
        '/': (context) => SettingsScreen(
          isDarkMode: isDarkMode, 
          onToggleDarkMode: toggleDarkMode,
        ),
        '/language': (context) => const LanguageScreen(),
      },
      initialRoute: '/',
    );
  }
}
