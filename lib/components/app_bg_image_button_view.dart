import 'package:flutter/material.dart';

class AppBgImageButtonView extends StatelessWidget {
  final double? width;
  final double? height;

  final String imageBg;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  final Decoration? decoration;
  final Color? backgroundColor;
  final BoxBorder? border;

  final String text;
  final Color? textColor;
  final double? textSize;

  final FontWeight? fontWeight;
  final int? maxLines;

  const AppBgImageButtonView({
    super.key,
    this.width,
    this.height,
    this.imageBg = "",
    this.fit,
    this.borderRadius,
    this.decoration,
    this.backgroundColor,
    this.border,
    this.text = "",
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: imageBg.isNotEmpty
          ? BoxDecoration(
              borderRadius: borderRadius,
              color: backgroundColor,
              border: border,
              image: DecorationImage(
                image: AssetImage(imageBg),
                fit: fit,
              ),
            )
          : decoration ?? const BoxDecoration(),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: textSize,
          fontWeight: fontWeight,
        ),
        maxLines: maxLines ?? 1,
      ),
    );
  }
}
