import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InkwellButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final Widget child;
  const InkwellButton({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
    this.borderRadius,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = TextButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.zero,
        side: borderSide ?? BorderSide.none,
      ),
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: Size(width ?? double.infinity, height ?? 40.w),
    );
    return TextButton(onPressed: onTap, style: buttonStyle, child: child);
  }
}
