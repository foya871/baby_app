import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/app_bg_view.dart';
import '../../../utils/color.dart';
import '../../../utils/enum.dart';

class VideoFilterView extends StatelessWidget {
  var role = VideoRuleType.complex.obs;
  var duration = FilterVideoLongType.noLimit.obs;

  late Function onTap;

  VideoFilterView(
      VideoRuleType roleValue, FilterVideoLongType durationValue, this.onTap,
      {super.key}) {
    role.value = roleValue;
    duration.value = durationValue;
  }

  var roles = VideoRuleType.values;
  var durations = FilterVideoLongType.values;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 253.w,
      width: 1.sw,
      color: COLOR.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "排序规则",
                      style:
                          TextStyle(fontSize: 14.w, color: COLOR.color_8e8e93),
                    ),
                    5.verticalSpace,
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 10.w,
                      children:
                          roles.map((v) => buildOption(v.title, true)).toList(),
                    ),
                    5.verticalSpace,
                    Text(
                      "视频时长",
                      style:
                          TextStyle(fontSize: 14.w, color: COLOR.color_8e8e93),
                    ),
                    5.verticalSpace,
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 10.w,
                      children: durations
                          .map((v) => buildOption(v.title, false))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: AppBgView(
                  text: '重置',
                  textSize: 14.w,
                  textColor: COLOR.color_8e8e93,
                  backgroundColor: COLOR.color_f3f5f8,
                  height: 40.h,
                  onTap: () {
                    role.value = VideoRuleType.complex;
                    duration.value = FilterVideoLongType.noLimit;
                  },
                ),
              ),
              Expanded(
                child: AppBgView(
                  text: '确定',
                  textSize: 14.w,
                  textColor: COLOR.white,
                  backgroundColor: COLOR.color_63d2ff,
                  height: 40.h,
                  onTap: () {
                    onTap.call(role.value, duration.value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOption(String v, bool isRole) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          var selected = role.value.title == v || duration.value.title == v;
          return AppBgView(
            text: v,
            textSize: 14.w,
            textColor: selected ? COLOR.color_63d2ff : COLOR.color_8e8e93,
            // margin: EdgeInsets.only(left: 15.w),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.w),
            backgroundColor: selected ? COLOR.white : COLOR.color_f3f5f8,
            borderRadius: BorderRadius.circular(13.w),
            border: Border.all(
                color: selected ? COLOR.color_63d2ff : COLOR.color_f3f5f8,
                width: 1.w),
          );
        }),
      ],
    ).onTap(() {
      if (isRole) {
        role.value = VideoRuleType.fromTitle(v);
      } else {
        duration.value = FilterVideoLongType.fromTitle(v);
      }
    });
  }
}
