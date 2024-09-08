import 'package:HexagonWarrior/theme/change_language_page.dart';
import 'package:HexagonWarrior/theme/change_theme_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    final items = [
      ListTile(leading: Icon(Icons.light_mode), title: Text("theme".tr), onTap: () {
        Get.toNamed(ChangeThemePage.routeName);
      }, enableFeedback: false),
      ListTile(leading: Icon(Icons.language_rounded), title: Text("language".tr), onTap: () {
        Get.toNamed(ChangeLanguagePage.routeName);
      }),
    ];
    return Scaffold(
        appBar: AppBar(title: Text('settings'.tr, style: Theme.of(context).textTheme.titleMedium), backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        body: SingleChildScrollView(child: Column(children: [
          Card(
              clipBehavior: Clip.hardEdge,
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              child: ListView.separated(physics: NeverScrollableScrollPhysics(), shrinkWrap: true, itemBuilder: (_, index){
                return items[index];
              }, separatorBuilder: (_, __){
                return Divider(thickness: .5, height: 0).paddingSymmetric(horizontal: 18);
              }, itemCount: items.length))
        ])).marginSymmetric(horizontal: 16),
    );
  }
}
