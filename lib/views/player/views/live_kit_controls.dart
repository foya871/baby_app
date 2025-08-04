/*
 * @Author: wangdazhuang
 * @Date: 2025-01-13 14:52:40
 * @LastEditTime: 2025-03-15 09:37:05
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/views/player/views/live_kit_controls.dart
 */

import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/widgets/video_controls_theme_data_injector.dart';
import 'package:baby_app/generate/app_image_path.dart';
import '../../../assets/styles.dart';
import '../../../utils/logger.dart';
import 'av_player_loading.dart';

// ignore: must_be_immutable
class LiveKitControls extends StatefulWidget {
  final BuildContext buildContext;
  Size? viewSize;
  Rect? texturePos;
  BuildContext? pageContent;
  String? playerTitle;
  bool? hideBack;
  LiveKitControls({
    super.key,
    required this.buildContext,
    this.viewSize,
    this.texturePos,
    this.pageContent,
    this.playerTitle,
    this.hideBack = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LiveKitControlsState createState() => _LiveKitControlsState();
}

class _LiveKitControlsState extends State<LiveKitControls> {
  final barHeight = 55.0;
  final barContainerHeight = 35.0;

  final centerSeekBarHeight = 5.0;

  final centerBtnSize = 45.0;
  final thumbSize = 18.0;

  double slider = 0.0;

  bool _isBuffering = false;
  StreamSubscription? _bufferingStateSubs;

  bool _isPlaying = false;
  StreamSubscription? _playingSubs;

  Timer? _hideTimer;
  bool _hideStuff = false;

  @override
  void didChangeDependencies() {
    _addSubscriptionListeners();

    super.didChangeDependencies();
  }

  ///监听器
  void _addSubscriptionListeners() {
    Player player = controller(context).player;
    _bufferingStateSubs = player.stream.buffering.listen((v) {
      if (mounted) {
        setState(() {
          _isBuffering = v;
          if (!v && !_isPlaying) {
            player?.play();
          }
        });
      }
    });

    _playingSubs = player.stream.playing.listen((v) {
      if (mounted) {
        setState(() {
          _isPlaying = v;
        });
      }
    });
  }

  @override
  void dispose() {
    _bufferingStateSubs?.cancel();
    _playingSubs?.cancel();
    _hideTimer?.cancel();
    super.dispose();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _hideStuff = true;
      });
    });
  }

  void _cancelAndRestartTimer() {
    if (_hideStuff == true) {
      _startHideTimer();
    }
    setState(() {
      _hideStuff = !_hideStuff;
    });
  }

  ///全屏按钮
  _buildFullScreenBtn(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return IconButton(
          icon: const Icon(Icons.fullscreen),
          padding: const EdgeInsets.only(left: 5.0, right: 10.0),
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () async {
            final wh = MediaQuery.of(context).size;
            logger.d("w >>> ${wh.width},h >>> ${wh.height}");
            final isFull = isFullscreen(context);
            if (isFull) {
              await exitFullscreen(context);
              if (!kIsWeb) {
                await SystemChrome.setPreferredOrientations(
                    [DeviceOrientation.portraitUp]);
              }
            } else {
              enterFullscreen(context);
              if (!kIsWeb) {
                await SystemChrome.setPreferredOrientations(
                    [DeviceOrientation.landscapeLeft]);
              }
            }
          },
        );
      },
    );
  }

  // 底部
  Container _buildBottomBar(BuildContext context) {
    final isInner = (widget.viewSize?.height ?? 0) < Get.height;
    final bottomH = isInner ? 0.0 : MediaQuery.of(context).padding.bottom;
    return Container(
      height: barHeight,
      padding: EdgeInsets.only(bottom: bottomH),
      alignment: Alignment.center,
      decoration: BoxDecoration(image: Styles.gradient.gradientImage),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Expanded(child: SizedBox.shrink()),
          // 按钮 - 全屏/退出全屏
          _buildFullScreenBtn(context),
          // const MaterialFullscreenButton()
        ],
      ),
    );
  }

  // 播放器顶部 返回 + 标题
  Widget _buildTopBar(BuildContext context) {
    final isFull = isFullscreen(context);

    // return OrientationBuilder(
    //   builder: (context, orientation) {
    //     return IconButton(
    //       icon: const Icon(Icons.fullscreen),
    //       padding: const EdgeInsets.only(left: 5.0, right: 10.0),
    //       color: Colors.white,
    //       splashColor: Colors.transparent,
    //       highlightColor: Colors.transparent,
    //       onPressed: () async {
    //         final wh = MediaQuery.of(context).size;
    //         logger.d("w >>> ${wh.width},h >>> ${wh.height}");
    //         final isFull = isFullscreen(context);
    //         if (isFull) {
    //           await exitFullscreen(context);
    //           if (!kIsWeb) {
    //             await SystemChrome.setPreferredOrientations(
    //                 [DeviceOrientation.portraitUp]);
    //           }
    //         } else {
    //           enterFullscreen(context);
    //           if (!kIsWeb) {
    //             await SystemChrome.setPreferredOrientations(
    //                 [DeviceOrientation.landscapeRight]);
    //           }
    //         }
    //       },
    //     );
    //   },
    // );
    final sysH = MediaQuery.of(widget.buildContext).padding.top;
    const fixedH = 15.0;
    final top = EdgeInsets.only(top: isFull ? sysH + fixedH : fixedH);
    return
// AnimatedOpacity(
//       opacity: _isPlaying || _isBuffering ? 0.0 : 1.0,
//       duration: const Duration(milliseconds: 400),
//       child:
        Visibility(
      visible: isFull,
      child: Container(
        margin: top,
        height: 44.0,
        alignment: Alignment.centerLeft,
        child: OrientationBuilder(builder: (__, orientation) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () async {
              final size = MediaQuery.of(context).size;
              final isLand = size.width > size.height;
              final full = isFullscreen(context) || isLand;
              logger.d(
                  'full screen >>>> $full isLand >>> $isLand >> orientation >>> $orientation');

              if (full) {
                await exitFullscreen(context);

                ///回归正常屏幕方向
                if (!kIsWeb && isLand) {
                  SystemChrome.setPreferredOrientations(
                      [DeviceOrientation.portraitUp]);
                }
              } else {
                Get.back();
              }
            },
          );
        }),
      ),
      // ),
    );
  }

  // 居中按钮
  Widget _buildCenterBtns(BuildContext _) {
    if (_hideStuff) return const SizedBox.shrink();
    return Container(
      color: Colors.transparent,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: AnimatedOpacity(
          opacity: _hideStuff ? 0.0 : 0.7,
          duration: const Duration(milliseconds: 400),
          child: MaterialPlayOrPauseButton(
              iconSize: centerBtnSize, iconColor: Colors.white),
        ),
      ),
    );
  }

  ///中间
  _buildCenterBox(BuildContext context) {
    // 中间按钮
    return Expanded(
      child: GestureDetector(
        onTap: _cancelAndRestartTimer,
        child: SizedBox(
          child: Stack(
            children: <Widget>[
              // 中间按钮
              if (!_isBuffering)
                Align(
                    alignment: Alignment.center,
                    child: _buildCenterBtns(context)),
              if (_isBuffering)
                const Align(
                    alignment: Alignment.center, child: AvPlayerLoading()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = isFullscreen(context)
        ? Rect.fromLTWH(
            0,
            0,
            Get.width,
            Get.height,
          )
        : Rect.fromLTRB(
            max(0.0, widget.texturePos?.left ?? 0),
            max(0.0, widget.texturePos?.top ?? 0),
            min(widget.viewSize?.width ?? 0, widget.texturePos?.right ?? 0),
            min(widget.viewSize?.height ?? 0, widget.texturePos?.bottom ?? 0),
          );

    return VideoControlsThemeDataInjector(
      child: SizedBox.fromSize(
        size: Size(rect.width, rect.height),
        child: GestureDetector(
          onTap: _cancelAndRestartTimer,
          child: AbsorbPointer(
            absorbing: _hideStuff,
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    // 播放器顶部控制器
                    _buildTopBar(context),
                    //中间
                    _buildCenterBox(context),
                    // 播放器底部控制器
                    _buildBottomBar(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
