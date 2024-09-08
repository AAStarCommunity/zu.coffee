import 'dart:async';
import 'dart:convert';

import 'package:HexagonWarrior/pages/account/account_controller.dart';
import 'package:HexagonWarrior/pages/home/share_coffee_bottom_sheet.dart';
import 'package:HexagonWarrior/theme/resorces_list.dart';
import 'package:HexagonWarrior/utils/ui/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/validate_util.dart';

class ScanResultPage extends GetView<AccountController> {

  static const routeName = "/scan_result";

  ScanResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("scanResult".tr, style: Theme.of(context).textTheme.titleMedium), backgroundColor: Theme.of(context).scaffoldBackgroundColor), body: LayoutBuilder(builder: (_, __){
      final codeData = Get.parameters["code"];
      if(!isNotNull(codeData)) {
        return Center(child: Text("Invalid data"));
      }
      final codeMap = jsonDecode(codeData!);
      final shareData = ShareData.fromJson(codeMap);
      final address = shareData.receiver;
      final sender = controller.state?.aa;
      final coffeeMap = jsonDecode(shareData.coffee);
      final coffee = Coffee.fromJson(coffeeMap);
      final maxWidth = context.width / 2;
      final size = coffeeMap["size"];
      return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [CoffeeWidget(coffee: coffee, size: size, maxWidth: maxWidth, bottom: SizedBox())], mainAxisAlignment: MainAxisAlignment.center),
        const SizedBox(height: 20),
        Text("${"address".tr}：", style: TextStyle(fontWeight: FontWeight.w600)),
        Text("$address"),
        const SizedBox(height: 8),
        Text("${"sender".tr}：", style: TextStyle(fontWeight: FontWeight.w600)),
        Text("$sender"),
        const SizedBox(height: 8),
        Row(children: [
          Text("${"amount".tr}：", style: TextStyle(fontWeight: FontWeight.w600)),
          Text("${coffee.getPrice(size)} ", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16, fontWeight: FontWeight.bold)),
          //Text("USDT Blance：${}")
        ]),
        const SizedBox(height: 24),
        ObxValue((handing){
          return Row(children: [FilledButton(onPressed: () async{
            await showBiometricDialog(context, (index) async{
              if(index == 1) {
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
              }
            });
          }, child: handing.value ? SizedBox(width: 12, height: 12, child: Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))) : Text("pay".tr))], mainAxisAlignment: MainAxisAlignment.center);
        }, false.obs)
      ]).paddingSymmetric(horizontal: 24));
    }));
  }

}