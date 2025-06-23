  import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage('assets/images/cat.jpg'),
      ),
      title: const Text('Anna Jennifer'),
      subtitle: const Text('+885 965050930'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
