/*
 * @Author: wangdazhuang
 * @Date: 2024-08-29 19:08:07
 * @LastEditTime: 2025-03-11 10:28:00
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/views/player/common_player_page.dart
 */
import 'dart:async';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/views/player/controllers/common_video_play_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baby_app/views/player/views/av_player_loading.dart';
import 'views/media_kit_custom_controls.dart' as custom;

class CommonPlayerPage extends GetView<CommonVideoPlayerController> {
  const CommonPlayerPage({super.key});

  ///web上推出全屏后的自动播放
  void _autoPlay(CommonVideoPlayerController _, BuildContext context) {
    Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) {
        _.player?.play();
        timer.cancel();
      },
    );
  }

  _buildPlayer(CommonVideoPlayerController _) {
    final context = Get.context!;
    final videoH = Get.height;
    const themColor = COLOR.themeSelectedColor;

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
        viewSize: Size(Get.width, videoH),
        texturePos: Rect.fromLTWH(0, 0, Get.width, videoH),
      ),
    );
    return Video(
      key: const Key('c-video-player'),
      controller: _.playerVC!,
      filterQuality: FilterQuality.none,
      controls: (__) => Stack(
        children: [controls],
      ),
      onEnterFullscreen: () async {
        _autoPlay(_, context);
      },
      onExitFullscreen: () async {
        _autoPlay(_, context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: COLOR.black,
        body: controller.obx((_) => Center(child: _buildPlayer(controller)),
            onLoading: const AvPlayerLoading()),
      ),
    );
  }
}
