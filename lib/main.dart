import 'package:HexagonWarrior/pages/account/account_controller.dart';
import 'package:HexagonWarrior/utils/log/lk_log_output.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => GetMaterialApp(
          title: "HexagonWarrior",
          initialBinding: BindingsBuilder(() async{
            Get.put(ThemeController());
            Get.put(AccountController());
          }),
          navigatorKey: Get.key,
          navigatorObservers: [GetObserver()],
          getPages: routes,
          initialRoute: MainPage.routeName,
          themeMode: ThemeMode.system,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
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
          locale: AppTranslations.locale,//Get.deviceLocale,//const Locale('zh', 'CN'),
          fallbackLocale: AppTranslations.fallbackLocale,
        ));
  }
}