/*
 * @Author: wangdazhuang
 * @Date: 2024-10-16 15:09:03
 * @LastEditTime: 2025-06-12 10:56:43
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /pornhub_app/lib/http/service/special_code_pop.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../assets/styles.dart';
import '../../components/easy_button.dart';
import '../../utils/color.dart';

class SpecialCodePop extends StatelessWidget {
  final String? title;
  final String desc;
  final VoidCallback tap;
  const SpecialCodePop({
    super.key,
    this.title,
    required this.desc,
    required this.tap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 55.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: COLOR.hexColor('#F0F0F0')))),
            child: Text(
              "温馨提示",
              style: kTextStyle(
                Colors.black,
                fontsize: 16.w,
                weight: FontWeight.bold,
              ),
            ),
          ),
          15.verticalSpaceFromWidth,
          Text(title ?? '',
              textAlign: TextAlign.center,
              style: kTextStyle(COLOR.color_666666, fontsize: 15.w)),
          18.verticalSpaceFromWidth,
          SizedBox(
              width: 250.w,
              child: Text(desc,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: kTextStyle(COLOR.color_666666, fontsize: 15.w))),
          20.verticalSpaceFromWidth,
          EasyButton(
            '确定',
            textStyle: kTextStyle(Colors.white,
                fontsize: 16.w, weight: FontWeight.bold),
            width: 250.w,
            height: 36.w,
            borderRadius: BorderRadius.circular(18.w),
            backgroundColor: COLOR.hexColor("#F84242"),
            onTap: () => tap.call(),
          ),
          20.verticalSpaceFromWidth,
        ],
      ),
    );
  }
}
