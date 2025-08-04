import 'package:flutter/material.dart';

import 'sharp_rectangle_clipper.dart';

class SharpRectangleWidget extends StatelessWidget {
  final double sharpWidthRatio;
  final double sharpHeightRatio;
  final Radius? radius;
  final Widget child;
  const SharpRectangleWidget({
    super.key,
    this.sharpWidthRatio = 0.095,
    this.sharpHeightRatio = 0.095,
    required this.child,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SharpRectangleClipper(
        sharpHeightRatio: sharpHeightRatio,
        sharpWidthRatio: sharpWidthRatio,
        radius: radius,
      ),
      child: child,
    );
  }
}
