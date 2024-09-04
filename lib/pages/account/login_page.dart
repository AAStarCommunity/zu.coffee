import 'dart:async';
import 'package:HexagonWarrior/pages/account/account_controller.dart';
import 'package:HexagonWarrior/pages/main_page.dart';
import 'package:HexagonWarrior/utils/ui/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:webauthn/webauthn.dart';

import '../../utils/validate_util.dart';


class LoginPage extends StatefulWidget {
  static const String routeName = "/login";

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }

}

class _LoginPageState extends State<LoginPage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _pinCodeFormKey = GlobalKey<FormState>();

  TextEditingController _emailCtrl = TextEditingController(text: kDebugMode ? "pinoyscavenger@h0tmal.com" : "");
  StreamController<ErrorAnimationType> _errorCtrl = StreamController<ErrorAnimationType>();
  TextEditingController _pinCodeCtrl = TextEditingController(text: kDebugMode ? "111111" : "");

  bool _pinCodeVisible = kDebugMode;

  String? _validatePinCode(String? v) {
    if (v == null || v.length < 6) {
      return "complete_pin_code".tr;
    } else {
      return null;
    }
  }

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
  void initState() {
    super.initState();
    _emailCtrl.addListener(() {
      if(mounted && !isNotNull(_emailCtrl.text)) setState(() {
        _pinCodeVisible = false;
      });
    });
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    // _pinCodeCtrl.dispose();
    _errorCtrl.close();
    super.dispose();
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
        Column(children: [
          Form(key: _emailFormKey, child: TextFormField(controller: _emailCtrl, decoration: decoration, validator: (value) {
            return _validateEmail(value);
          }).marginOnly(top: 80)),
          if(_pinCodeVisible)Form(key: _pinCodeFormKey, child: PinCodeTextField(
            appContext: context,
            // pastedTextStyle: TextStyle(
            //   color: Colors.green.shade600,
            //   fontWeight: FontWeight.bold,
            // ),
            length: 6,
            obscureText: true,
            obscuringCharacter: '*',
            // obscuringWidget: const FlutterLogo(
            //   size: 24,
            // ),
            blinkWhenObscuring: true,
            animationType: AnimationType.fade,
            validator: _validatePinCode,
            cursorColor: Theme.of(context).colorScheme.inverseSurface,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(4),
              fieldHeight: 50,
              fieldWidth: 40,
              // activeColor:,
              // selectedColor:,
              // inactiveColor:,
              activeColor: Theme.of(context).colorScheme.onSecondaryFixed,
              selectedColor: Theme.of(context).colorScheme.onSecondary,
              inactiveColor: Theme.of(context).colorScheme.onSecondaryFixed,
              activeFillColor: Theme.of(context).colorScheme.onSecondaryFixed,
              selectedFillColor: Theme.of(context).colorScheme.onSecondary,
              inactiveFillColor: Theme.of(context).colorScheme.onSecondaryFixed,
            ),
            // cursorColor: Colors.black,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            errorAnimationController: _errorCtrl,
            controller: _pinCodeCtrl,
            errorTextMargin: EdgeInsets.only(left: 12),
            errorTextSpace: 24,
            keyboardType: TextInputType.text,
            // boxShadows: const [
            //   BoxShadow(
            //     offset: Offset(0, 1),
            //     color: Colors.black12,
            //     blurRadius: 10,
            //   )
            // ],
            // onCompleted: (v) {
            //   debugPrint("Completed");
            // },
            // onTap: () {
            //   print("Pressed");
            // },
            // onChanged: (value) {
            //
            // },
            // beforeTextPaste: (text) {
            //   debugPrint("Allowing to paste $text");
            //   return true;
            // },
          ).marginOnly(top: 24)),
          CupertinoButton.filled(onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _login();
          }, child: Text("login".tr)).marginOnly(top: 50),
          TextButton(onPressed: (){}, child: Center(child: Text("还有没有账号，去注册")))
        ]).paddingSymmetric(horizontal: 24)
      ]),
    );
  }

  _login() async{
    try {
      showLoading();
      final controller = Get.find<AccountController>();
      if(_pinCodeVisible) {
        if(_pinCodeFormKey.currentState!.validate() && _emailFormKey.currentState!.validate()) {
          final res = await controller.register(_emailCtrl.text, captcha: _pinCodeCtrl.text);
          if(res.success) {
            Get.offAllNamed(MainPage.routeName);
          } else {
            _snackMessage(res.msg);
          }
        }
      } else {
        if (_emailFormKey.currentState!.validate()) {

          final res = await controller.prepare(_emailCtrl.text);
          if(res.success) {
            toast("codeSent".tr);
            if(mounted) {
              setState(() {
                _pinCodeVisible = true;
              });
            }
            // ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
            //   SnackBar(
            //     content: Text('Login successfully!'),
            //     duration: Duration(seconds: 2),
            //   ),
            // );
            // Get.find<SharedPreferences>().token = "token_${_emailCtrl.text}";
            // Get.offAllNamed(MainPage.routeName);
          } else {
            _snackMessage(res.msg);
          }
        }
      }
    } catch(e) {
      if(e is GetAssertionException) {

      } else {
        _snackMessage(e.toString());
      }
    } finally {
      closeLoading();
    }
  }

  _snackMessage(String message) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text('Error: ${message}'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}