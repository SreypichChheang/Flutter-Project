import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Us Page',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue[800],
        colorScheme: ColorScheme.dark(
          primary: Colors.blue[300]!,
          secondary: Colors.blue[200]!,
          surface: Colors.grey[900]!,
          background: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.grey[850],
          elevation: 2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      home: const AboutUsPage(),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction/Description Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Smart home technology is a system that allows users to control home appliances, lighting, etc., allowing homeowners to remotely manage and monitor their systems, integrating with multiple devices for improved automation, enhancing convenience, security and energy savings.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: colors.onSurface.withOpacity(0.9),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      "assets/images/pic.png",
                      color: Colors.white.withOpacity(0.8),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),

            // "Process to do it" Section
            Text(
              'Process to do it',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 20.0),
            _buildProcessTimeline(theme),
            const SizedBox(height: 30.0),

            // "Why should we use this application?" Section
            Text(
              'Why should we use this application?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 20.0),
            _buildWhyUseAppGrid(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessTimeline(ThemeData theme) {
    final colors = theme.colorScheme;
    final List<String> processSteps = [
      'Sign Up & Login',
      'Connect Your Smart Devices',
      'Customize Your Settings',
      'Setup a Voice Control',
      'Build & Control',
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: processSteps.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: 80,
                    child: Text(
                      processSteps[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0, 
                        color: colors.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              if (index < processSteps.length - 1)
                Container(
                  width: 50,
                  height: 2.0,
                  color: colors.primary,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWhyUseAppGrid(ThemeData theme) {
    final colors = theme.colorScheme;
    final List<Map<String, dynamic>> features = [
      {'icon': Icons.lightbulb_outline, 'text': 'Energy Saving'},
      {'icon': Icons.devices_other, 'text': 'Smart Control'},
      {'icon': Icons.security, 'text': 'Security'},
      {'icon': Icons.integration_instructions, 'text': 'Easy Integration'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.2,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  features[index]['icon'] as IconData,
                  size: 40,
                  color: colors.primary,
                ),
                const SizedBox(height: 10),
                Text(
                  features[index]['text'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}