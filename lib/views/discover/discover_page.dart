import 'package:baby_app/utils/extension.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/discover/activity_center/activity_center_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../utils/color.dart';
import 'free_reward/free_reward_view.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  var tabIndex = 0;
  List<String> tabs = ['免费福利', '活动中心'];

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: tabIndex);
    tabController.addStableListener((index) {
      tabIndex = index;
      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _buildTabBar(),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          FreeRewardPage(),
          ActivityCenterPage(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: tabController,
      tabs: tabs
          .map((v) => Tab(
                text: v,
              ))
          .toList(),
      isScrollable: true,
      tabAlignment: TabAlignment.center,
      // labelPadding: EdgeInsets.zero,
      labelStyle: TextStyle(
          fontSize: 17.w, fontWeight: FontWeight.w600, color: COLOR.white),
      unselectedLabelStyle: TextStyle(
          fontSize: 17.w,
          fontWeight: FontWeight.w600,
          color: COLOR.white.withValues(alpha: 0.6)),
      indicator:
          EasyFixedIndicator(color: COLOR.transparent, width: 0.w, height: 0.w),
      dividerHeight: 0,
    );
  }
}
