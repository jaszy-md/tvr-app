import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCheckerPage extends StatefulWidget {
  const QRCheckerPage({super.key});

  @override
  State<QRCheckerPage> createState() => _QRCheckerPageState();
}

class _QRCheckerPageState extends State<QRCheckerPage> {
  final String allowedQR = 'https://qrco.de/bg4Yt2';
  bool _scanned = false;

  void _handleBarcode(BarcodeCapture barcodeCapture) {
    if (_scanned) return;

    final code = barcodeCapture.barcodes.first.rawValue;

    if (code == allowedQR) {
      setState(() => _scanned = true);
      context.go('/qr');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Ongeldige QR-code')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            onDetect: _handleBarcode,
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.normal,
              facing: CameraFacing.back,
            ),
            overlayBuilder: (context, constraints) => const ScannerOverlay(),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 4),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
