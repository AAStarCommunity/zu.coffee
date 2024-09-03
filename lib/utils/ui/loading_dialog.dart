import 'package:flutter/material.dart';

import '../validate_util.dart';

class LoadingDialog extends Dialog {
  final String title;
  const LoadingDialog(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      //创建透明层
      child: Material(
        type: MaterialType.transparency, //透明类型
        child: SizedBox(
          width: 120,
          height: 120,
          child: Container(
            decoration: const ShapeDecoration(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
                if(isNotNull(title))Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}