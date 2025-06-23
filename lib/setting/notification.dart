import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Notifications',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
          primary: Colors.white, // App bar background
          secondary: const Color(0xFF6B4EE8), // Accent color for active elements
          surface: Colors.white, // Card background
          background: const Color(0xFFF0F0F5), // General screen background
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const NotificationScreen(),
    );
  }
}

// Model for a single notification item
class NotificationItem {
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String title;
  final String status;
  final String timestamp;
  final bool isOnline; // To determine icon color and status text color

  NotificationItem({
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.title,
    required this.status,
    required this.timestamp,
    required this.isOnline,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      icon: Icons.lightbulb_outline,
      iconBackgroundColor: const Color(0xFFE8E8EC),
      iconColor: const Color(0xFF6B4EE8), // Purple for online
      title: 'Home',
      status: 'Lamp Online',
      timestamp: '23 July | 23:11',
      isOnline: true,
    ),
    NotificationItem(
      icon: Icons.lightbulb_outline,
      iconBackgroundColor: const Color(0xFFE8E8EC),
      iconColor: Colors.grey, // Grey for offline
      title: 'Home',
      status: 'Lamp Offline',
      timestamp: '18 July | 23:11',
      isOnline: false,
    ),
    NotificationItem(
      icon: Icons.lightbulb_outline, // Assuming this is also a lamp
      iconBackgroundColor: const Color(0xFFFFEBEE), // Light red for urgent/error offline
      iconColor: Colors.red, // Red for urgent offline
      title: 'Home',
      status: 'Lamp Offline',
      timestamp: '06 July | 23:11',
      isOnline: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background, // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return _buildNotificationCard(notification);
        },
      ),
    );
  }

  // Widget to build a single notification card
  Widget _buildNotificationCard(NotificationItem notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0), // Spacing between cards
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // White background for the card
        borderRadius: BorderRadius.circular(20.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Subtle shadow
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon with background
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: notification.iconBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              notification.icon,
              color: notification.iconColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          // Notification details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.status,
                  style: TextStyle(
                    fontSize: 14,
                    color: notification.isOnline ? Theme.of(context).colorScheme.secondary : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Timestamp
          Text(
            notification.timestamp,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
