/*
 * @Author: wdz
 * @Date: 2025-04-28 17:38:16
 * @LastEditTime: 2025-06-27 20:23:38
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/components/search_title_view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../generate/app_image_path.dart';
import '../services/app_service.dart';
import 'image_view.dart';

class SearchTitleView extends StatefulWidget {
  const SearchTitleView({super.key});

  @override
  State<SearchTitleView> createState() => _SearchTitleViewState();
}

class _SearchTitleViewState extends State<SearchTitleView> {
  final appService = Get.find<AppService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.w,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: [
          Expanded(child: _buildSearchView()),
          10.horizontalSpace,
        ],
      ),
    );
  }

  _buildSearchView() {
    return AppBgView(
      height: 32.w,
      radius: 16.w,
      backgroundColor: COLOR.color_f3f5f8,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      onTap: () => Get.toSearchPage(classifyId: 0),
      child: Row(
        children: [
          ImageView(
            src: AppImagePath.app_default_placeholder,
            width: 15.r,
          ),
          10.horizontalSpace,
        ],
      ),
    );
  }
}
