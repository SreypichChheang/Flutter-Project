import 'package:flutter/material.dart';
import 'package:app/dashboard/home_page.dart';
import 'package:app/device/device_connection.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.black;
    final textColor = isDarkMode ? Colors.white : Colors.white;
    final buttonColor = isDarkMode ? Colors.white : Colors.white;
    final buttonTextColor = isDarkMode ? Colors.black : Colors.black;
    final searchBgColor = isDarkMode ? Colors.grey[800] : Colors.grey[200];
    final searchTextColor = isDarkMode ? Colors.white : Colors.black54;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(padding: const EdgeInsets.all(8.0)),
        title: Text(
          'Devices',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Device Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Click here to add some more devices in your smart home',
                          style: TextStyle(color: textColor, fontSize: 14.0),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DevicePairingScreen(),
                              ),
                            );
                          },
                          icon: Icon(Icons.add, color: buttonTextColor),
                          label: Text(
                            'Add Device',
                            style: TextStyle(color: buttonTextColor),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset("assets/images/boy.png"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: searchBgColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Devices',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: searchTextColor),
                  hintStyle: TextStyle(color: searchTextColor),
                ),
                style: TextStyle(color: searchTextColor),
              ),
            ),
            const SizedBox(height: 20.0),

            // Browse here section
            Text(
              'Browse here',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.9,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return DeviceCard(deviceName: 'Tv', isDarkMode: isDarkMode);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final String deviceName;
  final bool isDarkMode;

  const DeviceCard({
    super.key,
    required this.deviceName,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.black,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[800],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  Icons.tv,
                  color: isDarkMode ? Colors.white70 : Colors.white70,
                  size: 50,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                deviceName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.white : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: isDarkMode ? Colors.black : Colors.black,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
