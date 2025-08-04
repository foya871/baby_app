import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/tab_bar_indicator/easy_fixed_indicator.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabStrings;
  final TabController? tabController;
  final ValueChanged<int>? onTap;
  const CustomTabBar(this.tabStrings,
      {super.key, this.tabController, this.onTap});

  @override
  Widget build(BuildContext context) {
    final tabs = tabStrings.map((e) => Tab(text: e)).toList();
    final indicatorColor = Styles.color.primary;
    final fontSize = Styles.fontSize.lm;
    final unselectedColor = Styles.color.primaryText;
    final selectedStyle = TextStyle(
      color: indicatorColor,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
    final unselectedStyle = TextStyle(
      color: Colors.white,
      fontSize: fontSize,
    );
    return TabBar(
      controller: tabController,
      tabAlignment: TabAlignment.start,
      tabs: tabs,
      labelStyle: selectedStyle,
      unselectedLabelStyle: unselectedStyle,
      isScrollable: true,
      dividerHeight: 0,
      indicator: EasyFixedIndicator(
        color: indicatorColor,
        width: 10.w,
        height: 3.w,
        borderRadius: Styles.borderRadius.xs,
      ),
      indicatorPadding: EdgeInsets.only(bottom: 8.w),
      labelColor: indicatorColor,
      indicatorWeight: 1,
      labelPadding: EdgeInsets.only(right: 20.w),
      onTap: (value) => onTap?.call(value),
    );
  }
}
