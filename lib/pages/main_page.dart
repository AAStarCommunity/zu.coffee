import 'package:HexagonWarrior/pages/account/account_controller.dart';
import 'package:HexagonWarrior/pages/account/login_page.dart';
import 'package:HexagonWarrior/pages/qrcode/qrcode_page.dart';
import 'package:HexagonWarrior/pages/settings/settings_page.dart';
import 'package:HexagonWarrior/utils/ui/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/';

  MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {

  int _pageIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _onDrawerClick(int index){
    _scaffoldKey.currentState?.closeDrawer();
    switch(index) {
      case 0:
        break;
      case 1:
        Get.toNamed(SettingsPage.routeName);
        break;
      case 2:
        _logout();
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
        if(mounted)showSnackMessage(context, res.msg);
      }
    } catch (e) {
      if(mounted)showSnackMessage(context, e.toString());
    } finally {
      closeLoading();
    }
  }

  @override
  Widget build(BuildContext context) {

    final drawer = NavigationDrawer(indicatorColor: Colors.transparent, children: [
      NavigationDrawerDestination(icon: CircleAvatar(), label: Text("Nick Name")),
      NavigationDrawerDestination(icon: Icon(Icons.manage_accounts), label: Text("settings".tr)),
      NavigationDrawerDestination(icon: Icon(Icons.logout), label: Text("logout".tr))
    ], onDestinationSelected: _onDrawerClick);
    return Scaffold(
        key: _scaffoldKey,
        drawer: drawer,
        appBar: AppBar(actions: [
          IconButton(onPressed: (){
            Get.toNamed(QRCodePage.routeName);
          }, icon: Icon(CupertinoIcons.camera_viewfinder))
        ]),
        body: Column(children: [
         ElevatedButton(onPressed: () async{

           // final authenticator = Authenticator(true, true);
           // final attestation = await authenticator.makeCredential(MakeCredentialOptions(
           //     clientDataHash: clientDataHash,
           //     rpEntity: rpEntity,
           //     userEntity: userEntity,
           //     requireResidentKey: requireResidentKey,
           //     requireUserPresence: requireUserPresence,
           //     requireUserVerification: requireUserVerification,
           //     credTypesAndPubKeyAlgs: credTypesAndPubKeyAlgs));
           // attestation.asCBOR();

         }, child: Text("test"))
        ]),
        bottomNavigationBar: BottomNavigationBar(currentIndex: _pageIndex, items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: "账户"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: "账单"
          ),
        ], onTap: (index) {
            if(mounted)setState(() {
              _pageIndex = index;
            });
        }));
  }

  _buildAccount() {

  }

  _buildTransaction() {

  }
}
