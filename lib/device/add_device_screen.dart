import 'package:flutter/material.dart';
import 'package:app/device/device_connection.dart';

class DevicesHomeScreen extends StatefulWidget {
  const DevicesHomeScreen({super.key});

  @override
  State<DevicesHomeScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> allDevices = ['TV', 'FRIDGE', 'FAN'];
  List<String> filteredDevices = [];

  @override
  void initState() {
    super.initState();
    filteredDevices = List.from(allDevices);
    _searchController.addListener(_filterDevices);
  }

  void _filterDevices() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredDevices = allDevices
          .where((device) => device.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _goToAddDeviceScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DevicePairingScreen()),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Icon(
              Icons.arrow_back_ios_rounded, 
              size: 25, 
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Devices',
          style: const TextStyle(
            fontSize: 22, 
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildAddDeviceCard() {
    return GestureDetector(
      onTap: () => _goToAddDeviceScreen(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Click here to add some more\ndevices in your smart home',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _goToAddDeviceScreen(context),
              icon: const Icon(
                Icons.add, 
                color: Colors.white, 
                size: 24
              ),
              label: const Text(
                'Add Device',
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 16
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                elevation: 2,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search Devices',
        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[800],
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.grey[700]!,
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceGrid() {
    return Expanded(
      child: GridView.builder(
        itemCount: filteredDevices.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final device = filteredDevices[index];
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  device,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Icon(
                  Icons.devices_other, 
                  color: Colors.blue[400], 
                  size: 40
                ),
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.blue[400],
                  child: const Icon(
                    Icons.add, 
                    size: 16, 
                    color: Colors.white
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildAddDeviceCard(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),
              const Text(
                'Browse here',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              _buildDeviceGrid(),
            ],
          ),
        ),
      ),
    );
  }
}