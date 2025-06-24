import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';


class LanguageScreen extends StatefulWidget {
  final String currentLocale;
  final Function(Locale) onLocaleChange;

  const LanguageScreen({
    super.key,
    required this.currentLocale,
    required this.onLocaleChange,
  });

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late String _selectedLanguage; // Initialize based on current locale

  final List<Map<String, String>> _languages = [
    {'label': 'English (United States)', 'code': 'en'},
    {'label': 'Français (France)', 'code': 'fr'},
    {'label': 'ភាសាខ្មែរ', 'code': 'km'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.currentLocale; // Set initial selection from app's locale
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(loc.language),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: _languages.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final lang = _languages[index];
          final isSelected = lang['code'] == _selectedLanguage;

          return RadioListTile(
            value: lang['code'],
            groupValue: _selectedLanguage,
            onChanged: (value) {
              if (value != null) {
                final newLocale = Locale(value);
                setState(() {
                  _selectedLanguage = value;
                });
                widget.onLocaleChange(newLocale);
              }
            },
            title: Text(
              lang['label']!,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.textTheme.bodyLarge!.color,
              ),
            ),
            activeColor: theme.colorScheme.primary,
            tileColor: isSelected
                ? theme.colorScheme.primary.withOpacity(0.1)
                : theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: isSelected
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