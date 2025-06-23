import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dark Mode QR Scanner',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.grey),
      ),
      home: const AddDevice(),
    );
  }
}

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final MobileScannerController cameraController = MobileScannerController();
  bool isScanning = false;
  bool isTorchOn = false;
  String? scannedCode;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _toggleScanning() {
    setState(() {
      if (isScanning) {
        // Stop scanning
        isScanning = false;
      } else {
        // Start scanning
        scannedCode = null;
        isScanning = true;
      }
    });
  }

  void _toggleTorch() {
    setState(() {
      isTorchOn = !isTorchOn;
      cameraController.toggleTorch();
    });
  }

  void _onDetect(BarcodeCapture capture) {
    if (!isScanning) return; // ignore if not scanning

    final barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final code = barcodes.first.rawValue;
      if (code != null && scannedCode == null) {
        setState(() {
          scannedCode = code;
          isScanning = false;
        });
        _showResultDialog(code);
      }
    }
  }

  void _showResultDialog(String code) {
    final colors = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.surface,
        title: Text('QR Code Detected', style: TextStyle(color: colors.onSurface)),
        content: Text(code, style: TextStyle(color: colors.onSurface)),
        actions: [
          TextButton(
            child: Text('Close', style: TextStyle(color: colors.primary)),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                scannedCode = null;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: scaffoldBg,
    appBar: AppBar(
  centerTitle: true,
  backgroundColor: const Color.fromARGB(255, 255, 255, 255), // black background
  title: Center(
    child: Text(
      'QR Code Scanner',
      style: TextStyle(
        color: const Color.fromARGB(255, 0, 0, 0),  // white text for contrast
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),


      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Scanner preview or placeholder box
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: colors.surface.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: isScanning
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: MobileScanner(
                          controller: cameraController,
                          onDetect: _onDetect,
                        ),
                      )
                    : Center(
                        child: scannedCode != null
                            ? Icon(Icons.check_circle, color: Colors.green, size: 80)
                            : Icon(Icons.qr_code_scanner, color: colors.onSurface, size: 80),
                      ),
              ),
              const SizedBox(height: 24),

              // Display scanned code text or instruction
              Text(
                scannedCode ??
                    (isScanning
                        ? 'Align QR code within the frame'
                        : 'Tap "Start Scanning" to scan a QR code'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: scannedCode != null
                      ? Colors.green.shade300
                      : colors.onSurface.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),

              // Torch toggle button shown only when scanning
              if (isScanning)
                IconButton(
                  icon: Icon(
                    isTorchOn ? Icons.flash_off : Icons.flash_on,
                    color: colors.primary,
                    size: 32,
                  ),
                  onPressed: _toggleTorch,
                ),

              const SizedBox(height: 24),

              // Start / Stop scanning button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: Icon(isScanning ? Icons.stop : Icons.qr_code_scanner),
                  label: Text(isScanning ? 'Stop Scanning' : 'Start Scanning'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isScanning ? colors.error : Colors.black,
                    foregroundColor: colors.onPrimary,
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _toggleScanning,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
