/*
 * @Author: wangdazhuang
 * @Date: 2025-02-22 13:58:01
 * @LastEditTime: 2025-02-26 20:05:04
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/views/forbidden/forbidden_page.dart
 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/home/home_page.dart';

import '../../services/user_service.dart';

class ForbiddenPage extends StatelessWidget {
  const ForbiddenPage({super.key});

  Widget _buildMask() => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Container(
          alignment: Alignment.center,
          color: Colors.black.withValues(alpha: 0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  AppImagePath.home_forbidden_buy_bg,
                  width: 312.w,
                  height: 317.w,
                ),
              ),
              Center(
                child: Image.asset(
                  AppImagePath.home_forbidden_bug_now,
                  width: 134.w,
                  height: 44.w,
                ),
              )
            ],
          ).onTap(Get.toVip)));

  Widget _buildBody() => Stack(
        children: [
          HomePage(forbidden: true),
          Obx(
            () {
              final ok = Get.find<UserService>().isForbiddenVip;
              if (!ok) {
                return _buildMask();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: _buildBody(),
      );
}
