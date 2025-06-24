import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar : AppBar(
        leading: const BackButton(),
        title: const Text("About Us"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '"Smart Ey Smart Yang Nis" is a smart home automation app for energy-efficient lighting control. It allows homeowners to remotely manage and monitor their lighting, integrating with multiple brands for seamless automation, enhancing convenience, security, and energy savings.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(width: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/about.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Process to do it',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index){
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: isDark ? Colors.white : Colors.black,
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: isDark ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 90,
                      child: Text(
                        [
                          'Sign Up\n& Log In',
                          'Connect Your\nSmart Devices',
                          'Customize\nYour Settings',
                          'Monitor & Track\nUsage',
                          'Help &\nContact'
                        ][index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 32),
            Text(
              'Why should we use this application?',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 20,
              runSpacing: 20,
              children: [
                _BenefitItem(icon: Icons.check_box, label: 'Energy Saving'),
                _BenefitItem(icon: Icons.home, label: 'Smart Control'),
                _BenefitItem(icon: Icons.shield, label: 'Security'),
                _BenefitItem(icon: Icons.integration_instructions, label: 'Easy Integration'),
              ],
            ),
          ],
        ),
      )
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BenefitItem({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}