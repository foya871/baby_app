import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context, String content) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoadingDialog(content);
      });
}

void closeDialog(BuildContext context) {
  Navigator.pop(context);
}

class LoadingDialog extends Dialog {
  final String text;

  const LoadingDialog(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: SizedBox(
          width: 150.0,
          height: 150.0,
          child: Container(
            decoration: const ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CircularProgressIndicator(
                  strokeWidth: 2.0,
                  backgroundColor: Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.black, fontSize: 14.0),
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
