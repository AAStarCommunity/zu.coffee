import 'package:HexagonWarrior/pages/account/account_controller.dart';
import 'package:HexagonWarrior/pages/account/login_page.dart';
import 'package:HexagonWarrior/pages/qrcode/qrcode_page.dart';
import 'package:HexagonWarrior/pages/settings/settings_page.dart';
import 'package:HexagonWarrior/utils/ui/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _accountCtrl = Get.find<AccountController>();

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
        if(mounted)showSnackMessage(context, res.msg);
      }
    } catch (e) {
      if(mounted)showSnackMessage(context, e.toString());
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
    final drawer = NavigationDrawer(indicatorColor: Colors.transparent, children: [
      _accountCtrl.obx(
          onError: (err) => Center(child: Text("$err")),
          onLoading: const Center(child: CircularProgressIndicator.adaptive()),
              (state) {
            return Row(children: [CircleAvatar(), Text("${state?.email}").marginOnly(left: 12)]).marginOnly(left: 24, top: 20);
          }),
      NavigationDrawerDestination(icon: Icon(Icons.manage_accounts), label: Text("settings".tr)),
      NavigationDrawerDestination(icon: Icon(Icons.logout), label: Text("logout".tr))
    ], onDestinationSelected: _onDrawerClick);

    final buttonStyle = ButtonStyle(shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))));

    return Scaffold(
        key: _scaffoldKey,
        drawer: drawer,
        appBar: AppBar(actions: [
          IconButton(onPressed: (){
            Get.toNamed(QRCodePage.routeName);
          }, icon: Icon(CupertinoIcons.camera_viewfinder))
        ]),
        body: _accountCtrl.obx(
            onError: (err) => Center(child: Text("$err")),
            onLoading: const Center(child: CircularProgressIndicator.adaptive()),
            (state) {
              return Column(children: [
                Row(children: [
                  Text("${state?.aa}"),
                  IconButton(onPressed: (){
                    Clipboard.setData(ClipboardData(text: "${state?.aa}")).then((_) => showSnackMessage(context, "Successfully"));
                  }, icon: Icon(Icons.content_copy))
                ]),
                const SizedBox(height: 20),
                _buildSection(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text("USDT Balance", style: Theme.of(context).textTheme.titleMedium),
                    Spacer(),
                    Text("\$0", style: Theme.of(context).textTheme.titleLarge)
                  ]),
                  const SizedBox(height: 20),
                  Wrap(spacing: 12, children: [
                    FilledButton(onPressed: (){}, child: Text("Mint"), style: buttonStyle),
                    FilledButton(onPressed: (){}, child: Text("Send"), style: buttonStyle),
                    FilledButton(onPressed: (){}, child: Text("Mint USDT And Mint NFT"), style: buttonStyle)
                  ]),
                ])),
                const SizedBox(height: 20),
                _buildSection(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text("NFT List", style: Theme.of(context).textTheme.titleMedium),
                    Spacer(),
                    Text("\$0", style: Theme.of(context).textTheme.titleLarge)
                  ]),
                  const SizedBox(height: 20),
                  FilledButton(onPressed: (){}, child: Text("Mint"), style: buttonStyle)
                ]))
              ]);
            }),
        bottomNavigationBar: BottomNavigationBar(currentIndex: _pageIndex, items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: "account".tr
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: "transaction".tr
          ),
        ], onTap: (index) {
            if(mounted)setState(() {
              _pageIndex = index;
            });
        }));
  }

  _buildSection(Widget child) {
    return Container(
        padding: EdgeInsets.all(16),
        width: context.width,
        clipBehavior: Clip.hardEdge, decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surfaceContainerHigh),
        child: child).marginSymmetric(horizontal: 24);
  }

  _buildAccount() {

  }

  _buildTransaction() {

  }
}
