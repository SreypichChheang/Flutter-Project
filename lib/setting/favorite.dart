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
      theme: ThemeData(
        // Define a color scheme for a modern look, matching the image's aesthetic
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black).copyWith(
          primary: const Color(0xFF1A1A2E), // Dark primary color
          secondary: const Color.fromARGB(255, 0, 0, 0), // Accent color
          surface: Colors.white, // Default card/surface color
          background: const Color(0xFFF0F0F5), // Light background color
        ),
        useMaterial3: true, // Enable Material 3 design
        fontFamily: 'Inter', // Custom font for modern look
      ),
      home: const FavoriteScreen(),
    );
  }
}

// Device model to hold device information and its icon
class Device {
  final String title;
  final String deviceCount;
  bool isOn;
  final IconData icon; // Added icon property

  Device(this.title, this.deviceCount, this.isOn, {required this.icon});
}

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // Updated devices list with appropriate icons
  final List<Device> _devices = [
    Device('Lighting', '4 lamps', true, icon: Icons.lightbulb_outline),
    Device('Samsung Smart TV', '2 devices', false, icon: Icons.tv),
    Device('LG Air Conditioner', '1 device', true, icon: Icons.ac_unit),
    Device('HK Studio', '2 devices', false, icon: Icons.speaker),
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _countController = TextEditingController();
  bool _newDeviceStatus = false; // Initial status for new device

  void _toggleDevice(int index) {
    setState(() {
      _devices[index].isOn = !_devices[index].isOn;
    });
  }

  // Function to show the add device form as a bottom sheet
  void _showAddForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to take full height if needed
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
            top: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Make column only as tall as its children
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Device Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      filled: true,
                      fillColor: Color(0xFFE8E8EC),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a device name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _countController,
                    decoration: const InputDecoration(
                      labelText: 'Number of Devices',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      filled: true,
                      fillColor: Color(0xFFE8E8EC),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        'Status:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Switch(
                        value: _newDeviceStatus,
                        onChanged: (value) {
                          setState(() { // setState inside bottom sheet builder
                            _newDeviceStatus = value;
                          });
                        },
                        activeColor: Theme.of(context).colorScheme.secondary,
                      ),
                      Text(
                        _newDeviceStatus ? 'On' : 'Off',
                        style: TextStyle(
                          color: _newDeviceStatus ? Theme.of(context).colorScheme.secondary : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the bottom sheet
                          _nameController.clear();
                          _countController.clear();
                          _newDeviceStatus = false; // Reset status for next time
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Determine the icon based on device name (simple logic)
                            IconData newIcon;
                            if (_nameController.text.toLowerCase().contains('light')) {
                              newIcon = Icons.lightbulb_outline;
                            } else if (_nameController.text.toLowerCase().contains('tv')) {
                              newIcon = Icons.tv;
                            } else if (_nameController.text.toLowerCase().contains('air')) {
                              newIcon = Icons.ac_unit;
                            } else if (_nameController.text.toLowerCase().contains('studio') || _nameController.text.toLowerCase().contains('speaker')) {
                              newIcon = Icons.speaker;
                            } else {
                              newIcon = Icons.device_hub_outlined; // Default icon
                            }

                            setState(() {
                              _devices.add(Device(
                                _nameController.text,
                                '${_countController.text} ${int.parse(_countController.text) > 1 ? 'devices' : 'device'}',
                                _newDeviceStatus,
                                icon: newIcon,
                              ));
                              Navigator.pop(context); // Close the bottom sheet
                              _nameController.clear();
                              _countController.clear();
                              _newDeviceStatus = false; // Reset status for next time
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
          'Favorite',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: _showAddForm,
            tooltip: 'Add Favorite',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Energy Saving Card
            _buildEnergySavingCard(),
            const SizedBox(height: 24),
            // Room Navigation
            _buildRoomNavigation(),
            const SizedBox(height: 24),
            // Device Grid
            GridView.builder(
              shrinkWrap: true, // Important to make GridView work inside SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns as per the image
                crossAxisSpacing: 16.0, // Spacing between columns
                mainAxisSpacing: 16.0, // Spacing between rows
                childAspectRatio: 0.85, // Adjust as needed to fit content (height slightly more than width)
              ),
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final device = _devices[index];
                return _buildDeviceCard(
                  device: device,
                  onTap: () => _toggleDevice(index),
                );
              },
            ),
          ],
        ),
      ),
      // Floating action button moved to body to be part of the scrollable content if desired,
      // but typically it's part of the Scaffold directly. Keeping it as is.
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddForm,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Slightly less rounded for consistency
        ),
        elevation: 4.0,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Position it at the end bottom
    );
  }

  // Widget for the Energy Saving card
  Widget _buildEnergySavingCard() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary, // Use primary color for dark background
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Energy Saving',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '+35%',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255), // Accent color for the percentage
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '23.5 kWh',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          // Lightning bolt icon
          Image.asset(
            'images/lightning_bolt.png', // Placeholder for lightning bolt image
            height: 100,
            width: 100,
            errorBuilder: (context, error, stackTrace) {
              // Fallback to an icon if image is not found
              return Icon(
                Icons.electric_bolt,
                size: 80,
                color: Theme.of(context).colorScheme.secondary,
              );
            },
          ),
        ],
      ),
    );
  }

  // Widget for Room Navigation (Living Room, Bedroom, Kitchen)
  Widget _buildRoomNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildRoomTab('Living Room', isSelected: true),
        const SizedBox(width: 24),
        _buildRoomTab('Bedroom'),
        const SizedBox(width: 24),
        _buildRoomTab('Kitchen'),
      ],
    );
  }

  // Helper for individual room tabs
  Widget _buildRoomTab(String title, {bool isSelected = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.black : Colors.grey[600],
          ),
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 4,
            width: 20, // Small underline for selected tab
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }

  // Widget for individual device cards
  Widget _buildDeviceCard({
    required Device device,
    required VoidCallback onTap,
  }) {
    final bool isOn = device.isOn;
    final Color cardColor = isOn ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface;
    final Color textColor = isOn ? Colors.white : Colors.black87;
    final Color lightTextColor = isOn ? Colors.white70 : Colors.grey[600]!;
    final Color toggleColor = isOn ? Theme.of(context).colorScheme.secondary : Colors.grey;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isOn ? Theme.of(context).colorScheme.secondary : Colors.grey[200], // Icon background color
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  device.icon,
                  color: isOn ? Colors.white : Colors.black,
                  size: 28,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  device.deviceCount,
                  style: TextStyle(
                    fontSize: 14,
                    color: lightTextColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isOn ? 'On' : 'Off',
                  style: TextStyle(
                    fontSize: 14,
                    color: isOn ? Theme.of(context).colorScheme.secondary : lightTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Transform.scale(
                  scale: 0.8, // Scale down the switch to make it smaller
                  child: Switch(
                    value: isOn,
                    onChanged: (newValue) => onTap(), // Trigger the onTap function
                    activeColor: Theme.of(context).colorScheme.secondary,
                    inactiveTrackColor: Colors.grey[300],
                    inactiveThumbColor: Colors.white,
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
