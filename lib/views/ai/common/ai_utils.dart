import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../assets/styles.dart';
import '../../../components/easy_button.dart';
import '../../../utils/color.dart';

abstract class AiUtils {
  static Widget buildUploadButton({required VoidCallback onTap}) => EasyButton(
        '上传',
        width: double.infinity,
        height: 42.w,
        borderRadius: Styles.borderRadius.all(10.w),
        textStyle: TextStyle(
          color: COLOR.white,
          fontSize: 15.w,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: COLOR.color_B940FF,
        onTap: onTap,
      );

  static Widget buildMakeButton({required VoidCallback onTap}) => EasyButton(
        '立即制作',
        width: 96.w,
        height: 38.w,
        borderRadius: Styles.borderRadius.all(30.w),
        textStyle: TextStyle(
          color: COLOR.white,
          fontSize: 15.w,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: COLOR.themeSelectedColor,
        onTap: onTap,
      );
}
