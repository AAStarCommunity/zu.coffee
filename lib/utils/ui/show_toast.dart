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


showSnackMessage(String message) {
  if(Get.context != null) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text('${message}'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

Future<T?> showBiometricDialog<T>(BuildContext context, ValueChanged<int> callback) {
  return showDialog<T>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('dialogTitle'.tr),
        content: Text('dialogContent'.tr),
        actions: <Widget>[
          TextButton(
            child: Text('disagree'.tr),
            onPressed: () {
              Navigator.of(context).pop();
              // 这里可以添加用户不同意时的逻辑
              callback.call(0);
            },
          ),
          TextButton(
            child: Text('agree'.tr),
            onPressed: () {
              Navigator.of(context).pop();
              callback?.call(1);
            },
          ),
        ],
      );
    },
  );
}

Color randomColor() {
  final r = math.Random().nextInt(255);
  final g = math.Random().nextInt(255);
  final b = math.Random().nextInt(255);
  return Color.fromARGB(255, r, g, b);
}