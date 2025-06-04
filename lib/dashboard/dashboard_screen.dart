import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: LandingPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  final Map<String, List<DeviceCard>> devicesByCategory = const {
    "All Devices": [
      DeviceCard(name: "Air Conditioner", lamps: 4, icon: Icons.ac_unit),
      DeviceCard(name: "Lighting", lamps: 4, icon: Icons.lightbulb_outline),
      DeviceCard(name: "Fan", lamps: 2, icon: Icons.toys),
      DeviceCard(name: "Heater", lamps: 1, icon: Icons.whatshot),
    ],
    "Living Room Devices": [
      DeviceCard(name: "Lighting", lamps: 4, icon: Icons.lightbulb_outline),
      DeviceCard(name: "TV", lamps: 1, icon: Icons.tv),
    ],
    "Bathroom Devices": [
      DeviceCard(name: "Water Heater", lamps: 1, icon: Icons.wb_sunny),
      DeviceCard(name: "Exhaust Fan", lamps: 1, icon: Icons.toys),
    ],
    "Kitchen Devices": [
      DeviceCard(name: "Refrigerator", lamps: 1, icon: Icons.kitchen),
      DeviceCard(name: "Lighting", lamps: 2, icon: Icons.lightbulb_outline),
      DeviceCard(name: "Microwave", lamps: 1, icon: Icons.microwave),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
         
          backgroundColor: Colors.blue,
          elevation: 0,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "All"),
              Tab(text: "Living Room"),
              Tab(text: "Bathroom"),
              Tab(text: "Kitchen"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent("All Devices", devicesByCategory["All Devices"]!),
            _buildTabContent("Living Room Devices", devicesByCategory["Living Room Devices"]!),
            _buildTabContent("Bathroom Devices", devicesByCategory["Bathroom Devices"]!),
            _buildTabContent("Kitchen Devices", devicesByCategory["Kitchen Devices"]!),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String title, List<DeviceCard> devices) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWeatherCard(),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildDeviceGrid(devices),
        ],
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.indigo],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("23°C   Phnom Penh, Cambodia", style: TextStyle(color: Colors.white)),
          Text("Cloudy", style: TextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Indoor Temp\n28°C", style: TextStyle(color: Colors.white)),
              Text("Humidity\n40%", style: TextStyle(color: Colors.white)),
              Text("Air Quality\nGood", style: TextStyle(color: Colors.white)),
              Icon(Icons.cloud, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceGrid(List<DeviceCard> devices) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: devices,
    );
  }
}

class DeviceCard extends StatefulWidget {
  final String name;
  final int lamps;
  final IconData icon;

  const DeviceCard({
    super.key,
    required this.name,
    required this.lamps,
    required this.icon,
  });

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[800],
              child: Icon(widget.icon, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(widget.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text("${widget.lamps} lamp${widget.lamps > 1 ? 's' : ''}", style: const TextStyle(color: Colors.white70)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(isOn ? "ON" : "OFF", style: const TextStyle(color: Colors.white)),
                Switch(
                  value: isOn,
                  onChanged: (value) {
                    setState(() {
                      isOn = value;
                    });
                  },
                  activeColor: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
