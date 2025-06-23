import 'package:flutter/material.dart';

class DeviceDetail extends StatefulWidget {
  final String deviceName;
  final IconData deviceIcon;

  const DeviceDetail({
    super.key,
    required this.deviceName,
    required this.deviceIcon,
  });

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
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[600],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          'Devices',
          style: TextStyle(
            color: Colors.white,
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
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Device Active",
                    style: TextStyle(color: Colors.white),
                  ),
                  Switch(
                    value: isDeviceOn,
                    activeColor: Colors.blue[600],
                    onChanged: (val) => setState(() => isDeviceOn = val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Text(
              "Controller",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
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
                    backgroundColor: Colors.grey[700],
                    valueColor: AlwaysStoppedAnimation(Colors.blue[600]!),
                  ),
                ),
                Text(
                  "${brightness.toInt()}%",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                  icon: Icon(Icons.remove, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Text(
                  "Auto",
                  style: TextStyle(
                    color: Colors.blue[400],
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
                  icon: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Mood",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Power Consumption",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "8 watts Smart Light",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.flash_on, color: Colors.blue[400]),
                          const SizedBox(height: 4),
                          Text(
                            "5 kWh",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Today",
                            style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.power, color: Colors.blue[400]),
                          const SizedBox(height: 4),
                          Text(
                            "120 kWh",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "This month",
                            style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                          ),
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
                  backgroundColor: Colors.blue[600],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Show a success snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Saved successfully!'),
                      backgroundColor: Colors.green[700],
                      duration: Duration(seconds: 1),
                    ),
                  );

                  // Delay pop so user can read the snackbar
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.pop(context);
                  });
                },
                child: Text(
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
                color: isSelected ? Colors.blue[400]! : Colors.grey[700]!,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.blue[400] : Colors.grey[400],
              size: 28,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.blue[400] : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}