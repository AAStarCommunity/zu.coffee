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

}