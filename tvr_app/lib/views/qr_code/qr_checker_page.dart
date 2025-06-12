import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCheckerPage extends StatefulWidget {
  const QRCheckerPage({super.key});

  @override
  State<QRCheckerPage> createState() => _QRCheckerPageState();
}

class _QRCheckerPageState extends State<QRCheckerPage> {
  final String allowedQR = 'https://www.tvr-project.com';
  bool _navigating = false;
  final MobileScannerController _scannerController = MobileScannerController();

  void _handleBarcode(BarcodeCapture barcodeCapture) {
    final code = barcodeCapture.barcodes.first.rawValue;

    if (code == null || _navigating) return;

    if (code == allowedQR) {
      setState(() => _navigating = true);
      _scannerController.stop();
      context.go('/qr');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Ongeldige QR-code')));
    }
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: _scannerController,
            onDetect: _handleBarcode,
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
