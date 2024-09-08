import 'package:HexagonWarrior/config/tx_configs.dart';
import 'package:HexagonWarrior/extensions/extensions.dart';
import 'package:HexagonWarrior/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TransactionPageState();
  }
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    final sp = Get.find<SharedPreferences>().getTransactionHashes();
    return Scaffold(
        appBar: AppBar(title: Text("transaction".tr), backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        body: ListView.separated(itemBuilder: (_, index){
          String key = sp.keys.toList()[index];
          return Card(child: ListTile(
              contentPadding: EdgeInsets.only(left: 12),
              trailing: IconButton(icon: Icon(Icons.arrow_forward_ios_rounded), onPressed: () {
                final path = '${op_sepolia.blockExplorerURL}/tx/${sp[key]}';
                logger.i("open url ${path}");
                launchUrl(Uri.parse(path));
              }),
              subtitle: Text("UserOpHash :\n$key", style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 10), textAlign: TextAlign.start).marginOnly(top: 4),
              title: Text("TransactionHash :\n ${sp[key]}", style: TextStyle(fontSize: 12), textAlign: TextAlign.start))).marginSymmetric(horizontal: 14);
        }, separatorBuilder: (_, index){
          return SizedBox(height: 4);
        }, itemCount: sp.keys.length));
  }
}
