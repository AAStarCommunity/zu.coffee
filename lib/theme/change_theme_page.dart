import 'package:HexagonWarrior/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeThemePage extends GetView<ThemeController> {
  static const routeName = '/change_theme';

  ChangeThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("theme".tr, style: Theme.of(context).textTheme.titleMedium)),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Card(child: ListView.separated(itemCount: ThemeModel.themes.length, separatorBuilder: (_, __) {
          return Divider(thickness: .5, height: 0)
              .paddingSymmetric(horizontal: 18);
        }, itemBuilder: (_, index) {
            var model = ThemeModel.themes[index];
            return ListTile(title: Text(model.name.tr), selected: model.name == controller.themeModel.name, onTap: (){
              controller.changeTheme(model);
            });
          },physics: NeverScrollableScrollPhysics(), shrinkWrap: true, ), clipBehavior: Clip.hardEdge).paddingSymmetric(horizontal: 16)
        ]));
  }
}
