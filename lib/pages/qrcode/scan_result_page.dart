import 'dart:async';

import 'package:HexagonWarrior/pages/account/account_controller.dart';
import 'package:HexagonWarrior/utils/ui/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/validate_util.dart';

class ScanResultPage extends GetView<AccountController> {

  static const routeName = "/scan_result";

  ScanResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final address = Get.parameters["code"];
    final sender = controller.state?.aa;
    return Scaffold(appBar: AppBar(title: Text("scanResult".tr, style: Theme.of(context).textTheme.titleMedium)), body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("${"address".tr}：", style: TextStyle(fontWeight: FontWeight.w600)),
      Text("$address"),
      const SizedBox(height: 8),
      Text("${"sender".tr}：", style: TextStyle(fontWeight: FontWeight.w600)),
      Text("$sender"),
      const SizedBox(height: 8),
      Row(children: [
        Text("${"amount".tr}：", style: TextStyle(fontWeight: FontWeight.w600)),
        Text("1 usdt"),
        //Text("USDT Blance：${}")
      ]),
      const SizedBox(height: 24),
      ObxValue((handing){
        return Row(children: [FilledButton(onPressed: () async{
          if(handing.value) {
            toast("wait".tr);
            return;
          }
          await runZonedGuarded(() async {
            handing.value = true;
            final balance = await Get.find<AccountController>().sendUsdt(receiver: address, amount: 1);
            handing.value = false;
            if(isNotNull(balance)) {
              toast("paySuccess".tr);
              await Future.delayed(const Duration(seconds: 200));
              Get.back();
            }
          }, (e, s) {
            handing.value = false;
            if(!e.toString().contains("filter"))toast(e.toString());
          });
        }, child: handing.value ? SizedBox(width: 12, height: 12, child: Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))) : Text("pay".tr))], mainAxisAlignment: MainAxisAlignment.center);
      }, false.obs)
    ]).paddingSymmetric(horizontal: 24));
  }

}