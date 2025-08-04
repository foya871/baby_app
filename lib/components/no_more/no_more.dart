/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-27 14:22:17
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-10-09 09:12:51
 * @FilePath: /baby_app/lib/src/components/no_more/no_more.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/utils/color.dart';

class NoMore extends StatelessWidget {
  const NoMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: 340.w,
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: Text(
          '没有更多了',
          style: TextStyle(color: COLOR.hexColor('#ffffff'), fontSize: 14.w),
        ));
  }
}
