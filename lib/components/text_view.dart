import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String text; // 要显示的文本内容
  final TextStyle? style; // 文本样式
  final double? fontSize; // 文本字体大小
  final Color? color; // 文本颜色
  final TextDecoration? decoration; // 文本装饰
  final Color? decorationColor; // 装饰颜色
  final FontWeight? fontWeight; // 字体粗细
  final double? textHeight; // 行高
  final TextLeadingDistribution? leadingDistribution; // 行高分布
  final double? wordSpacing; // 单词间距
  final List<Shadow>? shadows; // 文本阴影
  final StrutStyle? strutStyle; // Strut 样式
  final TextAlign? textAlign; // 文本对齐方式
  final TextDirection? textDirection; // 文本方向
  final Locale? locale; // 区域设置
  final bool? softWrap; // 是否自动换行
  final TextOverflow? overflow; // 文本溢出处理方式
  final int? maxLines; // 最大行数
  final TextScaler? textScaler; // 文本缩放因子
  final bool? forceStrutHeight; // 是否强制使用 Strut 样式的高度
  final String? fontFamily; //  字体名称

  const TextView({
    super.key,
    required this.text,
    this.style,
    this.fontSize,
    this.color,
    this.decoration,
    this.decorationColor,
    this.fontWeight,
    this.textHeight,
    this.leadingDistribution,
    this.wordSpacing,
    this.shadows,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.fontFamily,
    this.forceStrutHeight,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = _getEffectiveTextStyle();
    final effectiveStrutStyle = _getEffectiveStrutStyle();

    return Text(
      text,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textScaler: textScaler,
      style: effectiveStyle,
      strutStyle: effectiveStrutStyle,
    );
  }

  /// 获取有效的文本样式
  TextStyle _getEffectiveTextStyle() {
    return (style ?? const TextStyle()).copyWith(
      fontSize: fontSize,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      fontWeight: fontWeight,
      height: textHeight,
      leadingDistribution: leadingDistribution,
      wordSpacing: wordSpacing,
      shadows: shadows,
      fontFamily: fontFamily,
    );
  }

  /// 获取有效的 Strut 样式
  StrutStyle _getEffectiveStrutStyle() {
    return strutStyle ??
        StrutStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: textHeight,
          forceStrutHeight: forceStrutHeight ?? false,
        );
  }
}
