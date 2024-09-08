import 'package:HexagonWarrior/pages/qrcode/scan_result_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../utils/validate_util.dart';

class ScanActionContainer extends StatefulWidget{

  final String sender;
  final Widget child;

  ScanActionContainer({super.key, required this.child, required this.sender});

  @override
  State<StatefulWidget> createState() {
    return _ScanContainerState();
  }

}


class _ScanContainerState extends State<ScanActionContainer>{

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _flag = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller, String sender) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      final code = scanData.code;
      if(isNotNull(code)) {
        if(_flag){
          return;
        }
        _flag = true;
        Get.toNamed(ScanResultPage.routeName, parameters: {"code" : code!})?.then((_){
          _flag = false;
        });
      }
    });
  }


  void _startQRScan(String sender) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () {
              Get.back();
            }),
            backgroundColor: Colors.transparent,
            //title: Text('Scan QR Code', style: Theme.of(context).textTheme.titleMedium),
          ),
          body: QRView(
            onQRViewCreated: (ctrl) {
              _onQRViewCreated(ctrl, sender);
            },
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ), key: qrKey,
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(child: IgnorePointer(child: widget.child, ignoring: true), onTap: () {
      _startQRScan(widget.sender);
    });
  }

}