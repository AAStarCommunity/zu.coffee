import 'package:HexagonWarrior/pages/account/login_page.dart';
import 'package:HexagonWarrior/pages/account/register_page.dart';
import 'package:HexagonWarrior/pages/qrcode/qrcode_page.dart';
import 'package:HexagonWarrior/pages/settings/settings_page.dart';
import 'package:HexagonWarrior/routes/global_auth_middleware.dart';
import 'package:get/get.dart';
import '../pages/main_page.dart';
import '../pages/qrcode/scan_result_page.dart';
import '../pages/wallet/wallet_page.dart';
import '../theme/change_language_page.dart';
import '../theme/change_theme_page.dart';

final routes = <GetPage>[
  GetPage(name: LoginPage.routeName, page: () => LoginPage()),
  GetPage(name: RegisterPage.routeName, page: () => RegisterPage()),
  GetPage(name: MainPage.routeName, page: () => MainPage(), middlewares: [
    GlobalAuthMiddleware()
  ]),
  GetPage(name: SettingsPage.routeName, page: () => SettingsPage()),
  GetPage(name: QRCodePage.routeName, page: () => QRCodePage()),
  GetPage(name: ScanResultPage.routeName, page: () => ScanResultPage()),
  GetPage(name: WalletPage.routeName, page: () => WalletPage()),
  GetPage(name: ChangeThemePage.routeName, page: () => ChangeThemePage()),
  GetPage(name: ChangeLanguagePage.routeName, page: () => ChangeLanguagePage())
];