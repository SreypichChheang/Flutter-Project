import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  bool _enableNotifications = true;
  bool _messagePreview = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: _enableNotifications,
            onChanged: (bool value) {
              setState(() {
                _enableNotifications = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Message Preview'),
            value: _messagePreview,
            onChanged: (bool value) {
              setState(() {
                _messagePreview = value;
              });
            },
          ),
        ],
      ),
    );
  }
}