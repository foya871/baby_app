import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../assets/styles.dart';
import '../../generate/app_image_path.dart';
import '../../routes/routes.dart';
import '../../utils/color.dart';

class SearchEntryCell extends StatelessWidget {
  final int searchType;

  const SearchEntryCell({super.key, required this.searchType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.w,
      decoration: BoxDecoration(
        color: COLOR.color_1D1D1D,
        borderRadius: Styles.borderRadius.all(16.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          Image.asset(
            AppImagePath.app_default_search,
            width: 16.w,
            height: 16.w,
          ),
          10.horizontalSpace,
          Text(
            '请输入搜索内容',
            style: TextStyle(
              color: COLOR.color_898A8E,
              fontSize: 12.w,
            ),
          ),
        ],
      ),
    ).onTap(() {
      Get.toSearchPage(classifyId: 1);
    });
  }
}
