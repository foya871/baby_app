import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
// import 'package:tuple/tuple.dart';

import '../../../../utils/color.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/extension.dart';
import 'shi_pin_sort_layout_controller.dart';

class ShiPinSortTabBar extends StatelessWidget {
  // static const tabs = [
  //   Tuple2<String, int>('最近更新', VideoSortTypeEnum.latest),
  //   Tuple2<String, int>('最多播放', VideoSortTypeEnum.mostPlayed),
  //   Tuple2<String, int>('最多喜欢', VideoSortTypeEnum.mostFav),
  // ];

  static const tabs = [
    ('最近更新', VideoSortTypeEnum.latest),
    ('最多播放', VideoSortTypeEnum.mostPlayed),
    ('最多喜欢', VideoSortTypeEnum.mostFav),
  ];

  static int get tabsLength => tabs.length;
  static int get defaultIndex =>
      tabs.indexWhere((e) => e.$2 == VideoSortTypeEnum.latest);
  static int getSortType(int index) => tabs[index].$2;
  final TabController? tabController;
  final ShiPinSortLayoutController controller;

  const ShiPinSortTabBar(
      {super.key, required this.controller, this.tabController});

  Widget _buildTabBar() => SizedBox(
        height: 26.w,
        child: TabBar(
          tabs: tabs.map((e) => Tab(text: e.$1)).toList(),
          controller: tabController,
          dividerHeight: 0,
          indicatorColor: COLOR.transparent,
          labelStyle: TextStyle(
            color: const Color(0xff000000),
            fontWeight: FontWeight.w600,
            fontSize: 16.w,
          ),
          unselectedLabelStyle: TextStyle(
            color: const Color(0xff808080),
            fontSize: 16.w,
          ),
          indicatorPadding: EdgeInsets.zero,
          labelPadding: EdgeInsets.symmetric(horizontal: 10.5.w),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
        ),
      ).marginLeft(3.5.w);

  Widget _buildTabBarRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildTabBar()),
        // 2.horizontalSpace,
        // Obx(
        //   () => VideoLayoutButton(
        //     controller.layout.value,
        //     text: '切换',
        //     onTap: controller.toogleLayout,
        //   ),
        // )
      ],
    ).baseMarginR;
  }

  @override
  Widget build(BuildContext context) => _buildTabBarRow();
}
