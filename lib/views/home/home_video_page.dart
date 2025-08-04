import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/home/widget/home_navigation_menu.dart';

import '../../components/image_view.dart';
import '../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../generate/app_image_path.dart';
import '../../utils/color.dart';
import 'home_common/home_common_page.dart';
import 'home_controller.dart';
import 'home_forbidden/home_forbidden_page.dart';
import 'home_recommend/home_baby_page.dart';

class HomeVideoPage extends StatelessWidget {
  final HomePageController controller;
  final bool forbidden;

  HomeVideoPage(
    this.controller, {
    required this.forbidden,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAppTabBar(context),
        Expanded(
          child: _buildTabBarView(),
        )
      ],
    );
  }

  _buildAppTabBar(BuildContext context) {
    var indicatorColor = COLOR.color_63d2ff;
    var selectedColor = COLOR.color_63d2ff;
    var unselectedColor = COLOR.black;

    final selectedStyle = TextStyle(
      color: selectedColor,
      fontSize: 15.w,
      fontWeight: FontWeight.w600,
    );
    final unselectedStyle = TextStyle(
      color: unselectedColor,
      fontSize: 15.w,
      fontWeight: FontWeight.w400,
    );
    return Row(
      children: [
        Expanded(
          child: Obx(() => controller.stations.value.isEmpty
              ? const SizedBox.shrink()
              : TabBar(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              isScrollable: true,
                  controller: controller.tabController,
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: COLOR.color_63d2ff,
                  labelStyle: selectedStyle,
                  labelColor: COLOR.color_63d2ff,
                  indicatorPadding: EdgeInsets.only(bottom: 8.w),
                  unselectedLabelColor: COLOR.white.withValues(alpha: 0.6),
                  indicator: EasyFixedIndicator(
                    color: indicatorColor,
                    width: 10.w,
                    height: 3.w,
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  unselectedLabelStyle: TextStyle(fontSize: 15.w),
                  tabs:
                      List.generate(controller.stations.value.length, (index) {
                    final e = controller.stations.value[index];
                    if (index == 0 && !forbidden) {
                      return Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(e.classifyTitle),
                            const SizedBox(width: 4),
                            Image.asset(
                              width: 21.w,
                              height: 14.h,
                              AppImagePath.home_home_baby_tab_logo,
                              // Replace with your actual image path
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Tab(
                        text: e.classifyTitle,
                      );
                    }
                  }))),
        ),
        // ImageView(
        //   src: AppImagePath.home_right_menu_icon,
        //   width: 20.r,
        // ).onOpaqueTap(
        //     () => _showHalfScreenDialog(context)), // 调用 _openDrawer 打开抽屉
        15.horizontalSpace,
      ],
    );
  }

  Widget _buildTabBarView() {
    return Obx(() {
      if (controller.stations.value.isEmpty) return Container();
      return TabBarView(
          controller: controller.tabController,
          children: controller.stations.value.map((e) {
            if (e.classifyType == HomePageController.baby) {
              return HomeBabyPage(model: e).keepAlive;
            } else {
              ///普通模版
              if (forbidden) {
                return HomeForbiddenPage(model: e).keepAlive;
              } else {
                return HomeCommonPage(model: e).keepAlive;
              }
            }
          }).toList());
    });
  }

  _showHalfScreenDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth / 2,
                  margin: const EdgeInsets.only(left: 10.0),
                  foregroundDecoration: const BoxDecoration(
                    backgroundBlendMode: BlendMode.srcOver,
                    color: Colors
                        .transparent, // Important for BackdropFilter to show through
                    // Use BackdropFilter directly as a widget if you need more complex stacking
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                          child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Opacity(
                                opacity: 0.8,
                                child: Image.asset(
                                  width: constraints.maxWidth / 2,
                                  height: constraints.maxHeight,
                                  AppImagePath.home_ic_enddrawer_bg,
                                  // Replace with your actual image path
                                  fit: BoxFit.fill,
                                ),
                              ))),
                      _buildEndDrawer(context),
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  GlobalKey<HomeNavigationMenuState> homeNavigationMenuStateKey = GlobalKey();

  Widget _buildEndDrawer(BuildContext context) {
    return HomeNavigationMenu(controller.forbidden,
        key: homeNavigationMenuStateKey);
  }
}
