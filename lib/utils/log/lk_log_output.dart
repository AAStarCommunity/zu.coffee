import 'package:HexagonWarrior/utils/log/pretty_logger.dart';
import 'package:logger/logger.dart';

class LKLogOutPut extends LogOutput{

  PrettyLogger printer = PrettyLogger();

  @override
  void output(OutputEvent event) {
    event.lines?.forEach((obj){
       printer.printResponse(obj);
    });
  }

}