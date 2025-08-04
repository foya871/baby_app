/*
 * @Author: chentuan guotengda7204@gmail.com
 * @Date: 2025-03-19 18:13:29
 * @LastEditors: chentuan guotengda7204@gmail.com
 * @LastEditTime: 2025-03-21 17:25:17
 * @FilePath: /dou_yin_jie_mi_app/lib/components/swipe_cards/swipe_controller.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter/material.dart';
import 'package:baby_app/components/swipe_cards/swipe_info.dart';

class SwipeController {
  late final List<Widget> cards;
  ValueChanged<SwipeInfo>? onExit;
  ValueChanged<SwipeInfo>? onChanged;
  ValueChanged<SwipeInfo>? onUndo;
  VoidCallback? onEnd;

  SwipeController(this.cards);

  void Function(SwipeDirection)? exitCallback;
  VoidCallback? undoCallback;
  void Function(List<Widget>)? resetCallback;
  void Function(List<Widget>)? appendCallback;

  void exitLeft() => exitCallback?.call(SwipeDirection.left);
  void exitRight() => exitCallback?.call(SwipeDirection.right);
  void undo() => undoCallback?.call();
  void reset(List<Widget> cards) => resetCallback?.call(cards);
  void append(List<Widget> cards) => appendCallback?.call(cards);
}
