import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'swipe_info.dart';
import 'swipe_controller.dart';
import 'swipe_animations.dart';

class SwipeCards extends StatefulWidget {
  final SwipeController controller;
  final WidgetBuilder? emptyBuilder;

  const SwipeCards({
    super.key,
    required this.controller,
    this.emptyBuilder,
  });

  @override
  _SwipeCardState createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCards> with TickerProviderStateMixin {
  List<Widget> _cards = [];
  final List<SwipeInfo> _swipeHistory = [];
  late CardAnimations _animations;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animations = CardAnimations(this);
    _cards = widget.controller.cards;

    widget.controller.exitCallback = _exit;
    widget.controller.resetCallback = _reset;
    widget.controller.appendCallback = _append;
    widget.controller.undoCallback = _undo;
  }

  void _exit(SwipeDirection direction) {
    if (_animations.isAnimating || _currentIndex >= _cards.length) return;

    _animations.currentDirection = direction;
    final info = SwipeInfo(_currentIndex, direction);
    _swipeHistory.add(info);

    _animations.startExitAnimation(() {
      _completeExit(info);
    });
  }

  void _completeExit(SwipeInfo info) {
    setState(() {
      _currentIndex++;
      _animations.currentDirection = null;
    });

    _fillWorward();

    widget.controller.onExit?.call(info);

    if (_currentIndex >= _cards.length) {
      widget.controller.onEnd?.call();
    } else {
      widget.controller.onChanged
          ?.call(SwipeInfo(_currentIndex, SwipeDirection.none));
    }
  }

  void _undo() {
    if (_animations.isAnimating || _swipeHistory.isEmpty) return;

    _animations.startFillBackwardAnimation(() {
      setState(() {
        _currentIndex--;
      });
      _animations.startUndoAnimation(() {
        final lastSwipe = _swipeHistory.removeLast();
        widget.controller.onUndo
            ?.call(SwipeInfo(lastSwipe.cardIndex, lastSwipe.direction));
        widget.controller.onChanged
            ?.call(SwipeInfo(_currentIndex, SwipeDirection.none));
      });
    });
  }

  void _fillWorward() {
    _animations.startFillForwardAnimation(() {});
  }

  void _reset(List<Widget> cards) {
    if (_animations.isAnimating) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _reset(cards));
      return;
    }

    setState(() {
      _cards
        ..clear()
        ..addAll(cards);
      _currentIndex = 0;
      _swipeHistory.clear();
      _animations.resetAnimations();
    });
  }

  void _append(List<Widget> cards) {
    if (_animations.isAnimating) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _append(cards));
      return;
    }

    setState(() => _cards.addAll(cards));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final hasEnoughCards = _cards.length - _currentIndex >= 3;
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            if (hasEnoughCards) _buildBackCard(constraints),
            if (_cards.length - _currentIndex >= 2)
              _buildMiddleCard(constraints),
            _buildFrontCard(constraints),
            if (_cards.isEmpty || _currentIndex >= _cards.length)
              widget.emptyBuilder?.call(context) ??
                  const Center(child: Text('No more cards')),
          ],
        );
      },
    );
  }

  Widget _buildFrontCard(BoxConstraints constraints) {
    return _buildCardLayer(index: _currentIndex, constraints: constraints);
  }

  Widget _buildMiddleCard(BoxConstraints constraints) {
    return _buildCardLayer(index: _currentIndex + 1, constraints: constraints);
  }

  Widget _buildBackCard(BoxConstraints constraints) {
    return _buildCardLayer(index: _currentIndex + 2, constraints: constraints);
  }

  // 添加方向指示器逻辑
  Widget _buildCardLayer({
    required int index,
    required BoxConstraints constraints,
  }) {
    if (index >= _cards.length) return const SizedBox.shrink();
    final bool isFront = index == _currentIndex;
    final bool isMiddle = index == _currentIndex + 1;

    return AnimatedBuilder(
      animation: _animations.allListenableAnimation(),
      builder: (context, _) {
        return Align(
          alignment: isFront
              ? _animations.alignment
              : isMiddle
                  ? _animations.middleAlignment
                  : _animations.backAlignment,
          child: Transform.rotate(
            angle: isFront ? _animations.angle : 0,
            alignment: const Alignment(0, 2.5),
            child: Transform.translate(
              offset: Offset(
                0,
                isFront
                    ? 10.w
                    : isMiddle
                        ? 5.w
                        : 0,
              ),
              child: Transform.scale(
                alignment: Alignment.topCenter,
                scale: isFront
                    ? _animations.frontScale
                    : isMiddle
                        ? _animations.middleScale
                        : _animations.backScale,
                child: _cards[index].paddingOnly(
                  left: 15.w,
                  right: 15.w,
                  bottom: 10.w,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

/*
void _resetCardPosition() {
    // _alignment = Alignment.center;
    // _angle = 0.0;
  }

  // void _onSwipeProgress() {
  //   setState(() {
  //     _alignment = _animations
  //         .cardExitAlignment(_currentDirection, _alignment.x)
  //         .evaluate(_swipeController);
  //     _angle = _animations
  //         .cardExitAngle(_currentDirection, _angle)
  //         .evaluate(_swipeController);
  //     debugPrint("_alignment: $_alignment");
  //     debugPrint("_angle: $_angle");
  //     debugPrint("progress: ${_swipeController.value}");
  //   });
  // }

  // void _onUndoProgress() {
  //   setState(() {
  //     final info = _swipeHistory.last;
  //     final tween = _animations.cardUndoAlignment(info.direction, 1.0);
  //     _alignment = tween.evaluate(_undoController);
  //   });
  // }

  // void _onBackProgress() {
  //   setState(() {
  //     final tween = _animations.cardCancelAlignment(_alignment.x);
  //     _alignment = tween.evaluate(_springController);
  //     final angleTween = _animations.cardBackAngle(_angle);
  //     _angle = angleTween.evaluate(_springController);
  //   });
  // }

Widget _buildGestureDetector() {
    return GestureDetector(
      onPanUpdate: (details) => _updateCardPosition(details.delta),
      onPanEnd: (details) => _handleSwipeDecision(details),
      behavior: HitTestBehavior.translucent,
    );
  }

  void _updateCardPosition(Offset delta) {
    // final newX = (_alignment.x + delta.dx * 0.1);

    // setState(() {
    // _alignment = Alignment(newX, _alignment.y);
    // _angle = newX * 0.05;
    // });
  }

  void _handleSwipeDecision(DragEndDetails details) {
    // const threshold = 5;
    // final direction = _alignment.x > threshold
    //     ? SwipeDirection.Right
    //     : _alignment.x < -threshold
    //         ? SwipeDirection.Left
    //         : SwipeDirection.None;

    // if (direction != SwipeDirection.None) {
    //   _exit(direction);
    // } else {
    //   final velocity = details.velocity.pixelsPerSecond.dx;
    //   _springBack(velocity);
    // }
  }

  void _springBack(double velocity) {
    // _cancelController.forward().whenComplete(() {
    //   _resetCardPosition();
    // });
    // _springController.reset();
    // _springController.forward().whenComplete(() {
    //   setState(() {
    //     _resetCardPosition();
    //   });
    // });
  }
*/
  @override
  void dispose() {
    // _exitController.dispose();
    // _undoController.dispose();
    super.dispose();
  }
}
