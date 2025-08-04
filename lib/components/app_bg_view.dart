import 'package:flutter/material.dart';

class AppBgView extends StatelessWidget {
  final String? text; // 要显示的文本内容
  final Widget? child; // 要显示的文本内容
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final String? imagePath;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  final double radius;
  final Border? border;

  final TextStyle? textStyle; // 文本样式
  final double? textSize; // 文本字体大小
  final Color? textColor; // 文本颜色
  final FontWeight? fontWeight; // 字体粗细
  final double? textHeight; // 行高
  final double? textWordSpacing; // 单词间距
  final TextAlign? textAlign; // 文本对齐方式
  final TextDirection? textDirection; // 文本方向
  final TextOverflow? overflow; // 文本溢出处理方式
  final int? maxLines; // 最大行数

  final Function()? onTap;

  const AppBgView({
    super.key,
    this.text,
    this.child,
    this.width,
    this.height,
    this.constraints,
    this.decoration,
    this.backgroundColor,
    this.alignment,
    this.margin,
    this.padding,
    this.imagePath,
    this.fit,
    this.borderRadius,
    this.radius = 0,
    this.border,
    this.textStyle,
    this.textSize,
    this.textColor,
    this.fontWeight,
    this.textHeight,
    this.textWordSpacing,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        constraints: constraints,
        decoration: decoration ??
            BoxDecoration(
              color: backgroundColor,
              image: imagePath != null
                  ? DecorationImage(
                      image: AssetImage(imagePath ?? ""),
                      fit: fit ?? BoxFit.cover,
                    )
                  : null,
              borderRadius: borderRadius ?? BorderRadius.circular(radius),
              border: border,
            ),
        alignment: alignment ?? Alignment.center,
        child: child ??
            Text(
              text ?? "",
              style: textStyle ??
                  TextStyle(
                    color: textColor,
                    fontSize: textSize,
                  ),
              textAlign: textAlign,
              textDirection: textDirection,
              overflow: overflow,
              maxLines: maxLines,
            ),
      ),
    );
  }
}
