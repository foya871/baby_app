import 'dart:math';

import 'package:short_video_mudle/short_video_mudle.dart';

import '../../assets/styles.dart';
import 'package:flutter/material.dart';
import '../../utils/extension.dart';

///
///    --------------------
///    |                  |
///    |                  |
///    --------\  /--------
///             \/
///
class SharpRectangleClipper extends CustomClipper<Path> {
  final double sharpWidthRatio; // 三角部分宽度占比
  final double sharpHeightRatio; // 三角部分高度占比
  final Radius? radius;

  SharpRectangleClipper({
    required this.sharpWidthRatio,
    required this.sharpHeightRatio,
    this.radius,
  });

  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final sharpWidth = size.width * sharpWidthRatio;
    final sharpHeight = size.height * sharpHeightRatio;
    final rectHeight = height - sharpHeight;

    final sharpLeftX = (width / 2) - (sharpWidth / 2);
    final shartRightX = (width / 2) + (sharpWidth / 2);
    final sharpLeft = Point(sharpLeftX, rectHeight);
    final sharpVertex = Point(width / 2, height);
    final sharpRight = Point(shartRightX, rectHeight);
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, width, rectHeight),
          radius ?? Styles.radius.m,
        ),
      )
      ..moveToPoint(sharpLeft)
      ..lineToPoint(sharpVertex)
      ..lineToPoint(sharpRight);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) =>
      oldClipper != this;
}
