/*
 * @Author: wangdazhuang
 * @Date: 2025-01-13 14:52:40
 * @LastEditTime: 2025-07-05 09:40:53
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/views/player/views/media_kit_custom_controls.dart
 */

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/widgets/video_controls_theme_data_injector.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import '../../../assets/styles.dart';
import '../../../components/easy_toast.dart';
import '../../../utils/color.dart';
import '../../../utils/logger.dart';
import 'av_player_loading.dart';

// ignore: must_be_immutable
class MediaKitCustomControls extends StatefulWidget {
  final BuildContext buildContext;
  Size? viewSize;
  Rect? texturePos;
  BuildContext? pageContent;
  String? playerTitle;
  bool? hideBack;
  double? asp;
  MediaKitCustomControls({
    super.key,
    required this.buildContext,
    this.asp,
    this.viewSize,
    this.texturePos,
    this.pageContent,
    this.playerTitle,
    this.hideBack = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MediaKitCustomControlsState createState() => _MediaKitCustomControlsState();
}

class _MediaKitCustomControlsState extends State<MediaKitCustomControls> {
  ///是否显示倍数
  bool _showSpeed = false;
  final List<String> _speedList = ['0.5', '0.75', '1', '1.5', '2'];
  String _currentSpeed = '1';

  Timer? _hideTimer;
  bool _hideStuff = false;

  final barHeight = 55.0;
  final barContainerHeight = 35.0;

  final centerSeekBarHeight = 5.0;

  final centerBtnSize = 45.0;
  final thumbSize = 18.0;

  bool tapped = false;
  double slider = 0.0;

  bool _isBuffering = true;
  StreamSubscription? _bufferingStateSubs;

  @override
  void didChangeDependencies() {
    _addSubscriptionListeners();
    final value = controller(context).player.state.rate;
    final current = double.parse(_currentSpeed);
    if (current != value) {
      if (mounted) {
        setState(() {
          _currentSpeed = '$value';
        });
      }
    }
    super.didChangeDependencies();
  }

  ///监听器
  void _addSubscriptionListeners() {
    Player player = controller(context).player;
    _bufferingStateSubs = player.stream.buffering.listen((v) {
      if (mounted && v != _isBuffering) {
        setState(() {
          _isBuffering = v;
        });
      }
    });
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _bufferingStateSubs?.cancel();
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

  // 底部左下按钮
  Widget _buildPlayStateBtn() {
    return const Padding(
      padding: EdgeInsets.only(left: 5),
      child: MaterialPlayOrPauseButton(
        iconColor: Colors.white,
        iconSize: 22,
      ),
    );
  }

  ///当前位置
  Widget _buildCurrentTime() {
    return const MaterialPositionIndicator(
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
      ),
    );
  }

  ///进度条
  Widget _buildSliderBar(BuildContext context) {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 5, left: 5),
        child: MaterialSeekBar(),
      ),
    );
  }

  bool get _isHorizon => (widget.asp ?? 16 / 9.0) >= 1;

  ///全屏按钮
  _buildFullScreenBtn(BuildContext context) {
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
          if (!kIsWeb && _isHorizon) {
            await SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp]);
          }
        } else {
          enterFullscreen(context);
          if (!kIsWeb && _isHorizon) {
            await SystemChrome.setPreferredOrientations(
                [DeviceOrientation.landscapeLeft]);
          }
        }
      },
    );
  }

  // 底部
  AnimatedOpacity _buildBottomBar(BuildContext context) {
    final isInner = (widget.viewSize?.height ?? 0) < Get.height;
    final bottomH = isInner ? 0.0 : MediaQuery.of(context).padding.bottom;
    return AnimatedOpacity(
      opacity: _hideStuff ? 0.0 : 0.8,
      duration: const Duration(milliseconds: 400),
      child: Container(
        height: barHeight,
        padding: EdgeInsets.only(bottom: bottomH),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            colors: [
              Color.fromRGBO(0, 0, 0, 0),
              Color.fromRGBO(0, 0, 0, 0.7),
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // 按钮 - 播放/暂停
            _buildPlayStateBtn(),
            // 已播放时间
            _buildCurrentTime(),
            // 播放进度
            _buildSliderBar(context),
            const SizedBox(width: 10.0),
            Text('${_currentSpeed}X', style: kTextStyle(Colors.white))
                .onTap(() {
              setState(() {
                _showSpeed = true;
              });
            }),

            // 总播放时间
            // _buildDuration(),
            // 按钮 - 全屏/退出全屏
            _buildFullScreenBtn(context),
            // const MaterialFullscreenButton()
          ],
        ),
      ),
    );
  }

  // 播放器顶部 返回 + 标题
  AnimatedOpacity _buildTopBar(BuildContext context) {
    final isFull = isFullscreen(context);
    var opac = 0.0;
    if (!isFull) opac = 1.0;
    if (!_hideStuff) opac = 1.0;

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
    return AnimatedOpacity(
      opacity: opac,
      duration: const Duration(milliseconds: 400),
      child: Visibility(
        visible: widget.hideBack == true ? false : true,
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
      ),
    );
  }

// 暂停 + 播放
  _buildPlayPauseBtn() {
    // return EasyButton.child(
    //     width: centerBtnSize,
    //     height: centerBtnSize,
    //     Icon(_playing ? Icons.pause : Icons.play_arrow,
    //         size: centerBtnSize, color: Colors.white),
    //     onTap: _playOrPause);
    return MaterialPlayOrPauseButton(
        iconSize: centerBtnSize, iconColor: Colors.white);
  }

  ///快退快进
  _forwardOrBackAction(bool back, BuildContext _) async {
    final player = controller(_).player;
    var current = player.state.position.inSeconds;
    final duration = player.state.duration;
    if (back) {
      ///快退
      current = current - 10;
      if (current < 0) current = 0;
      await player.seek(Duration(seconds: current));
    } else {
      ///快进
      current = current + 10;
      if (current > duration.inSeconds && duration != Duration.zero) {
        current = duration.inSeconds;
      }
      await player.seek(Duration(seconds: current));
    }
  }

//快退
  _buildBack10Btn(BuildContext _) {
    // return EasyButton.child(
    // Icon(
    //   Icons.replay_10_outlined,
    //   color: Colors.white,
    //   size: centerBtnSize,
    // ),
    //     width: centerBtnSize,
    //     height: centerBtnSize,
    //     onTap: () => _forwardOrBackAction(true));
    return MaterialCustomButton(
      onPressed: () => _forwardOrBackAction(true, _),
      icon: Icon(
        Icons.replay_10_outlined,
        color: Colors.white,
        size: centerBtnSize,
      ),
      iconSize: centerBtnSize,
    );
  }

  ///快进
  _buildForward10Btn(BuildContext _) {
    // return EasyButton.child(
    //     Icon(
    //       Icons.forward_10_outlined,
    //       color: Colors.white,
    //       size: centerBtnSize,
    //     ),
    //     width: centerBtnSize,
    //     height: centerBtnSize,
    //     onTap: () => _forwardOrBackAction(false));
    return MaterialCustomButton(
      onPressed: () => _forwardOrBackAction(false, _),
      icon: Icon(
        Icons.forward_10_outlined,
        color: Colors.white,
        size: centerBtnSize,
      ),
      iconSize: centerBtnSize,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildBack10Btn(_),
            const SizedBox(width: 20),
            _buildPlayPauseBtn(),
            const SizedBox(width: 20),
            _buildForward10Btn(_),
          ],
        ),
      )),
    );
  }

  ///中间
  _buildCenterBox(BuildContext context) {
    // 中间按钮
    return Expanded(
      child: GestureDetector(
        onTap: () => _cancelAndRestartTimer.call(),
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

  Widget _buildSpeeds() {
    return Positioned.fill(
        child: Container(
      color: const Color.fromRGBO(0, 0, 0, 0.5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _speedList.map((v) {
          final current = double.parse(v) == double.parse(_currentSpeed);
          final bgColor = current ? COLOR.color_D8201D : COLOR.color_999999;
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(5)),
            height: 30,
            width: 50,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'X$v',
              style: kTextStyle(Colors.white),
            ),
          ).onTap(() async {
            await controller(context).player.setRate(double.parse(v));
            EasyToast.show('X$v');
            setState(() {
              _currentSpeed = v;
              _showSpeed = false;
            });
          });
        }).toList(),
      ),
    ).onTap(() {
      setState(() {
        _showSpeed = false;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    // Rect rect = isFullscreen(context)
    //     ? Rect.fromLTWH(
    //         0,
    //         0,
    //         Get.width,
    //         Get.height,
    //       )
    //     : Rect.fromLTRB(
    //         max(0.0, widget.texturePos?.left ?? 0),
    //         max(0.0, widget.texturePos?.top ?? 0),
    //         min(widget.viewSize?.width ?? 0, widget.texturePos?.right ?? 0),
    //         min(widget.viewSize?.height ?? 0, widget.texturePos?.bottom ?? 0),
    //       );

    return VideoControlsThemeDataInjector(
      child: GestureDetector(
        onTap: _cancelAndRestartTimer,
        // behavior: HitTestBehavior.opaque,
        // onHorizontalDragStart: _onHorizontalDragStart,
        // onHorizontalDragUpdate: _onHorizontalDragUpdate,
        // onHorizontalDragEnd: _onHorizontalDragEnd,
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
                  //底部间隙
                  SizedBox(height: isFullscreen(context) ? 20 : 0),
                ],
              ),
              if (_showSpeed) _buildSpeeds(),
            ],
          ),
        ),
      ),
    );
  }
}
