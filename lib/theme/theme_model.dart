import 'package:HexagonWarrior/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/validate_util.dart';

abstract class ThemeModel {
  late String name;
  late ThemeMode mode;
  late Color backgroundColor;
  late Color textColor;

  static final themes = <ThemeModel>[
    SystemThemeModel(),
    DarkThemeModel(),
    LightThemeModel()
  ];
}

class SystemThemeModel implements ThemeModel{
  @override
  ThemeMode mode = ThemeMode.system;

  @override
  String name = "system";

  @override
  Color backgroundColor = Colors.white;

  @override
  Color textColor = Colors.black;

}

class LightThemeModel implements ThemeModel{
  @override
  ThemeMode mode = ThemeMode.light;

  @override
  String name = "light";

  @override
  Color backgroundColor = Colors.white;

  @override
  Color textColor = Colors.black;

}

class DarkThemeModel implements ThemeModel{

  @override
  ThemeMode mode = ThemeMode.dark;

  @override
  String name = "dark";

  @override
  Color backgroundColor = Colors.black;

  @override
  Color textColor = Colors.white;

}

class ThemeController extends GetxController {
  static ThemeController get i => Get.find();

  final _theme = 'system'.obs;

  @override
  void onInit() {
    super.onInit();
    final theme = Get.find<SharedPreferences>().theme;
    if(isNotNull(theme)){
      _theme.value = theme!;

      if(themeModel is SystemThemeModel) {
        Get.changeThemeMode(ThemeMode.system);
      } else if(themeModel is DarkThemeModel) {
        Get.changeThemeMode(ThemeMode.dark);
      } else if(themeModel is LightThemeModel) {
        Get.changeThemeMode(ThemeMode.light);
      }
    }
  }

  changeTheme(ThemeModel themeModel){
    _theme.value = themeModel.name;
    Get.changeThemeMode(themeModel.mode);
    Get.find<SharedPreferences>().theme = themeModel.name;
    update();
  }

  ThemeModel get themeModel =>
      ThemeModel.themes.firstWhere((element) => element.name == _theme.value,
          orElse: () => ThemeModel.themes.first);
}