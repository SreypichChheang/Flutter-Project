import 'package:app/device/device_pairing.dart';
import 'package:flutter/material.dart';

class DevicePairingScreen extends StatelessWidget {
  const DevicePairingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.white : Colors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.black : Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          'Devices',
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please set the device in pairing mode based on user manual and choose the right pairing method',
              style: TextStyle(
                fontSize: 14,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  OptionCard(
                    icon: Icons.bluetooth,
                    title: 'Bluetooth\nPairing',
                    subtitle: 'Available for Bluetooth devices and WiFi Bluetooth combo devices',
                    iconColor: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BluetoothPairingScreen(),
                        ),
                      );
                    },
                  ),
                  const OptionCard(
                    icon: Icons.link,
                    title: 'Link\nAccounts',
                    subtitle: 'Link with third-party platforms',
                    iconColor: Colors.lightBlue,
                  ),
                  const OptionCard(
                    icon: Icons.home,
                    title: 'HomeKit',
                    subtitle: 'Available for Homekit compatible devices',
                    iconColor: Colors.red,
                  ),
                  const OptionCard(
                    icon: Icons.settings_remote,
                    title: 'Remote\nControl',
                    subtitle: 'Create a remote',
                    iconColor: Colors.teal,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback? onTap;

  const OptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (!isDark)
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(2, 2),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: iconColor),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
