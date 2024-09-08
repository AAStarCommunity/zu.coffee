import 'package:HexagonWarrior/config/tx_configs.dart';
import 'package:HexagonWarrior/extensions/extensions.dart';
import 'package:HexagonWarrior/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
        body: sp.isEmpty ? Center(child: Text("noMoreData".tr)) : ListView.separated(itemBuilder: (_, index){
          final keys = sp.keys.toList().reversed.toList();
          String key = keys[index];
          final values = sp[key].toString().split("_");
          return Card(child: ListTile(
              contentPadding: EdgeInsets.only(left: 12),
              trailing: IconButton(icon: Icon(Icons.arrow_forward_ios_rounded), onPressed: () {
                final path = '${op_sepolia.blockExplorerURL}/tx/${sp[key]}';
                logger.i("open url ${path}");
                launchUrl(Uri.parse(path));
              }),
              //subtitle: Text("UserOpHash :\n$key", style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 10), textAlign: TextAlign.start).marginOnly(top: 4),
              title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(),
                if(values.length > 1)Text("${DateFormat("yyyy-MM-dd hh:MM:ss").format(DateTime.parse(values[1]))}"),
                Text("TransactionHash :\n ${values.length > 0 ? values[0] : "******"}", style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary), textAlign: TextAlign.start)
              ]))).marginSymmetric(horizontal: 14);
        }, separatorBuilder: (_, index){
          return SizedBox(height: 4);
        }, itemCount: sp.keys.length));
  }
}
