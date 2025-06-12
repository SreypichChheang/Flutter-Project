import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'en_us';

  final List<Map<String, String>> _languages = [
    {'label': 'English (United States)', 'code': 'en_us'},
    {'label': 'Français (France)', 'code': 'fr_fr'},
    {'label': 'ភាសាខ្មែរ', 'code': 'km_kh'},
    {'label': 'Filipino', 'code': 'fil_ph'},
    {'label': 'Tiếng Việt', 'code': 'vi_vn'},
    {'label': 'ไทย', 'code': 'th_th'},
    {'label': '한국인', 'code': 'ko_kr'},
    {'label': '日本語', 'code': 'ja_jp'},
    {'label': 'English (Australia)', 'code': 'en_au'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Language'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: _languages.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final lang = _languages[index];
          final selected = lang['code'] == _selectedLanguage;

          return RadioListTile(
            value: lang['code'],
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value.toString();
              });

              // If you want to pop the screen and return the value:
              // Navigator.pop(context, _selectedLanguage);
            },
            title: Text(
              lang['label']!,
              style: TextStyle(
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                color: selected
                    ? theme.colorScheme.primary
                    : theme.textTheme.bodyLarge!.color,
              ),
            ),
            activeColor: theme.colorScheme.primary,
            tileColor: selected
                ? theme.colorScheme.primary.withOpacity(0.1)
                : theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: selected
                  ? BorderSide(color: theme.colorScheme.primary, width: 1.2)
                  : BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          );
        },
      ),
    );
  }
}
