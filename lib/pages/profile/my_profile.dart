import 'package:HexagonWarrior/pages/account/account_controller.dart';
import 'package:HexagonWarrior/pages/settings/settings_page.dart';
import 'package:HexagonWarrior/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/ui/show_toast.dart';
import '../account/login_page.dart';

class MyProfile extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const SizedBox(height: 20),
      controller.obx(
          onError: (err) => Center(child: Text("$err")),
          onLoading: const Center(child: CircularProgressIndicator.adaptive()),
          (state) {
        return Column(children: [
          CircleAvatar(radius: 35, foregroundImage: AssetImage("assets/images/def_avatar.png")),
          const SizedBox(height: 24),
          Text("${state?.email}").marginOnly(left: 12, bottom: 20)
        ]).marginOnly(left: 24, top: 20);
      }),
      Stack(children: [
        ClipRRect(child: AspectRatio(aspectRatio: 2.34, child: Image.asset("assets/images/wallet_background.png", fit: BoxFit.cover, opacity: AlwaysStoppedAnimation(.2))), borderRadius: BorderRadius.circular(12)),
        Container(margin: EdgeInsets.only(left: 16, top: 16), child: Text("Balance", style: TextStyle(fontWeight: FontWeight.w600)),
            padding: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(color: Color(0xFFED5151), borderRadius: BorderRadius.circular(4))),
        Container(margin: EdgeInsets.only(left: 16, top: 44), child: Column(children: [

        ]))
      ]).marginSymmetric(horizontal: 24),
      const SizedBox(height: 30),
      LayoutBuilder(builder: (_, __) {
        final list = [
          ListTile(
              leading: Icon(Icons.manage_accounts, color: AppColors.caramelBrown),
              title: Text("settings".tr),
              onTap: () {
                Get.toNamed(SettingsPage.routeName);
              }),
          ListTile(
              leading: Icon(Icons.logout, color: AppColors.caramelBrown),
              title: Text("logout".tr),
              onTap: () {
                _logout();
              })
        ];
        return Card(margin: EdgeInsets.symmetric(horizontal: 24), child: ListView.separated(itemCount: list.length, separatorBuilder: (_, __) {
          return Divider(thickness: .1, height: 0)
              .paddingSymmetric(horizontal: 18);
        }, itemBuilder: (_, index) {
          return list[index];
        },physics: NeverScrollableScrollPhysics(), shrinkWrap: true, ), clipBehavior: Clip.hardEdge);
      }),
    ]);
  }

  _logout() async{
    showLoading();
    try {
      final res = await Get.find<AccountController>().logout();
      if(res.success) {
        Get.offAllNamed(LoginPage.routeName);
      } else {
        showSnackMessage(res.msg);
      }
    } catch (e) {
      showSnackMessage(e.toString());
    } finally {
      closeLoading();
    }
  }

}
