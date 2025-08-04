import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/utils/color.dart';

class DialogAlert extends StatelessWidget {
  final String title;
  final TextStyle? titleTextStyle;
  final String message;
  final AlignmentGeometry? contentAlignment;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  DialogAlert({
    required this.title,
    required this.message,
    this.titleTextStyle,
    this.contentAlignment,
    this.confirmButtonText = '确认',
    this.cancelButtonText = '取消',
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          title,
          style: titleTextStyle ??
              TextStyle(
                fontSize: 16.w,
                fontWeight: FontWeight.w800,
                color: COLOR.black,
              ),
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          alignment: contentAlignment ?? Alignment.center,
          child: Text(
            message,
            style: TextStyle(
              color: COLOR.color_333333,
              fontSize: 14.w,
            ),
          ),
        ),
      ),
      actions: [
        Container(
          // color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 均分
            children: [
              TextButton(
                onPressed: () {
                  onCancel();
                  Navigator.of(context).pop();
                },
                child: Text(
                  cancelButtonText,
                  style: TextStyle(
                    fontSize: 16.w,
                    color: COLOR.color_4490F8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: 1.w,
                height: 23.h,
                color: COLOR.color_F0F0F0,
              ),
              TextButton(
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
                child: Text(
                  confirmButtonText,
                  style: TextStyle(
                    fontSize: 16.w,
                    color: COLOR.color_F40302,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.w), // 设置圆角
      ),
      backgroundColor: Colors.white,
    );
  }
}
