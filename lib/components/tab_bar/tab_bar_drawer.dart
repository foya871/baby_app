import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../utils/color.dart';

class TabBarDrawer extends StatelessWidget {
  final List<String> tabString;
  final int Function() selectedIndexGetter;
  final ValueCallback<int>? onTap;
  const TabBarDrawer(
    this.tabString, {
    super.key,
    this.onTap,
    required this.selectedIndexGetter,
  });

  Widget _buildDrawer() {
    return SafeArea(
      child: Drawer(
        width: 200.w,
        shape: const Border(),
        backgroundColor: const Color(0xff343439),
        child: Container(
          color: const Color(0xff343439),
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: kIsWeb ? 15.w : 54.w,
          ),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '导航列表',
                  style: TextStyle(
                    color: COLOR.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.w,
                  ),
                ),
              ),
              SizedBox(height: 4.w),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 20.w,
                  child: DefaultDivider(
                    thickness: 3.w,
                    color: const Color(0xffdd001b),
                  ),
                ),
              ),
              SizedBox(height: 25.w),
              Wrap(
                spacing: 12.w,
                runSpacing: 24.w,
                children: tabString.mapIndexed((i, e) {
                  return Builder(builder: (context) {
                    return Container(
                      alignment: Alignment.center,
                      width: 82.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w),
                        color: i == selectedIndexGetter()
                            ? const Color(0xfff62443)
                            : const Color(0xff292933),
                      ),
                      child: Text(
                        e,
                        style: TextStyle(
                          color: COLOR.white,
                          fontSize: 13.w,
                          fontWeight: i == selectedIndexGetter()
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    ).onTap(() => onTap?.call(i));
                  });
                }).toList(),
              ),
            ],
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(color: Styles.color.transparent),
          ),
        ),
        _buildDrawer(),
      ],
    );
  }
}
