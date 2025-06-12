import 'package:flutter/material.dart';

class DeviceDetail extends StatefulWidget {

  final String deviceName;
  final IconData deviceIcon;

  const DeviceDetail(
    {super.key, required this.deviceName, required this.deviceIcon});

  @override
  State<DeviceDetail> createState() => _DeviceDetailState();
}

class _DeviceDetailState extends State<DeviceDetail> {
  double brightness = 80;
  bool isDeviceOn = true;
  String selectedMood = 'Auto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Smart Light',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Toggle Device On/Off
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Device Active"),
                  Switch(
                    value: isDeviceOn,
                    activeColor: Colors.black,
                    onChanged: (val) => setState(() => isDeviceOn = val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Controller",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            // Circular Brightness Indicator
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 140,
                  width: 140,
                  child: CircularProgressIndicator(
                    value: brightness / 100,
                    strokeWidth: 20,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation(Colors.black),
                  ),
                ),
                Text(
                  "${brightness.toInt()}%",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            // Brightness Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      brightness = (brightness - 10).clamp(0, 100);
                    });
                  },
                  icon: const Icon(Icons.remove, color: Colors.black),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Auto",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    setState(() {
                      brightness = (brightness + 10).clamp(0, 100);
                    });
                  },
                  icon: const Icon(Icons.add, color: Colors.black),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Mood",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            // Mood Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                moodButton("Auto", Icons.auto_mode),
                moodButton("Day", Icons.wb_sunny_outlined),
                moodButton("Night", Icons.nightlight_round),
              ],
            ),

            const SizedBox(height: 20),

            // Power Consumption Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Power Consumption",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text("8 watts Smart Light"),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Column(
                        children: [
                          Icon(Icons.flash_on, color: Colors.black),
                          SizedBox(height: 4),
                          Text("5 kWh"),
                          Text("Today", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.power, color: Colors.black),
                          SizedBox(height: 4),
                          Text("120 kWh"),
                          Text("This month", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Save logic here
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget moodButton(String label, IconData icon) {
    final isSelected = selectedMood == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMood = label;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.black : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.black : Colors.grey,
              size: 28,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
