/*
 * @Author: chentuan guotengda7204@gmail.com
 * @Date: 2025-03-19 18:13:59
 * @LastEditors: chentuan guotengda7204@gmail.com
 * @LastEditTime: 2025-03-22 09:51:48
 * @FilePath: /dou_yin_jie_mi_app/lib/components/swipe_cards/swipe_animations.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:baby_app/components/swipe_cards/swipe_info.dart';
import 'package:baby_app/components/swipe_cards/swipe_style.dart';

class CardAnimations {
  CardAnimationState animationState = CardAnimationState.idle;

  SwipeDirection? currentDirection;

  late AnimationController exitController;
  late AnimationController undoController;
  late AnimationController cancelController;
  late AnimationController fillForwardController;
  late AnimationController fillBackwardController;

  late Animation<Alignment> _exitAlignmentAnim;
  late Animation<double> _exitAngleAnim;

  late Animation<Alignment> _undoAlignmentAnim;
  late Animation<double> _undoAngleAnim;

  late Animation<Alignment> _cancelAlignmentAnim;
  late Animation<double> _cancelAndleAnim;

  late Animation<double> _frontFillForwardScaleAnim;
  late Animation<double> _middleFillForwardScaleAnim;
  late Animation<double> _backFillForwardScaleAnim;

  late Animation<Alignment> _frontFillForwardAlignmentAnim;
  late Animation<Alignment> _middleFillForwardAlignmentAnim;
  late Animation<Alignment> _backFillForwardAlignmentAnim;

  late Animation<double> _frontFillBackwardScaleAnim;
  late Animation<double> _middleFillBackwardScaleAnim;
  late Animation<double> _backFillBackwardScaleAnim;

  late Animation<Alignment> _frontFillBackwardAlignmentAnim;
  late Animation<Alignment> _middleFillBackwardAlignmentAnim;
  late Animation<Alignment> _backFillBackwardAlignmentAnim;

  SwipeCardStyle style;

  static double kMaxAlignmentX = 50;
  static double kMaxAngle = pi / 4;
  static double kForwardScale = 1.0;
  static double kMiddleScale = 0.9;
  static double kBackScale = 0.8;
  static double kPopScale = 0.6;

  static double kForwardAlignmentX = 0.0;
  static double kMiddleAlignmentX = -0.9;
  static double kBackAlignmentX = -1.8;
  static double kPopAlignmentX = -1.5;

  CardAnimations(TickerProvider provider,
      {this.style = const SwipeCardStyle()}) {
    _initialCardExitAnimation(provider);
    _initialCardUndoAnimation(provider);
    _initialCardCancelAnimation(provider);
    _initialCardFillFrowardAnimation(provider);
    _initialCardFillBackwardAnimation(provider);
  }

  Listenable allListenableAnimation() {
    return Listenable.merge([
      _exitAlignmentAnim,
      _exitAngleAnim,
      _undoAlignmentAnim,
      _cancelAlignmentAnim,
      _cancelAndleAnim,
      _frontFillForwardScaleAnim,
      _middleFillForwardScaleAnim,
      _backFillForwardScaleAnim,
      _frontFillForwardAlignmentAnim,
      _middleFillForwardAlignmentAnim,
      _backFillForwardAlignmentAnim,
      _frontFillBackwardScaleAnim,
      _middleFillBackwardScaleAnim,
      _backFillBackwardScaleAnim,
      _frontFillBackwardAlignmentAnim,
      _middleFillBackwardAlignmentAnim,
      _backFillBackwardAlignmentAnim
    ]);
  }

  _initialCardExitAnimation(TickerProvider provider) {
    exitController = AnimationController(
      duration: style.animationDuration,
      vsync: provider,
    );

    _exitAlignmentAnim = cardExitAlignment(currentDirection, alignment.x)
        .animate(exitController);
    _exitAngleAnim =
        cardExitAngle(currentDirection, angle).animate(exitController);
  }

  _initialCardUndoAnimation(TickerProvider provider) {
    undoController = AnimationController(
      duration: style.animationDuration,
      vsync: provider,
    );

    _undoAlignmentAnim =
        cardUndoAlignment(currentDirection).animate(undoController);
    _undoAngleAnim = cardUndoAngle(currentDirection).animate(undoController);
  }

  _initialCardCancelAnimation(TickerProvider provider) {
    cancelController =
        AnimationController(duration: style.animationDuration, vsync: provider);

    _cancelAlignmentAnim =
        cardCancelAlignment(alignment.x).animate(cancelController);
    _cancelAndleAnim = cardCancelAngle(angle).animate(cancelController);
  }

  _initialCardFillFrowardAnimation(TickerProvider provider) {
    fillForwardController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: provider);

    _frontFillForwardScaleAnim =
        frontCardFillForwardScale().animate(fillForwardController);
    _middleFillForwardScaleAnim =
        middleCardFillForwardScale().animate(fillForwardController);
    _backFillForwardScaleAnim =
        backCardFillForwardScale().animate(fillForwardController);

    _frontFillForwardAlignmentAnim =
        frontCardFillForwardAlignment().animate(fillForwardController);
    _middleFillForwardAlignmentAnim =
        middleCardFillForwardAlignment().animate(fillForwardController);
    _backFillForwardAlignmentAnim =
        backCardFillForwardAlignment().animate(fillForwardController);
  }

  _initialCardFillBackwardAnimation(TickerProvider provider) {
    fillBackwardController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: provider);

    _frontFillBackwardScaleAnim =
        frontCardFillBackwardScale().animate(fillBackwardController);
    _middleFillBackwardScaleAnim =
        middleCardFillBackwardScale().animate(fillBackwardController);
    _backFillBackwardScaleAnim =
        backCardFillBackwardScale().animate(fillBackwardController);

    _frontFillBackwardAlignmentAnim =
        frontCardFillBackwardAlignment().animate(fillBackwardController);
    _middleFillBackwardAlignmentAnim =
        middleCardFillBackwardAlignment().animate(fillBackwardController);
    _backFillBackwardAlignmentAnim =
        backCardFillBackwardAlignment().animate(fillBackwardController);
  }
}

extension AnimationValues on CardAnimations {
  bool get isAnimating {
    return animationState != CardAnimationState.idle;
  }

  Alignment get alignment {
    switch (animationState) {
      case CardAnimationState.exit:
        return _exitAlignmentAnim.value;
      case CardAnimationState.undo:
        return _undoAlignmentAnim.value;
      case CardAnimationState.cancel:
        return _cancelAlignmentAnim.value;
      case CardAnimationState.fillForward:
        return _frontFillForwardAlignmentAnim.value;
      case CardAnimationState.fillBackward:
        return _frontFillBackwardAlignmentAnim.value;
      default:
        return Alignment.center;
    }
  }

  double get angle {
    switch (animationState) {
      case CardAnimationState.exit:
        return _exitAngleAnim.value;
      case CardAnimationState.undo:
        return _undoAngleAnim.value;
      case CardAnimationState.cancel:
        return _cancelAndleAnim.value;
      default:
        return 0;
    }
  }

  double get frontScale {
    if (animationState == CardAnimationState.fillForward) {
      return _frontFillForwardScaleAnim.value;
    } else if (animationState == CardAnimationState.fillBackward) {
      return _frontFillBackwardScaleAnim.value;
    }
    return CardAnimations.kForwardScale;
  }

  double get middleScale {
    if (animationState == CardAnimationState.fillForward) {
      return _middleFillForwardScaleAnim.value;
    } else if (animationState == CardAnimationState.fillBackward) {
      return _middleFillBackwardScaleAnim.value;
    }
    return CardAnimations.kMiddleScale;
  }

  double get backScale {
    if (animationState == CardAnimationState.fillForward) {
      return _backFillForwardScaleAnim.value;
    } else if (animationState == CardAnimationState.fillBackward) {
      return _backFillBackwardScaleAnim.value;
    }
    return CardAnimations.kBackScale;
  }

  Alignment get frontAlignment {
    if (animationState == CardAnimationState.fillForward) {
      return _frontFillForwardAlignmentAnim.value;
    } else if (animationState == CardAnimationState.fillBackward) {
      return _frontFillBackwardAlignmentAnim.value;
    }
    return Alignment.center;
  }

  Alignment get middleAlignment {
    if (animationState == CardAnimationState.fillForward) {
      return _middleFillForwardAlignmentAnim.value;
    } else if (animationState == CardAnimationState.fillBackward) {
      return _middleFillBackwardAlignmentAnim.value;
    }
    return Alignment.center;
    return Alignment(0, CardAnimations.kMiddleAlignmentX);
  }

  Alignment get backAlignment {
    if (animationState == CardAnimationState.fillForward) {
      return _backFillForwardAlignmentAnim.value;
    } else if (animationState == CardAnimationState.fillBackward) {
      return _backFillBackwardAlignmentAnim.value;
    }
    return Alignment.center;
    return Alignment(0, CardAnimations.kBackAlignmentX);
  }

  Tween<double> frontCardFillBackwardScale() {
    return Tween<double>(
      begin: CardAnimations.kForwardScale,
      end: CardAnimations.kMiddleScale,
    );
  }

  Tween<double> middleCardFillBackwardScale() {
    return Tween<double>(
      begin: CardAnimations.kMiddleScale,
      end: CardAnimations.kBackScale,
    );
  }

  Tween<double> backCardFillBackwardScale() {
    return Tween<double>(
      begin: CardAnimations.kBackScale,
      end: CardAnimations.kPopScale,
    );
  }

  AlignmentTween frontCardFillBackwardAlignment() {
    return AlignmentTween(
      begin: Alignment.center,
      end: Alignment(0, CardAnimations.kMiddleAlignmentX),
    );
  }

  AlignmentTween middleCardFillBackwardAlignment() {
    return AlignmentTween(
      begin: Alignment(0, CardAnimations.kMiddleAlignmentX),
      end: Alignment(0, CardAnimations.kBackAlignmentX),
    );
  }

  AlignmentTween backCardFillBackwardAlignment() {
    return AlignmentTween(
      begin: Alignment(0, CardAnimations.kBackAlignmentX),
      end: Alignment(0, CardAnimations.kPopAlignmentX),
    );
  }
}

extension AnimationActions on CardAnimations {
  resetAnimations() {
    exitController.reset();
    undoController.reset();
    cancelController.reset();
    fillForwardController.reset();
    fillBackwardController.reset();
  }

  startExitAnimation(Function complete) {
    _exitAlignmentAnim = cardExitAlignment(currentDirection, alignment.x)
        .animate(exitController);
    _exitAngleAnim =
        cardExitAngle(currentDirection, angle).animate(exitController);

    animationState = CardAnimationState.exit;
    exitController.reset();
    exitController.forward().whenComplete(() {
      animationState = CardAnimationState.idle;
      complete();
    });
  }

  startUndoAnimation(Function complete) {
    _undoAlignmentAnim =
        cardUndoAlignment(currentDirection).animate(undoController);
    _undoAngleAnim = cardUndoAngle(currentDirection).animate(undoController);

    animationState = CardAnimationState.undo;
    undoController.reset();
    undoController.forward().whenComplete(() {
      animationState = CardAnimationState.idle;
      complete();
    });
  }

  startFillForwardAnimation(Function complete) {
    animationState = CardAnimationState.fillForward;
    fillForwardController.reset();
    fillForwardController.forward().whenComplete(() {
      animationState = CardAnimationState.idle;
      complete();
    });
  }

  startFillForwardReverseAnimation(Function complete) {
    animationState = CardAnimationState.fillForward;
    fillForwardController.reset();
    fillForwardController.reverse().whenComplete(() {
      animationState = CardAnimationState.idle;
      complete();
    });
  }

  startFillBackwardAnimation(Function complete) {
    animationState = CardAnimationState.fillBackward;
    fillBackwardController.reset();
    fillBackwardController.forward().whenComplete(() {
      animationState = CardAnimationState.idle;
      complete();
    });
  }
}

extension CardTweens on CardAnimations {
  AlignmentTween cardExitAlignment(SwipeDirection? direction, double currentX) {
    return AlignmentTween(
      begin: Alignment(currentX, 0.0),
      end: Alignment(
          direction == SwipeDirection.left
              ? -CardAnimations.kMaxAlignmentX
              : CardAnimations.kMaxAlignmentX,
          0.0),
    );
  }

  Tween<double> cardExitAngle(SwipeDirection? direction, double currentAngle) {
    return Tween<double>(
        begin: currentAngle,
        end: direction == SwipeDirection.left
            ? -CardAnimations.kMaxAngle
            : CardAnimations.kMaxAngle);
  }

  AlignmentTween cardUndoAlignment(SwipeDirection? direction) {
    return AlignmentTween(
      begin: Alignment(
          direction == SwipeDirection.left
              ? -CardAnimations.kMaxAlignmentX
              : CardAnimations.kMaxAlignmentX,
          0.0),
      end: Alignment.center,
    );
  }

  Tween<double> cardUndoAngle(SwipeDirection? direction) {
    return Tween<double>(
      begin: direction == SwipeDirection.left
          ? -CardAnimations.kMaxAngle
          : CardAnimations.kMaxAngle,
      end: 0.0,
    );
  }

  AlignmentTween cardCancelAlignment(double currentX) {
    return AlignmentTween(
      begin: Alignment(currentX, 0),
      end: Alignment.center,
    );
  }

  Tween<double> cardCancelAngle(double angle) {
    return Tween<double>(begin: angle, end: 0);
  }

  Tween<double> frontCardFillForwardScale() {
    return Tween<double>(
      begin: CardAnimations.kMiddleScale,
      end: CardAnimations.kForwardScale,
    );
  }

  Tween<double> middleCardFillForwardScale() {
    return Tween<double>(
      begin: CardAnimations.kBackScale,
      end: CardAnimations.kMiddleScale,
    );
  }

  Tween<double> backCardFillForwardScale() {
    return Tween<double>(
      begin: CardAnimations.kPopScale,
      end: CardAnimations.kBackScale,
    );
  }

  AlignmentTween frontCardFillForwardAlignment() {
    return AlignmentTween(
      begin: Alignment(0, CardAnimations.kMiddleAlignmentX),
      end: Alignment.center,
    );
  }

  AlignmentTween middleCardFillForwardAlignment() {
    return AlignmentTween(
      begin: Alignment(0, CardAnimations.kBackAlignmentX),
      end: Alignment(0, CardAnimations.kMiddleAlignmentX),
    );
  }

  AlignmentTween backCardFillForwardAlignment() {
    return AlignmentTween(
      begin: Alignment(0, CardAnimations.kPopAlignmentX),
      end: Alignment(0, CardAnimations.kBackAlignmentX),
    );
  }
}

enum CardAnimationState { exit, undo, cancel, fillForward, fillBackward, idle }
