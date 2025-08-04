/*
 * @Author: wangdazhuang
 * @Date: 2025-02-22 13:30:34
 * @LastEditTime: 2025-02-24 14:45:51
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/views/shi_pin/common/base/shi_pin_tag_cell.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../assets/styles.dart';
import '../../../../model/tags_model.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';

class ShiPinTagCell extends StatelessWidget {
  final TagsModel model;
  final int? selectedId;
  final VoidCallback? onTap;

  const ShiPinTagCell(this.model,
      {super.key, required this.selectedId, this.onTap});

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
          vertical: 2.w,
        ),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: selectedId == model.tagsId
            ? BoxDecoration(
                borderRadius: Styles.borderRadius.all(16.w),
                color: const Color(0xffffecf1),
                border: Border.all(
                  color: const Color(0xffff6699),
                  width: 1.w,
                ),
              )
            : BoxDecoration(
                borderRadius: Styles.borderRadius.all(16.w),
                border: Border.all(
                  color: const Color(0xffd5dade),
                  width: 1.w,
                ),
              ),
        child: Text(
          model.tagsTitle,
          style: TextStyle(
            color: selectedId == model.tagsId
                ? const Color(0xffff6699)
                : const Color(0xff676c73),
            fontSize: 13.w,
          ),
        ),
      ).onTap(onTap);
}
