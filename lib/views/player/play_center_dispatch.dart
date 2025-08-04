/*
 * @Author: wangdazhuang
 * @Date: 2024-11-07 20:50:02
 * @LastEditTime: 2025-03-11 14:28:43
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/views/player/play_center_dispatch.dart
 */
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

///播放调度中心，多个列表订阅这个调度中心，保证同一时间只会播放一个视频
class PlayCenterDispatch extends GetxService with ChangeNotifier {
  static const aspRatio = 360 / 180;
  String playPath = '';
  bool playerInitialized = false;

  Player? player;
  VideoController? playerVC;
  StreamSubscription<bool>? _endSubs;

  @override
  void onClose() {
    _endSubs?.cancel();
    super.onClose();
  }

  //切源
  Future changePlayerSource(String videoURL) async {
    playerInitialized = false;
    playPath = videoURL;
    if (player == null) {
      final config = PlayerConfiguration(
        muted: false,
        title: '',
        osc: true,
        ready: () {
          playerInitialized = true;
          notifyListeners();
        },
      );
      player = Player(configuration: config);
      playerVC = VideoController(
        player!,
        configuration: VideoControllerConfiguration(
          enableHardwareAcceleration: !GetPlatform.isAndroid,
        ),
      );
      player?.open(Media(playPath));
    } else {
      await player?.pause();
      await player?.stop();
      await player?.open(Media(videoURL));
      playerInitialized = true;
      notifyListeners();
    }

    ///播放结束监听
    _endSubs = player!.stream.completed.listen((e) {
      if (e) {
        player!.seek(const Duration(seconds: 0)).then((_) {
          player!.play();
        });
      }
    });
    player?.open(Media(playPath));
  }
}
