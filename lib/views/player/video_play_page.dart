/*
 * @Author: wangdazhuang
 * @Date: 2024-08-19 11:55:58
 * @LastEditTime: 2025-07-05 15:05:57
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/views/player/video_play_page.dart
 */
import 'dart:async';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/player/controllers/video_play_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:baby_app/views/player/views/play_intro_view.dart';
import 'package:baby_app/views/player/views/timer_ad.dart';
import '../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'views/av_player_loading.dart';
import 'views/choose_line_view.dart';
import 'views/comment_list.dart';
import 'views/media_kit_custom_controls.dart' as custom;
import 'views/permission_view.dart';
import 'views/start_ad.dart';
import 'views/stop_ad.dart';

class VideoPlayPage extends GetView<VideoPlayController> {
  const VideoPlayPage({super.key});

  _buildPlayer(BuildContext context) {
    if (!controller.playerInitialized.value) return const AvPlayerLoading();
    final videoH = VideoPlayController.videoH;
    const themColor = COLOR.themeSelectedColor;
    final key = Key('${controller.video.value.videoId ?? 0}');
    const themeData = MaterialVideoControlsThemeData(
      seekBarPositionColor: themColor,
      seekBarThumbColor: themColor,
      seekBarAlignment: Alignment.center,
    );
    final controls = MaterialVideoControlsTheme(
      normal: themeData,
      fullscreen: themeData,
      child: custom.MediaKitCustomControls(
        buildContext: context,
        asp: controller.videoAsp,
        viewSize: Size(Get.width, videoH),
        texturePos: Rect.fromLTWH(0, 0, Get.width, videoH),
      ),
    );

    final h = MediaQuery.of(context).size.height;
    return Video(
      width: double.infinity,
      height: isFullscreen(context) ? h : VideoPlayController.videoH,
      key: key,
      controller: controller.playerVC!,
      controls: (videoState) => controls,
      onEnterFullscreen: () async {
        _autoplayAction(context);
      },
      onExitFullscreen: () async {
        _autoplayAction(context);
      },
    );
  }

  void _visibleAction(VisibilityInfo info) {
    if (info.visibleFraction == 1) {
    } else if (info.visibleFraction == 0.0) {
      /// push了或者销毁了
      final isLive = Get.isRegistered<VideoPlayController>() ||
          Get.isPrepared<VideoPlayController>();
      if (isLive) {
        ///暂停
        final _ = Get.find<VideoPlayController>();
        _.player?.pause();
      }
    }
  }

  ///顶部播放器
  _buildPlayBox(BuildContext context) {
    return SizedBox(
      height: VideoPlayController.videoH,
      child: Stack(
        children: [
          //播放器
          _buildPlayer(context),
          //权限 右上角
          PermissionView(vc: controller),
          //开头广告
          StartAd(vc: controller),
          //倒计时广告
          TimerAd(vc: controller),
          //暂停广告
          StopAd(vc: controller),
        ],
      ),
    );
  }

  Widget _buildItem(
      {required String title, required String icon, VoidCallback? onTap}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(icon, width: 16.w, height: 16.w),
        5.horizontalSpace,
        TextView(
          text: title,
          color: Colors.white.withValues(alpha: 0.6),
          fontSize: 13.w,
        )
      ],
    ).onTap(onTap);
  }

  Widget _buildTabHeaders(List<String> titles) {
    final tabsss = titles.map((e) {
      if (e == '简介') return Tab(text: e);
      final num = controller.video.value.commentNum ?? 0;
      final hasComment = num > 0;

      ///评论单独处理
      return Row(
        children: [
          Tab(text: e),
          SizedBox(width: 3.w),
          if (hasComment) TextView(text: '$num')
        ],
      );
    }).toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TabBar(
          tabs: tabsss,
          controller: controller.tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: EasyFixedIndicator(
              borderRadius: Styles.borderRadius.m,
              color: COLOR.color_08b4fd,
              width: 18.w,
              height: 3.w),
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 16.w, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(
              color: COLOR.white.withValues(alpha: 0.6), fontSize: 16.w),
          indicatorPadding: EdgeInsets.only(bottom: 3.w),
          dividerColor: Colors.transparent,
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(() {
              return _buildItem(
                title: controller.line.value,
                icon: AppImagePath.player_line,
                onTap: () => Get.bottomSheet(
                  isDismissible: true,
                  isScrollControlled: true,
                  backgroundColor: const Color(0xff13141f),
                  ChooseLineView(
                    controller: controller,
                    onTap: (line) {
                      controller.changeLine(line);
                      Get.back();
                    },
                  ),
                ),
              );
            })
          ],
        )),
      ],
    ).basePaddingHorizontal;
  }

  Widget _buildBottom() {
    final titles = ["简介", "评价"];
    return Expanded(
      child: DefaultTabController(
        length: titles.length,
        child: Column(
          children: [
            if (controller.showVipPermission.value)
              Image.asset(AppImagePath.player_vip_box,
                      width: 1.sw, height: 40.w)
                  .onTap(() => Get.toVip()),
            _buildTabHeaders(titles),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  PlayIntroView(vc: controller),
                  PlayCommentList(videoId: controller.video.value.videoId ?? 0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('video-player'),
      onVisibilityChanged: _visibleAction,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: COLOR.scaffoldBg,
          body: controller.obx(
            (_) {
              return Center(
                child: Column(
                  children: [
                    _buildPlayBox(context),
                    _buildBottom(),
                  ],
                ),
              );
            },
            onLoading: const AvPlayerLoading(),
          ),
        ),
      ),
    );
  }

  ///web下全屏后自动播放
  void _autoplayAction(BuildContext context) {
    Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) {
        final isLive = Get.isRegistered<VideoPlayController>();
        if (isLive) {
          final vc = Get.find<VideoPlayController>();
          if (vc.player != null) {
            vc.player?.play();
          }
        }
        timer.cancel();
      },
    );
  }
}
