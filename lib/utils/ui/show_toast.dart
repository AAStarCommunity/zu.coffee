import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../validate_util.dart';
import 'loading_dialog.dart';
import 'dart:math' as math;

toast(String msg, {int duration = 1, int? gravity}) {
  if (isNotNull(msg)) {
    EasyLoading.showToast(msg);
  }else{
    EasyLoading.showToast('异常信息为空');
  }
}

showLoading({String msg = '', bool transparent = false}) {
  Get.dialog(
      LoadingDialog(msg),
      barrierColor: Colors.transparent,
      barrierDismissible: false);
}

closeLoading() {
  if(Get.isDialogOpen ?? false)Get.back();
}


showSnackMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${message}'),
      duration: Duration(seconds: 2),
    ),
  );
}

Color randomColor() {
  final r = math.Random().nextInt(255);
  final g = math.Random().nextInt(255);
  final b = math.Random().nextInt(255);
  return Color.fromARGB(255, r, g, b);
}