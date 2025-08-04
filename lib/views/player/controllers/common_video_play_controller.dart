/*
 * @Author: wangdazhuang
 * @Date: 2024-08-29 19:31:14
 * @LastEditTime: 2025-01-27 11:39:42
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/views/player/controllers/common_video_play_controller.dart
 */

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:baby_app/utils/logger.dart';

class CommonVideoPlayerController extends GetxController with StateMixin {
  RxBool playerInitialized = false.obs;

  VideoController? playerVC;
  Player? player;

  ///播放结束
  StreamSubscription<bool>? _endSubs;
  StreamSubscription<Duration>? _posSubs;
  var _start2Play = false;

  //初始化播放器
  void _initAction() {
    String playPath = Get.arguments;

    assert(playPath.isNotEmpty, 'init player failed,play URL empty!');
    logger.d('播放地址>>>>:$playPath');
    change(null, status: RxStatus.loading());

    final config = PlayerConfiguration(
      muted: false,
      title: '',
      osc: true,
      ready: () {
        change(null, status: RxStatus.success());
        playerInitialized.value = true;
        update();
      },
    );
    player = Player(configuration: config);
    playerVC = VideoController(
      player!,
      configuration: VideoControllerConfiguration(
        enableHardwareAcceleration: !GetPlatform.isAndroid,
      ),
    );

    //结束
    _endSubs = player!.stream.completed.listen((e) {
      if (e) {
        player!.seek(const Duration(seconds: 0)).then((_) {
          player!.play();
        });
      }
    });
    //进度
    _posSubs = player!.stream.position.listen((pos) {
      if (pos.inMilliseconds > 500 && !_start2Play && !kIsWeb) {
        _start2Play = true;
        player!.seek(Duration.zero).then((_) {
          player!.play();
        });
      }
    });
    player?.open(Media(playPath));
  }

  @override
  void onClose() {
    _endSubs?.cancel();
    _posSubs?.cancel();
    player?.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    _initAction();
  }
}
