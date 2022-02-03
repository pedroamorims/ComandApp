import 'dart:io';

import 'package:comandapp/models/comanda_model.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => QRCodeScannerState();
}

class QRCodeScannerState extends State<QRCodeScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return QRView(
      cameraFacing: CameraFacing.back,
      // Use the rear camera
      key: qrKey,
      // The global key for the scanner
      onQRViewCreated: _onQRViewCreated,
      // Function to call after the QR View is created
      overlay: QrScannerOverlayShape(
        // Configure the overlay to look nice
        borderRadius: 10,
        borderWidth: 5,
        borderColor: Colors.white,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    // Retrieve the list of expected values
    // Subscribe to the incoming events from our QR Code Scanner
    controller.scannedDataStream.listen((scanData) {

       // If the scanned code matches any of the items in our list...
      // ... then we open the page confirming the order with our user
    if(ComandaModel.of(context).comandaatual == "") {
      ComandaModel.of(context).comandaatual = scanData.code ?? "";
      ComandaModel.of(context).updateTotal();
      Navigator.of(context).pop();

    }

    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

}
