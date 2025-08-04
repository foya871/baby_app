/*
 * @Author: wangdazhuang
 * @Date: 2025-03-14 11:42:18
 * @LastEditTime: 2025-03-14 15:23:09
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /yuseman_app/lib/common/components/tab_bar/easy_tab_bar.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/utils/color.dart';

class EasyTabBar extends StatelessWidget {
  final TabController? tabController;
  final List<Tab> tabs;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color? labelColor;
  final Color? indicatorColor;
  final bool isScrollable;
  final ScrollPhysics? physics;
  final double? paddingOnlyRight;

  const EasyTabBar({
    super.key,
    this.tabController,
    required this.tabs,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.labelColor,
    this.indicatorColor,
    this.isScrollable = true,
    this.physics,
    this.paddingOnlyRight,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: isScrollable,
      physics: physics,
      dividerHeight: 0,
      tabAlignment: TabAlignment.start,
      labelStyle: labelStyle ??
          TextStyle(
            // color: COLOR.color_ffe585,
            fontSize: 16.w,
            fontWeight: FontWeight.w600,
          ),
      unselectedLabelStyle: unselectedLabelStyle ??
          TextStyle(
            // color: COLOR.color_d3d3d3,
            fontSize: 15.w,
          ),
      // indicator: EasyBezierIndicator(
      //   color: indicatorColor ?? COLOR.color_ffe585,
      // ),
      indicatorPadding: EdgeInsets.only(bottom: 10.w),
      // labelColor: labelColor ?? COLOR.color_ffe585,
      indicatorWeight: 1,
      padding: EdgeInsets.only(right: paddingOnlyRight ?? 15.w),
      labelPadding: EdgeInsets.symmetric(horizontal: 7.w),
      tabs: tabs,
    );
  }
}
