/*
 * @Author: wangdazhuang
 * @Date: 2025-02-17 15:01:29
 * @LastEditTime: 2025-02-20 15:42:48
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/components/no_more/no_data_candom.dart
 */
import 'package:flutter/widgets.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/utils/color.dart';

class NoDataCandom extends StatelessWidget {
  const NoDataCandom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(AppImagePath.app_default_empty, width: 100.w),
        12.verticalSpaceFromWidth,
        Text(
          '空空如也～～～',
          style: TextStyle(
            color: COLOR.color_999999,
            fontSize: 14.w,
          ),
        ),
      ],
    );
  }
}
