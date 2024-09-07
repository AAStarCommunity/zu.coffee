import 'dart:io';
import 'dart:typed_data';
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
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  final _accountCtrl = Get.find<AccountController>();

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  bool isShow = false;

  _requestPermission(BuildContext context, VoidCallback pass) async {
    if(!(await Permission.photos.isGranted)){
      PermissionStatus res;
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          res = await Permission.storage.request();
        }  else {
          res = await Permission.photos.request();
        }
      } else {
        res = await Permission.photos.request();
      }
      if(res.isGranted) {
        pass.call();
      } else {
        isShow = false;
        toast("请打开存储权限");
        openAppSettings();
      }
    }else{
      if(pass != null) pass();
    }
  }

  _saveImage(BuildContext context) async{
    try {
      if (isShow) {
        showLoading(msg: "正在生成");
        return;
      }
      isShow = true;
      var renderObject = _repaintKey.currentContext?.findRenderObject();

      var boundary = renderObject! as RenderRepaintBoundary;
      ui.Image captureImage = await boundary.toImage(
          pixelRatio:
          2); //pixelRatio: FlutterCallAndroidBridge.instance.phoneDevicePixelRatio as double

      ByteData? byteData = await captureImage.toByteData(format: ui.ImageByteFormat.png);
      if(byteData == null){
        return;
      }
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      _requestPermission(context, () async{
        final path = await ImageGallerySaver.saveImage(pngBytes);
        if(path != null){
          isShow = false;
          toast("保存成功");
        }
      });
      /*String path = "";
                    if (path == "") {
                      final directory = (await getTemporaryDirectory()).path;
                      String fileName = DateTime.now().toIso8601String();
                      path = '$directory/$fileName.png';
                    }
                    File imgFile = new File(path);
                    await imgFile.writeAsBytes(pngBytes).then((path) {
                      debugPrint("地址：$path");
                    });*/
    } catch (error) {
      debugPrint(error.toString());
      toast("生成长图失败");
      isShow = false;
    }
  }

  bool _flag = false;

  void _onQRViewCreated(QRViewController controller, String sender) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      final code = scanData.code;
      if(isNotNull(code)) {
        if(_flag){
          return;
        }
        _flag = true;
        Get.offAndToNamed(ScanResultPage.routeName, parameters: {"code" : code!})?.then((_){
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
                key: qrKey,
                onQRViewCreated: (ctrl) {
                  _onQRViewCreated(ctrl, sender);
                },
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
                                  image: AssetImage('assets/images/icon-64@3x.png'),
                                ),
                              ),
                            )).paddingSymmetric(vertical: 50),
                            // const Text("扫描二维码，马上认识我")
                          ])),
                    )),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FilledButton(
                    onPressed: () {
                      _startQRScan(state?.aa ?? "");
                    },
                    child: Text('scanQrCode'.tr),
                  ).marginOnly(top: 24),
                  const SizedBox(width: 40),
                  FilledButton(
                    onPressed: () {
                      _saveImage(context);
                    },
                    child: Text('download'.tr),
                  ).marginOnly(top: 24),
                ]),
              ]);
        })
    );
  }
}
