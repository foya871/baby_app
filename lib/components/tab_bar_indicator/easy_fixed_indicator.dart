import 'package:flutter/material.dart';

///
/// 固定宽度，带渐变
///

class EasyFixedIndicator extends Decoration {
  final Color? color;
  final Gradient? gradient;
  final double widthExtra;
  final double? width;
  final double height;
  final BorderRadius borderRadius;
  final Color? borderColor;
  final double? borderWidth;

  const EasyFixedIndicator({
    this.color,
    this.gradient,
    this.width, // 传入width 表示固定长度, 不传入则自动适配长度
    this.widthExtra = .0, // 当不传width时的额外宽度
    this.height = 3.0,
    this.borderRadius = BorderRadius.zero, // 默认无圆角
    this.borderColor,
    this.borderWidth,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _Painter(
      color,
      gradient,
      widthExtra,
      width,
      height,
      borderRadius,
      borderColor,
      borderWidth,
    );
  }
}

class _Painter extends BoxPainter {
  final Color? color;
  final Gradient? gradient;
  final double widthExtra;
  final double? width;
  final double height;
  final BorderRadius borderRadius;
  final Color? borderColor;
  final double? borderWidth;

  _Painter(
    this.color,
    this.gradient,
    this.widthExtra,
    this.width,
    this.height,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  );

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final effectiveWidth = width ?? (configuration.size!.width + widthExtra);

    final Rect rect = Offset(
          offset.dx + (configuration.size!.width - effectiveWidth) / 2,
          configuration.size!.height - height,
        ) &
        Size(effectiveWidth, height);

    final Paint paint = Paint();

    if (gradient != null) {
      paint.shader = gradient!.createShader(rect);
    } else if (color != null) {
      paint.color = color!;
    } else {
      paint.color = Colors.black;
    }

    // 绘制边框
    if (borderColor != null) {
      final Paint borderPaint = Paint()
        ..color = borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = (borderWidth ?? 1);

      final RRect rRect = RRect.fromRectAndCorners(
        rect,
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: borderRadius.bottomRight,
      );

      canvas.drawRRect(rRect, borderPaint);
    }

    //
    final RRect rRect = RRect.fromRectAndCorners(
      rect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    canvas.drawRRect(rRect, paint);
  }
}
