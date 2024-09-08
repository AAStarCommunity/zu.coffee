import 'dart:io';
import 'dart:typed_data';
import 'package:HexagonWarrior/pages/qrcode/scan_container.dart';
import 'package:HexagonWarrior/utils/ui/show_toast.dart';
import 'package:HexagonWarrior/utils/validate_util.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:ui' as ui;
import '../../utils/ui/over_repaint_boundary.dart';
import '../account/account_controller.dart';
import 'scan_result_page.dart';

class QRCodePage extends StatefulWidget {

  static const String routeName = "/qr_code_scanner";

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  GlobalKey<OverRepaintBoundaryState> _repaintKey = GlobalKey();
  final _accountCtrl = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('qrCode'.tr, style: Theme.of(context).textTheme.titleMedium),
        actions: [
          // IconButton(onPressed: _startQRScan, icon: Icon(CupertinoIcons.camera_viewfinder))
        ],
      ),
      body: _accountCtrl.obx(
        onError: (err) => Center(child: Text("$err")),
        onLoading: const Center(child: CircularProgressIndicator.adaptive()),
        (state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Row(),
                OverRepaintBoundary(
                    key: _repaintKey,
                    child: RepaintBoundary(
                      child: Container(
                          color: Colors.white,
                          //padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          child:  Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                            // Row(children: [
                            //   Container(
                            //       width: 60,
                            //       height: 60,
                            //       decoration: BoxDecoration(color: randomColor(), borderRadius: BorderRadius.circular(4))),
                            //   Column(children: [
                            //     Text("${state?.email}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                            //     //Text("")
                            //   ]).marginOnly(left: 12)
                            // ]).marginOnly(left: 30, bottom: 24),
                            SizedBox(width: context.width - 100, height: context.width - 100, child: PrettyQrView.data(
                              data: state?.aa ?? "",
                              decoration: const PrettyQrDecoration(
                                image: PrettyQrDecorationImage(
                                  image: AssetImage('assets/images/ic_launcher.png'),
                                ),
                              ),
                            )).paddingSymmetric(vertical: 50),
                            // const Text("扫描二维码，马上认识我")
                          ])),
                    )),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ScanActionContainer(child: FilledButton(onPressed: () {  }, child: Text('scanQrCode'.tr)), sender: state?.aa ?? "").marginOnly(top: 24),
                  const SizedBox(width: 40),
                  FilledButton(
                    onPressed: () {
                      _repaintKey.currentState?.saveImage(context);
                      //_saveImage(context);
                    },
                    child: Text('download'.tr),
                  ).marginOnly(top: 24),
                ]),
              ]);
        })
    );
  }
}
