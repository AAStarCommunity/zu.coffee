import 'package:HexagonWarrior/translations/zh_cn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import 'en.dart';

class AppTranslations extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'zh_CN': zhCN,
      };

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('zh', 'CN'),
  ];

  static const fallbackLocale = Locale('en');

  static List<Tuple2<String, Locale>> get supportLanguages => supportedLocales.map<Tuple2<String, Locale>>((e) {
    if(e.languageCode == 'en'){
      return Tuple2('en', e);
    }
    return Tuple2("zh", e);
  }).toList();
}
