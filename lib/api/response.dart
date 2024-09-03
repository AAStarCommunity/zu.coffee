import 'package:intl/intl.dart';

import '../utils/validate_util.dart';


class HttpResult {
  int? _code;
  dynamic data;
  String? _msg;
  String? time;

  String get msg => _msg ?? "error";
  int get code => _code ?? -1;

  HttpResult();

  HttpResult.error(int code, String _msg) {
    _code = _code;
    this._msg = _msg;
    data = {};
  }

  HttpResult.fromJson(Map<String, dynamic> json){
    if(isNotNull('${json['code']}'))_code = int.parse('${json['code']}');
    data = json['data'];
    _msg = json['msg'] ?? json['message'];
    if(isNotNull(json['time'])){
      time = DateFormat("yyyy-MM-dd HH:mm:ssss")
          .format(DateTime.fromMillisecondsSinceEpoch(
          int.parse('${json['time']}')).toLocal());
    }else{
      time = DateFormat("yyyy-MM-dd HH:mm:ssss").format(DateTime.now().toLocal());
    }
  }

  HttpResult.success(int code, String msg, this.data) {
    _code = code;
    _msg = msg;
  }

  bool get success {
    return _code == 1 || _code == 200;
  }

  @override
  String toString() {
    return 'HttpResult{_code: $_code, data: $data, _msg: $_msg, time: $time}';
  }
}

class VoidModel extends HttpResult{

  VoidModel.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
