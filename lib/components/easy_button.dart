import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color.dart';

class EasyButton extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final Gradient? backgroundGradient;
  final double? width;
  final double? height;
  final Function? onTap;
  final Widget? child; // 如果不为空， text和textStyle不会生效
  final EdgeInsets? padding;
  final double? minWidth;
  final List<BoxShadow>? boxShadow;
  final double elevation;
  final bool noSplash;
  // loading
  final bool enableLoading;
  final double? loadingStrokeWidth;
  final double? loadingSize;
  final Color? loadingColor;

  const EasyButton(
    this.text, {
    super.key,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.backgroundGradient,
    this.height,
    this.width,
    this.onTap,
    this.padding,
    this.minWidth,
    this.boxShadow,
    this.elevation = .0,
    this.noSplash = false,
    this.enableLoading = true,
    this.loadingStrokeWidth,
    this.loadingSize,
    this.loadingColor,
  }) : child = null;

  const EasyButton.child(
    this.child, {
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.backgroundGradient,
    this.height,
    this.width,
    this.onTap,
    this.padding,
    this.minWidth,
    this.boxShadow,
    this.elevation = .0,
    this.noSplash = false,
    this.enableLoading = true,
    this.loadingStrokeWidth,
    this.loadingSize,
    this.loadingColor,
  })  : text = '',
        textStyle = null;

  @override
  State<EasyButton> createState() => _EasyButtonState();
}

class _EasyButtonState extends State<EasyButton> {
  bool _isLoading = false;

  void _onTapWrapper() async {
    if (widget.onTap == null) return;
    final r = widget.onTap!();
    if (!widget.enableLoading) return;
    if (_isLoading) return;
    if (r is Future) {
      setState(() {
        _isLoading = true;
      });
      try {
        await r;
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    late final BorderSide borderSide;
    if (widget.borderColor != null) {
      borderSide = BorderSide(
          color: widget.borderColor!, width: widget.borderWidth ?? 0.5.w);
    } else {
      borderSide = BorderSide.none;
    }
    final buttonChild =
        widget.child ?? Text(widget.text, style: widget.textStyle);

    return Container(
      width: widget.width,
      height: widget.height ?? 30.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: widget.backgroundGradient,
        borderRadius: widget.borderRadius,
        color: widget.backgroundColor,
        boxShadow: widget.boxShadow,
      ),
      child: MaterialButton(
        onPressed: widget.onTap != null ? _onTapWrapper : null,
        minWidth: widget.minWidth,
        padding: widget.padding ?? EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: widget.backgroundColor,
        splashColor: widget.noSplash ? Colors.transparent : null,
        highlightColor: widget.noSplash ? Colors.transparent : null,
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
          side: borderSide,
        ),
        elevation: widget.elevation,
        child: _isLoading
            ? SizedBox(
                width: widget.loadingSize ?? 20.w,
                height: widget.loadingSize ?? 20.w,
                child: CircularProgressIndicator(
                  color: widget.loadingColor ?? COLOR.loading,
                  strokeWidth: widget.loadingStrokeWidth ?? 2.w,
                ),
              )
            : buttonChild,
      ),
    );
  }
}
