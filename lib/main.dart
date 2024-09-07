import 'dart:io';

import  'package:HexagonWarrior/pages/account/account_controller.dart';
import 'package:HexagonWarrior/theme/app_colors.dart';
import 'package:HexagonWarrior/utils/log/lk_log_output.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/main_page.dart';
import 'routes/routes.dart';
import 'theme/theme_model.dart';
import 'translations/translations.dart';

var logger = Logger(
    filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
    printer: PrettyPrinter(),
    output: LKLogOutPut()
);

var loggerNST = Logger(
    filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
    printer: PrettyPrinter(methodCount: 0),
    output: LKLogOutPut()
);

void main() async{
  await ScreenUtil.ensureScreenSize();
  await Get.putAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  }, permanent: true);

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent
    ));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    ThemeData lightTheme = ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.caramelBrown,
        onPrimary: AppColors.ivoryWhite,
        secondary: AppColors.softPeach,
        onSecondary: AppColors.charcoalGrey,
        surface: AppColors.lightSilver,
        onSurface: AppColors.charcoalGrey,
        error: Colors.red,
        onError: AppColors.ivoryWhite,
        background: AppColors.ivoryWhite,
        onBackground: AppColors.charcoalGrey,
      ),
      scaffoldBackgroundColor: AppColors.ivoryWhite,
      textTheme: TextTheme(
        headlineLarge: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: AppColors.darkText),
        titleMedium: TextStyle(color: AppColors.mediumText),
        titleSmall: TextStyle(color: AppColors.mediumText),
        bodyLarge: TextStyle(color: AppColors.mediumText),
        bodyMedium: TextStyle(color: AppColors.mediumText),
        bodySmall: TextStyle(color: AppColors.lightText),
        labelLarge: TextStyle(color: AppColors.darkText),
        labelMedium: TextStyle(color: AppColors.mediumText),
        labelSmall: TextStyle(color: AppColors.lightText),
      ),
    );

    ThemeData darkTheme = ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.caramelBrown,
        onPrimary: AppColors.ivoryWhite,
        secondary: AppColors.softPeach,
        onSecondary: AppColors.charcoalGrey,
        surface: AppColors.charcoalGrey,
        onSurface: AppColors.ivoryWhite,
        error: Colors.red,
        onError: AppColors.ivoryWhite,
        background: Color(0xFF1E1E1E),
        onBackground: AppColors.ivoryWhite,
      ),
      scaffoldBackgroundColor: Color(0xFF1E1E1E),
      textTheme: TextTheme(
        headlineLarge: TextStyle(color: AppColors.ivoryWhite, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: AppColors.ivoryWhite, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(color: AppColors.ivoryWhite, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: AppColors.ivoryWhite),
        titleMedium: TextStyle(color: AppColors.lightSilver),
        titleSmall: TextStyle(color: AppColors.lightSilver),
        bodyLarge: TextStyle(color: AppColors.lightSilver),
        bodyMedium: TextStyle(color: AppColors.lightSilver),
        bodySmall: TextStyle(color: AppColors.softPeach),
        labelLarge: TextStyle(color: AppColors.ivoryWhite),
        labelMedium: TextStyle(color: AppColors.lightSilver),
        labelSmall: TextStyle(color: AppColors.softPeach),
      ),
    );

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => GetMaterialApp(
          title: "Zu.Coffee",
          initialBinding: BindingsBuilder(() async{
            Get.put(ThemeController());
            Get.put(AccountController());
          }),
          navigatorKey: Get.key,
          navigatorObservers: [GetObserver()],
          getPages: routes,
          initialRoute: MainPage.routeName,
          themeMode: ThemeMode.dark,
          theme: lightTheme.copyWith(useMaterial3: true),
          darkTheme: darkTheme.copyWith(useMaterial3: true),
          builder: EasyLoading.init(builder: (ctx, child){
            EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ring;
            return GestureDetector(
                onTap: () {
                  FocusScopeNode focus = FocusScope.of(context);
                  if (!focus.hasPrimaryFocus &&
                      focus.focusedChild != null) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  }
                },
                child: MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
                  child: child!,
                ));
          }),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          translations: AppTranslations(),
          supportedLocales: AppTranslations.supportedLocales,
          locale: AppTranslations.locale ?? Get.deviceLocale,//const Locale('zh', 'CN'),
          fallbackLocale: AppTranslations.fallbackLocale,
        ));
  }
}