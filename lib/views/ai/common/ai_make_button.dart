import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import '../../../components/easy_button.dart';
import '../../../utils/color.dart';

class AiMakeButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final double? width;
  final Color? textColor;
  final Color? backgroundColor;
  final double? gold;

  const AiMakeButton(
    this.text, {
    super.key,
    this.onTap,
    this.width,
    this.textColor,
    this.backgroundColor,
    this.gold,
  });

  Widget _buildBtn(
      {required BorderRadius borderRadius, required double height}) {
    Widget? goldPart;
    if (gold != null) {
      goldPart = Container(
        color: COLOR.white,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          '${gold!.toStringAsShort()}金币',
          style: TextStyle(
            color: COLOR.themeSelectedColor,
            fontSize: 15.w,
          ),
        ),
      );
    }

    final textPart = Container(
      color: backgroundColor,
      alignment: Alignment.center,
      // width: double.infinity,
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? COLOR.primaryText,
          fontSize: 15.w,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    final child = Row(
      children: [
        if (goldPart != null) Expanded(flex: 1, child: goldPart),
        Expanded(flex: 2, child: textPart),
      ],
    );
    return EasyButton.child(
      child,
      height: height,
      width: width,
      borderColor: COLOR.themeSelectedColor,
      backgroundColor: backgroundColor ?? COLOR.themeSelectedColor,
      borderRadius: borderRadius,
      borderWidth: 2.w,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) => _buildBtn(
        borderRadius: Styles.borderRadius.all(18.5.w),
        height: 42.w,
      );
}
