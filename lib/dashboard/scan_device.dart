import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const AddDevice());
}

class AddDevice extends StatelessWidget {
  const AddDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Device Page',
      theme: ThemeData.dark().copyWith(
        // Dark theme configuration only
        scaffoldBackgroundColor: Colors.grey.shade900,
        colorScheme: ColorScheme.dark(
          primary: Colors.blue.shade300,
          secondary: Colors.blue.shade200,
          surface: Colors.grey.shade800,
          onSurface: Colors.white,
          error: Colors.red.shade400,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
          elevation: 1,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.grey.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.green.shade800,
          contentTextStyle: const TextStyle(color: Colors.white),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.grey.shade800,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const AddDevicePage(),
    );
  }
}

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  final MobileScannerController cameraController = MobileScannerController();
  bool isScanning = false;
  String? scannedResult;
  bool isTorchOn = false;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _toggleScanning() {
    setState(() {
      isScanning = !isScanning;
      if (!isScanning) {
        scannedResult = null;
      }
    });
  }

  void _toggleTorch() {
    setState(() {
      isTorchOn = !isTorchOn;
      cameraController.toggleTorch();
    });
  }

  void _showScanResult(String code) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Device Found'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('The following device was detected:'),
                const SizedBox(height: 10),
                Text(
                  code,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Would you like to add this device?'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    scannedResult = null;
                  });
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Device added successfully')),
                  );
                },
                child: const Text('Add Device'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Scan Devices', style: TextStyle(fontSize: 18)),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  if (isScanning)
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: MobileScanner(
                        controller: cameraController,
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          if (barcodes.isNotEmpty) {
                            final String? code = barcodes.first.rawValue;
                            if (code != null && scannedResult == null) {
                              setState(() {
                                scannedResult = code;
                                isScanning = false;
                              });
                              _showScanResult(code);
                            }
                          }
                        },
                      ),
                    )
                  else
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colors.outline.withOpacity(0.5),
                          width: 2,
                        ),
                        color:
                            scannedResult != null
                                ? Colors.green.shade800
                                : colors.surface.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child:
                            scannedResult != null
                                ? Icon(
                                  Icons.check,
                                  color: colors.onPrimary,
                                  size: 80,
                                )
                                : Icon(
                                  Icons.qr_code,
                                  color: colors.onSurface,
                                  size: 80,
                                ),
                      ),
                    ),

                  if (isScanning)
                    IgnorePointer(
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: colors.primary, width: 4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                scannedResult != null
                    ? "Device scanned successfully!"
                    : isScanning
                    ? "Align QR code within the frame"
                    : "Scan your smart device QR code",
                style: TextStyle(
                  fontSize: 16,
                  color:
                      scannedResult != null
                          ? Colors.green.shade300
                          : colors.onSurface.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              if (isScanning)
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      isTorchOn ? Icons.flash_off : Icons.flash_on,
                      color: colors.primary,
                      size: 30,
                    ),
                  ),
                  onPressed: _toggleTorch,
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _toggleScanning,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isScanning ? colors.error : colors.primary,
                    foregroundColor: colors.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isScanning ? 'Stop Scanning' : 'Start Scanning',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(isScanning ? Icons.stop : Icons.qr_code_scanner),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
