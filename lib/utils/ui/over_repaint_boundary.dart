import 'dart:io';
import 'dart:typed_data';

import 'package:HexagonWarrior/utils/ui/show_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class OverRepaintBoundary extends StatefulWidget {
  final Widget child;

  const OverRepaintBoundary({Key? key, required this.child}) : super(key: key);

  @override
  OverRepaintBoundaryState createState() => OverRepaintBoundaryState();
}

class OverRepaintBoundaryState extends State<OverRepaintBoundary> {

  GlobalKey<OverRepaintBoundaryState> _repaintKey = GlobalKey();
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

  saveImage(BuildContext context) async{
    try {
      if (isShow) {
        showLoading(msg: "generating".tr);
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
          toast("saveSuc".tr);
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
      toast("saveFail".tr);
      isShow = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: widget.child, key: _repaintKey);
  }
}