/*
 * @Author: wangdazhuang
 * @Date: 2024-08-26 16:25:58
 * @LastEditTime: 2025-07-10 20:05:01
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/views/main/views/main_page.dart
 */
import 'package:baby_app/components/ad/ad_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/easy_button.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/navigation_bar/easy_bottom_navigation_bar.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/utils/ad_jump.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import 'package:baby_app/views/community/community_page.dart';
import 'package:baby_app/views/home/home_page.dart';
import 'package:baby_app/views/main/controllers/main_controller.dart';
import 'package:baby_app/views/mine/mine_page.dart';

import '../../../components/ad/ad_enum.dart';
import '../../../utils/color.dart';
import '../../discover/discover_page.dart';
import '../../forbidden/forbidden_page.dart';
import 'pop_scope_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  BottomNavigationBarItem _buildBarItem({
    required String label,
    required String icon,
    required String activeIcon,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Image.asset(icon, width: 26.w, height: 26.w),
      activeIcon: Image.asset(activeIcon, width: 26.w, height: 26.w),
    );
  }

  Widget _buildTabbar() {
    final homeContoller = Get.find<MainController>();
    return Obx(
      () => EasyBottomNavigationBar.common(
        currentIndex: homeContoller.currentIndex.value,
        onTap: homeContoller.changeMainTabIndex,
        items: [
          _buildBarItem(
            label: '首页',
            icon: AppImagePath.tabbar_t1,
            activeIcon: AppImagePath.tabbar_t1_y,
          ),
          _buildBarItem(
            label: '社区',
            icon: AppImagePath.tabbar_t2,
            activeIcon: AppImagePath.tabbar_t2_y,
          ),
          _buildBarItem(
            label: '神秘岛',
            icon: AppImagePath.tabbar_t3,
            activeIcon: AppImagePath.tabbar_t3_y,
          ),
          _buildBarItem(
            label: '发现',
            icon: AppImagePath.tabbar_t4,
            activeIcon: AppImagePath.tabbar_t4_y,
          ),
          _buildBarItem(
            label: '我的',
            icon: AppImagePath.tabbar_t5,
            activeIcon: AppImagePath.tabbar_t5_y,
          ),
        ],
      ),
    );
  }

  Widget _buildFixedAd() {
    final ad = AdUtils().getAdInfo(AdApiType.FLOATING_ICON_BOTTOM_RIGHT);
    if (ad == null) return const SizedBox.shrink();
    ValueNotifier<bool> showRightAd = ValueNotifier(true);
    return ValueListenableBuilder(
        valueListenable: showRightAd,
        builder: (context, value, child) {
          if (!value) return const SizedBox.shrink();
          return SizedBox(
            width: 89.w,
            height: 89.w,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: ImageView(
                    src: ad.adImage ?? '',
                    width: 80.w,
                    height: 80.w,
                  ).onTap(() => kAdjump(ad)),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Image.asset(
                    AppImagePath.app_default_close,
                    width: 18.w,
                    height: 18.w,
                  ).onTap(() {
                    showRightAd.value = false;
                  }),
                )
              ],
            ),
          ).paddingBottom(50.w).marginRight(Get.width - 120.w);
        });
  }

  Widget _buildBottomAd() {
    final bottomAd = AdUtils().getAdInfo(AdApiType.FLOATING_ICON_BOTTOM_RIGHT);
    ValueNotifier<bool> showAd = ValueNotifier(true);
    return ValueListenableBuilder(
        valueListenable: showAd,
        builder: (context, value, child) {
          return Positioned(
            left: 12.w,
            right: 12.w,
            bottom: 3.w,
            height: 55.w,
            child: Visibility(
              visible: value && bottomAd != null,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 5.w,
                    child: Container(
                      height: 40.w,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(6.w)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          5.w.horizontalSpace,
                          ImageView(
                            src: bottomAd?.adImage ?? '',
                            borderRadius: BorderRadius.circular(5.w),
                            width: 36.w,
                            height: 36.w,
                          ),
                          8.w.horizontalSpace,
                          Expanded(
                            child: Text(
                              bottomAd?.adName ?? '',
                              style: kTextStyle(Colors.white,
                                  fontsize: 13.w, weight: FontWeight.w500),
                              maxLines: 1,
                            ),
                          ),
                          8.w.horizontalSpace,
                          EasyButton.child(
                              Text('领取',
                                  style:
                                      kTextStyle(Colors.white, fontsize: 12.w)),
                              width: 48.w,
                              height: 26.w,
                              backgroundColor: COLOR.themeSelectedColor,
                              borderRadius: BorderRadius.circular(10.w)),
                          8.w.horizontalSpace,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Image.asset(
                      AppImagePath.app_default_close,
                      width: 18.w,
                      height: 18.w,
                    ).onTap(() => showAd.value = false),
                  )
                ],
              ).onTap(() => kAdjump(bottomAd!)),
            ),
          );
        });
  }

  Widget _buildBottomTabbar() {
    if (kIsWeb) {
      return Container(
        color: COLOR.scaffoldBg,
        padding: const EdgeInsets.only(bottom: 20),
        child: _buildTabbar(),
      );
    }
    return _buildTabbar();
  }

  @override
  Widget build(BuildContext context) {
    final homeContoller = Get.find<MainController>();
    return PopScopePage(
      child: Scaffold(
        floatingActionButton: _buildFixedAd(),
        backgroundColor: COLOR.scaffoldBg,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Stack(
          children: [
            Positioned.fill(
              child: Obx(
                () => LazyLoadIndexedStack(
                  index: homeContoller.currentIndex.value,
                  preloadIndexes: const [0],
                  children: [
                    HomePage(),
                    const CommunityPage(),
                    const ForbiddenPage(),
                    const DiscoverPage(),
                    const MinePage(),
                  ],
                ),
              ),
            ),
            _buildBottomAd(),
          ],
        ),
        bottomNavigationBar: _buildBottomTabbar(),
      ),
    );
  }
}
