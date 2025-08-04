import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../utils/color.dart';
import '../tab_bar_indicator/easy_fixed_indicator.dart';

class TabBarFilter extends StatefulWidget {
  final List<String>? tabs;
  final List<Widget> children;
  final ScrollPhysics physics;
  final Color? backgroundColor;
  final TabAlignment tabAlignment;
  final List<Size>? tabBarSize;
  final EdgeInsets? tabBarPadding;
  final bool enableSlide;
  final double? bodyPaddingTop;
  final TabController? tabController;
  final ValueCallback<int>? onTabIndexChange;

  const TabBarFilter({
    super.key,
    this.tabs,
    required this.children,
    this.physics = const NeverScrollableScrollPhysics(),
    this.backgroundColor,
    this.tabAlignment = TabAlignment.start,
    this.tabBarSize,
    this.tabBarPadding,
    this.enableSlide = false,
    this.bodyPaddingTop = 0,
    this.tabController,
    this.onTabIndexChange,
  });

  @override
  State<TabBarFilter> createState() => _TabBarFilterState();
}

class _TabBarFilterState extends State<TabBarFilter>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  var tabIndex = 0.obs;

  ///默认筛选
  List<String> tabsFilter = [
    "推荐",
    "最新",
    "排行榜",
  ];

  void tabIndexChangeListener() =>
      widget.onTabIndexChange?.call(tabController.index);

  @override
  void initState() {
    super.initState();
    tabController = widget.tabController ??
        TabController(
          length: widget.tabs?.length ?? tabsFilter.length,
          vsync: this,
        );
    tabController.addListener(tabIndexChangeListener);
  }

  @override
  void dispose() {
    tabController.removeListener(tabIndexChangeListener);
    if (widget.tabController == null) {
      tabController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: TabBar(
        controller: tabController,
        physics: widget.physics,
        isScrollable: true,
        dividerHeight: 0,
        tabAlignment: widget.tabAlignment,
        onTap: (index) {
          tabIndex.value = index;
        },
        indicatorWeight: 0,
        indicatorColor: COLOR.transparent,
        indicator: const EasyFixedIndicator(width: 0),
        padding: widget.tabBarPadding ?? EdgeInsets.only(right: 20.w),
        labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
        tabs: (widget.tabs ?? tabsFilter).mapIndexed(
          (index, e) {
            return Obx(
              () {
                return Container(
                  width: widget.tabBarSize == null
                      ? 55.w
                      : widget.tabBarSize![index].width,
                  height: widget.tabBarSize == null
                      ? 30.w
                      : widget.tabBarSize![index].height,
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage(tabIndex.value == index
                  //         ? AppImagePath.community_tab_selected
                  //         : AppImagePath.community_transparent),
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 6.w),
                  child: Text(
                    e,
                    style: TextStyle(
                      // color: tabIndex.value == index
                      //     ? COLOR.color_1a1d29
                      //     : COLOR.color_d3d3d3,
                      fontSize: 15.w,
                    ),
                  ),
                );
              },
            );
          },
        ).toList(),
      ),
      body: widget.children.isNotEmpty
          ? Padding(
              padding: EdgeInsets.only(top: widget.bodyPaddingTop!.w),
              child: TabBarView(
                  controller: tabController,
                  physics: !widget.enableSlide
                      ? const NeverScrollableScrollPhysics()
                      : null,
                  children: widget.children),
            )
          : null,
    );
  }
}
