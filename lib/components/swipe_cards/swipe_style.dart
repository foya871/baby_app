/*
 * @Author: chentuan guotengda7204@gmail.com
 * @Date: 2025-03-19 18:13:13
 * @LastEditors: chentuan guotengda7204@gmail.com
 * @LastEditTime: 2025-03-20 21:20:35
 * @FilePath: /dou_yin_jie_mi_app/lib/components/swipe_cards/swipe_style.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';

class SwipeCardStyle {
  final double frontCardScale;
  final double middleCardScale;
  final double backCardScale;
  final double middleCardAligmentY;
  final double backCardAligmentY;
  final EdgeInsets cardPadding;
  final Duration animationDuration;
  final Curve animationCurve;
  final SpringDescription spring;

  const SwipeCardStyle({
    this.middleCardAligmentY = -0.8,
    this.backCardAligmentY = -1.2,
    this.frontCardScale = 0.95,
    this.middleCardScale = 0.9,
    this.backCardScale = 0.85,
    this.cardPadding = const EdgeInsets.all(15),
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.spring = const SpringDescription(
      mass: 1,
      stiffness: 1000,
      damping: 500,
    ),
  });
}
