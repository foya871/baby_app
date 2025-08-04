import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  Widget? title;
  String? titleText;
  double? titleSpacing;
  List<Widget>? actions;
  PreferredSizeWidget? bottom;
  double? elevation;
  bool? primary;
  bool? isShowBottomLine;
  Color? backgroundColor;

  AppBarView({
    this.title,
    this.titleText,
    this.titleSpacing,
    this.actions,
    this.elevation,
    this.bottom,
    this.primary,
    this.isShowBottomLine,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: title ??
          Text(
            titleText ?? '',
            overflow: TextOverflow.ellipsis,
            style: kTextStyle(
              COLOR.black,
              fontsize: 17.w,
              weight: FontWeight.w600,
            ),
          ),
      titleSpacing: titleSpacing,
      actions: actions,
      bottom: isShowBottomLine == true
          ? PreferredSize(
              preferredSize: preferredSize,
              child: Divider(
                color: COLOR.color_F0F0F0,
                thickness: 1.h,
              ),
            )
          : bottom,
      elevation: elevation ?? 0,
      primary: primary ?? true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
