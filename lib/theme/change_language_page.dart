import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../translations/translations.dart';

class ChangeLanguagePage extends StatelessWidget {
  static const routeName = '/change_language';

  ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("language".tr, style: Theme.of(context).textTheme.titleMedium)),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Card(child: ListView.separated(
                      itemCount: AppTranslations.supportLanguages.length,
                      separatorBuilder: (_, __) {
                        return Divider(thickness: .5, height: 0)
                            .paddingSymmetric(horizontal: 18);
                      },
                      itemBuilder: (_, index) {
                        var language = AppTranslations.supportLanguages[index];
                        return ListTile(onTap: () {
                          Get.updateLocale(language.item2);
                        }, title: Text(language.item1.tr), selected: language.item2 == Get.locale);
                      },
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true),
                  clipBehavior: Clip.hardEdge)
              .paddingSymmetric(horizontal: 16)
        ]));
  }
}
