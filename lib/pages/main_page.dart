import 'package:HexagonWarrior/pages/home/coffee_list_page.dart';
import 'package:HexagonWarrior/pages/profile/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/ui/bottom_navigation.dart';
import '../utils/ui/show_toast.dart';
import 'account/account_controller.dart';
import 'account/login_page.dart';
import 'settings/settings_page.dart';
import 'wallet/transaction_page.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/';

  MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {

  final _pageController = PageController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  _onDrawerClick(int index){
    _scaffoldKey.currentState?.closeDrawer();
    switch(index) {
      case 0:
        Get.toNamed(SettingsPage.routeName);
        break;
      case 1:
        _logout();
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }

  _logout() async{
    showLoading();
    try {
      final res = await Get.find<AccountController>().logout();
      if(res.success) {
        Get.offAllNamed(LoginPage.routeName);
      } else {
        if(mounted)showSnackMessage(res.msg);
      }
    } catch (e) {
      if(mounted)showSnackMessage(e.toString());
    } finally {
      closeLoading();
    }
  }

  @override
  void initState() {
    super.initState();
    Get.find<AccountController>().getAccountInfo();
  }

  @override
  Widget build(BuildContext context) {

    final _accountCtrl = Get.find<AccountController>();

    final _drawer = NavigationDrawer(indicatorColor: Colors.transparent, children: [
      _accountCtrl.obx(
          onError: (err) => Center(child: Text("$err")),
          onLoading: const Center(child: CircularProgressIndicator.adaptive()),
              (state) {
            return Row(children: [CircleAvatar(), Text("${state?.email}").marginOnly(left: 12)]).marginOnly(left: 24, top: 20);
          }),
      NavigationDrawerDestination(icon: Icon(Icons.manage_accounts), label: Text("settings".tr)),
      NavigationDrawerDestination(icon: Icon(Icons.logout), label: Text("logout".tr))
    ], onDestinationSelected: _onDrawerClick);

    return Scaffold(
        bottomNavigationBar: BottomNavigation(onIndexChanged: (index) {
          _pageController.jumpToPage(index);
        }),
        body: PageView(physics: NeverScrollableScrollPhysics(), controller: _pageController, children: [
          CoffeeListPage(),
          MyProfile(),
          TransactionPage()
        ]));
  }
}
