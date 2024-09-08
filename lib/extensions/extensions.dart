import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../utils/validate_util.dart';

extension SpExt on SharedPreferences{

  set theme(v) {
    if(isNotNull(v)) {
      setString("theme", v);
    } else {
      remove("theme");
    }
  }

  String? get theme => getString("theme");


  set token(v) {
    if(isNotNull(v)) {
      setString("token", v);
    } else {
      remove("token");
    }
  }

  String? get token => getString("token");


  set language(v) {
    if(isNotNull(v)) {
      setString("language", v);
    } else {
      remove("language");
    }
  }

  String? get language => getString("language");

  saveTransactionHash(String userOpHash, transactionHash) {
    final key = "transaction";
    final transactions = getString(key);
    if(isNotNull(transactions)) {
      final obj = jsonDecode(transactions!);
      obj[userOpHash] = "${transactionHash}_${DateTime.now().toUtc().toString()}";
      setString(key, jsonEncode(obj));
    } else {
      final kv = <String, dynamic>{"${userOpHash}": transactionHash};
      setString(key, jsonEncode(kv));
    }
  }

  Map<String, dynamic> getTransactionHashes() {
    final key = "transaction";
    final transactions = getString(key);
    if(isNotNull(transactions)) {
      return jsonDecode(transactions!);
    } else {
      return <String, dynamic>{};
    }
  }
}

extension StringExt on String {

  String trimTrailingZeros() {

    String number = this;

    // 如果字符串不包含小数点，直接返回
    if (!number.contains('.')) {
      return number;
    }

    // 去掉末尾的零
    number = number.replaceAll(RegExp(r'0+$'), '');

    // 如果小数点成为了最后一个字符，去掉它
    if (number.endsWith('.')) {
      number = number.substring(0, number.length - 1);
    }

    return number;
  }
}