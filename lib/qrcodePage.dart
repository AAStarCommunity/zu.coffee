import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // 這裡處理掃描到的 QR 碼數據
      print(scanData.code);
    });
  }

  void _startQRScan() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text('Scan QR Code'),
              ),
              body: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              QrImageView(
                data: 'https://www.google.com',
                version: QrVersions.auto,
                size: 200.0,
              ),
              OutlinedButton(
                onPressed: _startQRScan,
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                  backgroundColor: WidgetStateProperty.all<Color>(
                    const Color.fromARGB(255, 245, 241, 248),
                  ),
                  side: WidgetStateProperty.all(
                    const BorderSide(width: 0.0, color: Colors.transparent),
                  ),
                ),
                child: Text('SCAN QR CODE',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12)),
              ),
            ]),
      ),
    );
  }
}
