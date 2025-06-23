import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: Colors.blue.shade800,
          secondary: Colors.blue.shade600,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.blue.shade300,
          secondary: Colors.blue.shade200,
          surface: const Color(0xFF121212),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: const Color(0xFF1E1E1E),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.green;
            }
            return Colors.grey;
          }),
          trackColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.green.withOpacity(0.5);
            }
            return Colors.grey.withOpacity(0.5);
          }),
        ),
      ),
      themeMode: ThemeMode.dark, // Force dark mode
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<_SmartHomeScreenState> _smartHomeKey = GlobalKey();

  void _showAddDeviceDialog() {
    showDialog(
      context: context,
      builder: (context) => AddDeviceDialog(
        onDeviceAdded: (newDevice, room) {
          _smartHomeKey.currentState?.addDevice(newDevice, room);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SmartHomeScreen(key: _smartHomeKey),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDeviceDialog,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class Device {
  final IconData icon;
  final String title;
  final String subtitle;
  bool isOn;

  Device({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isOn = false,
  });
}

class SmartHomeScreen extends StatefulWidget {
  const SmartHomeScreen({super.key});

  @override
  State<SmartHomeScreen> createState() => _SmartHomeScreenState();
}

class _SmartHomeScreenState extends State<SmartHomeScreen> {
  String selectedTab = 'All';

  final List<String> tabs = [
    'All',
    'Living Room',
    'Bathroom',
    'Kitchen',
    'Bedroom',
    'Office',
    'Outdoor',
  ];

  final Map<String, List<Device>> roomDevices = {
    'All': [
      Device(icon: Icons.ac_unit, title: "Air Conditioner", subtitle: "4 devices"),
      Device(icon: Icons.lightbulb_outline, title: "Main Lighting", subtitle: "4 lamps", isOn: true),
      Device(icon: Icons.speaker_group, title: "Sound System", subtitle: "2 devices"),
      Device(icon: Icons.tv, title: "Smart TV", subtitle: "1 device", isOn: true),
      Device(icon: Icons.camera_alt, title: "Security Camera", subtitle: "3 devices"),
    ],
    'Living Room': [
      Device(icon: Icons.lightbulb_outline, title: "Living Room Lamp", subtitle: "2 lamps", isOn: true),
      Device(icon: Icons.tv, title: "Smart TV", subtitle: "1 device", isOn: true),
      Device(icon: Icons.speaker_group, title: "Sound System", subtitle: "2 devices", isOn: false),
    ],
    'Bathroom': [
      Device(icon: Icons.lightbulb_outline, title: "Bathroom Light", subtitle: "1 lamp", isOn: false),
      Device(icon: Icons.water_drop_outlined, title: "Water Heater", subtitle: "1 device", isOn: false),
    ],
    'Kitchen': [
      Device(icon: Icons.kitchen, title: "Refrigerator", subtitle: "1 device", isOn: true),
      Device(icon: Icons.lightbulb_outline, title: "Kitchen Light", subtitle: "2 lamps", isOn: false),
      Device(icon: Icons.microwave, title: "Microwave", subtitle: "1 device", isOn: false),
    ],
    'Bedroom': [
      Device(icon: Icons.bed, title: "Bedroom Lamp", subtitle: "2 lamps", isOn: true),
      Device(icon: Icons.ac_unit, title: "Bedroom AC", subtitle: "1 device", isOn: false),
      Device(icon: Icons.alarm, title: "Smart Alarm", subtitle: "1 device", isOn: true),
    ],
    'Office': [
      Device(icon: Icons.computer, title: "Office PC", subtitle: "1 device", isOn: true),
      Device(icon: Icons.lightbulb_outline, title: "Desk Lamp", subtitle: "1 lamp", isOn: false),
    ],
    'Outdoor': [
      Device(icon: Icons.outdoor_grill, title: "Garden Lights", subtitle: "3 lamps", isOn: false),
      Device(icon: Icons.local_car_wash, title: "Sprinkler System", subtitle: "1 device", isOn: false),
      Device(icon: Icons.security, title: "Outdoor Camera", subtitle: "1 device", isOn: true),
    ],
  };

  void addDevice(Device device, String room) {
    setState(() {
      roomDevices['All']?.add(device);
      if (roomDevices.containsKey(room)) {
        roomDevices[room]!.add(device);
      } else {
        roomDevices[room] = [device];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWeatherCard(isDarkMode),
          _buildTabBar(theme),
          Expanded(child: _buildDeviceGrid(theme)),
        ],
      ),
    );
  }

  Widget _buildWeatherCard(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [const Color(0xFF1E3A8A), const Color(0xFF1E40AF)]
              : [const Color(0xFF5B9EE1), const Color(0xFF4C8CD2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('23 °C', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Phnom Penh, Cambodia', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  Text('Cloudy', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
              const Spacer(),
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/1163/1163624.png',
                width: 60,
                height: 60,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mon, March 31', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text('28°C', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Humidity', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text('40%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Air Quality', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text('Good', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(ThemeData theme) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = selectedTab == tab;

          return GestureDetector(
            onTap: () => setState(() => selectedTab = tab),
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tab,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isSelected
                          ? theme.colorScheme.onBackground
                          : theme.colorScheme.onBackground.withOpacity(0.6),
                    ),
                  ),
                  if (isSelected)
                    Container(
                      height: 2,
                      width: 20,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDeviceGrid(ThemeData theme) {
    final currentDevices = roomDevices[selectedTab] ?? [];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: currentDevices.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.95,
        ),
        itemBuilder: (context, index) {
          final device = currentDevices[index];
          return _deviceCard(theme, device, (newValue) {
            setState(() => device.isOn = newValue);
          });
        },
      ),
    );
  }

  Widget _deviceCard(ThemeData theme, Device device, Function(bool) onSwitchChanged) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.cardTheme.color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.2),
                    theme.colorScheme.primary.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(device.icon, color: theme.colorScheme.primary, size: 34),
            ),
            const Spacer(),
            Text(
              device.title,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              device.subtitle,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                fontSize: 13,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  device.isOn ? "ON" : "OFF",
                  style: TextStyle(
                    color: device.isOn ? Colors.green : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: device.isOn,
                    onChanged: onSwitchChanged,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.green,
                    inactiveThumbColor: Colors.grey.shade700,
                    inactiveTrackColor: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddDeviceDialog extends StatefulWidget {
  final Function(Device device, String room) onDeviceAdded;

  const AddDeviceDialog({super.key, required this.onDeviceAdded});

  @override
  State<AddDeviceDialog> createState() => _AddDeviceDialogState();
}

class _AddDeviceDialogState extends State<AddDeviceDialog> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _subtitle = '';
  String _room = 'Living Room';
  bool _isOn = false;
  IconData _selectedIcon = Icons.lightbulb_outline;

  final List<IconData> icons = [
    Icons.lightbulb_outline,
    Icons.tv,
    Icons.speaker_group,
    Icons.ac_unit,
    Icons.kitchen,
    Icons.microwave,
    Icons.camera_alt,
    Icons.security,
    Icons.computer,
    Icons.alarm,
  ];

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF4CAF50);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: theme.dialogBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        'Add Device',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: theme.colorScheme.onSurface,
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  labelText: 'Device Title',
                  labelStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryGreen, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.dividerColor, width: 1),
                  ),
                  fillColor: theme.cardTheme.color,
                  filled: true,
                ),
                onChanged: (value) => _title = value,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  labelText: 'Subtitle',
                  labelStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryGreen, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.dividerColor, width: 1),
                  ),
                  fillColor: theme.cardTheme.color,
                  filled: true,
                ),
                onChanged: (value) => _subtitle = value,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _room,
                dropdownColor: theme.dialogBackgroundColor,
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  labelText: 'Room',
                  labelStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryGreen, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.dividerColor, width: 1),
                  ),
                  fillColor: theme.cardTheme.color,
                  filled: true,
                ),
                items: [
                  'Living Room',
                  'Bathroom',
                  'Kitchen',
                  'Bedroom',
                  'Office',
                  'Outdoor'
                ].map((room) => DropdownMenuItem(value: room, child: Text(room))).toList(),
                onChanged: (value) => setState(() => _room = value!),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: Text('Is On', style: TextStyle(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
                value: _isOn,
                activeColor: primaryGreen,
                onChanged: (value) => setState(() => _isOn = value),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),
              Text('Select Icon', style: TextStyle(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: icons.map((icon) {
                  final isSelected = icon == _selectedIcon;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIcon = icon),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? primaryGreen.withOpacity(0.2) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? primaryGreen : theme.dividerColor,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        icon,
                        color: isSelected ? primaryGreen : theme.colorScheme.onSurface.withOpacity(0.7),
                        size: 30,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.onSurface.withOpacity(0.7),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 4,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: primaryGreen,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onDeviceAdded(
                Device(
                  icon: _selectedIcon,
                  title: _title,
                  subtitle: _subtitle,
                  isOn: _isOn,
                ),
                _room,
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}