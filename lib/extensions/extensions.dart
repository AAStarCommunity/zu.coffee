import 'package:shared_preferences/shared_preferences.dart';

extension SpExt on SharedPreferences{

  set theme(v) => setString("theme", v);

  String? get theme => getString("theme");


  set token(v) => setString("token", v);

  String? get token => getString("token");

}