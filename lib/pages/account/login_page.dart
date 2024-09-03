import 'package:HexagonWarrior/extensions/extensions.dart';
import 'package:HexagonWarrior/pages/account/account_controller.dart';
import 'package:HexagonWarrior/pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends GetView<AccountController> {

  static const String routeName = "/login";

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();


  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'mailHintError'.tr;
    }
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'mailHintError'.tr;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    final decoration = InputDecoration(
      hintText: "mailHint".tr,
      border: OutlineInputBorder()
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("login".tr, style: Theme.of(context).textTheme.titleMedium)),
      body: Column(children: [
        Form(key: _formKey, child: Column(children: [
          TextFormField(controller: controller.emailCtrl, decoration: decoration, validator: (value) {
            return _validateEmail(value);
          }).marginOnly(top: 80),
          CupertinoButton.filled(onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _login();
          }, child: Text("login".tr)).marginOnly(top: 50)
        ]).paddingSymmetric(horizontal: 24))
      ]),
    );
  }

  _login() async{
    if (_formKey.currentState!.validate()) {
      final res = await controller.login();
      if(res.success) {
        ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text('Login successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
        Get.find<SharedPreferences>().token = "token_${controller.emailCtrl.text}";
        Get.offAllNamed(MainPage.routeName);
      } else {
        ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text('Error:'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}