import 'package:flutter/material.dart';
import 'package:app/device/device_connection.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Device> _recentDevices = [
    Device(Icons.lightbulb_outline, 'Lights', true),
    Device(Icons.ac_unit, 'Bedroom AC', false),
    Device(Icons.tv, 'Living Room TV', true),
  ];

  List<Category> _categories = [
    Category(Icons.lightbulb_outline, 'Lights', 4, Colors.orange),
    Category(Icons.ac_unit, 'Climate', 2, Colors.blue),
    Category(Icons.tv, 'Media', 3, Colors.purple),
    Category(Icons.security, 'Security', 2, Colors.green),
    Category(Icons.kitchen, 'Kitchen', 3, Colors.red),
    Category(Icons.cleaning_services, 'Cleaning', 1, Colors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    // Color scheme
    final backgroundColor = isDarkMode ? Color(0xFF121212) : Color(0xFFF5F5F5);
    final cardColor = isDarkMode ? Color(0xFF1E1E1E) : Colors.white;
    final primaryColor = isDarkMode ? Color(0xFFBB86FC) : Color(0xFF6200EE);
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final secondaryTextColor = isDarkMode ? Colors.white70 : Colors.black54;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Smart Home',
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: textColor),
            onPressed: _showNotifications,
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: textColor),
            onPressed: _showMenu,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            // Search bar
            _buildSearchBar(isDarkMode, cardColor, secondaryTextColor, textColor),
            SizedBox(height: 24),
            
            // Quick actions
            _buildQuickActionsSection(primaryColor, isDarkMode),
            SizedBox(height: 24),
            
            // Device categories
            _buildSectionTitle('Device Categories', textColor),
            SizedBox(height: 16),
            _buildCategoriesGrid(isDarkMode, cardColor),
            SizedBox(height: 24),
            
            // Recent devices
            _buildSectionTitle('Recently Used', textColor),
            SizedBox(height: 16),
            _buildRecentDevicesList(isDarkMode),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ========== Widget Building Methods ==========

 

  Widget _buildSearchBar(bool isDarkMode, Color cardColor, Color hintColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: hintColor, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search devices...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: hintColor),
              ),
              style: TextStyle(color: textColor),
              onChanged: _searchDevices,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection(Color primaryColor, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        )),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionButton(
                icon: Icons.add,
                label: 'Add Device',
                color: primaryColor,
                onTap: _navigateToDevicePairing,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildQuickActionButton(
                icon: Icons.schedule,
                label: 'Schedules',
                color: Colors.orange,
                onTap: _showSchedules,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: 12),
            Text(label, style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Text(title, style: TextStyle(
      color: textColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ));
  }

  Widget _buildCategoriesGrid(bool isDarkMode, Color cardColor) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        return _buildCategoryCard(
          icon: category.icon,
          title: category.title,
          count: category.count,
          color: category.color,
          isDarkMode: isDarkMode,
          cardColor: cardColor,
          onTap: () => _navigateToCategory(category.title),
        );
      },
    );
  }

 Widget _buildCategoryCard({
  required IconData icon,
  required String title,
  required int count,
  required Color color,
  required bool isDarkMode,
  required Color cardColor,
  required VoidCallback onTap,
}) {
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    color: cardColor,
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        height: 150, // Fixed height to prevent overflow
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3), width: 1),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            SizedBox(height: 12), // Reduced spacing
            Text(title, style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black87,
            )),
            SizedBox(height: 4),
            Text('$count ${count == 1 ? 'device' : 'devices'}', 
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                )),
          ],
        ),
      ),
    ),
  );
}

 Widget _buildRecentDevicesList(bool isDarkMode) {
  return SizedBox(
    height: 140, // Increased height to accommodate all items
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _recentDevices.length,
      itemBuilder: (context, index) {
        final device = _recentDevices[index];
        return Container(
          width: 160,
          margin: EdgeInsets.only(right: 16),
          child: _buildRecentDeviceCard(device, isDarkMode),
        );
      },
    ),
  );
}

Widget _buildRecentDeviceCard(Device device, bool isDarkMode) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Better space distribution
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: device.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(device.icon, color: device.color, size: 20),
              ),
              Switch(
                value: device.isOn,
                onChanged: (value) => _toggleDevice(device, value),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                device.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                device.isOn ? 'On' : 'Off',
                style: TextStyle(
                  fontSize: 12,
                  color: device.isOn ? device.color : 
                        (isDarkMode ? Colors.white70 : Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

  // ========== Functional Methods ==========

  void _searchDevices(String query) {
    // Implement search functionality
    print("Searching for: $query");
  }

  void _navigateToDevicePairing() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DevicePairingScreen()),
    );
  }

  void _showSchedules() {
    // Implement schedules functionality
    print("Showing schedules");
  }

  void _navigateToCategory(String category) {
    // Implement category navigation
    print("Navigating to $category");
  }

  void _toggleDevice(Device device, bool value) {
    setState(() {
      device.isOn = value;
    });
    // Here you would typically call your device control API
    print("${device.name} turned ${value ? 'on' : 'off'}");
  }

  void _showNotifications() {
    // Implement notifications
    print("Showing notifications");
  }

  void _showMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to settings
                },
              ),
              ListTile(
                leading: Icon(Icons.help_outline),
                title: Text('Help & Feedback'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to help
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// ========== Data Models ==========

class Device {
  IconData icon;
  String name;
  bool isOn;
  Color color;

  Device(this.icon, this.name, this.isOn, [this.color = Colors.blue]);
}

class Category {
  IconData icon;
  String title;
  int count;
  Color color;

  Category(this.icon, this.title, this.count, this.color);
}