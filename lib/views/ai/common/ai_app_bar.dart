import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../routes/routes.dart';
import '../../../utils/extension.dart';

class AiAppBar extends AppBar {
  static List<Widget> buildActions() => [
        Text(
          '记录',
          style: TextStyle(
            fontSize: 15.w,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ).baseMarginR.onTap(() => Get.toNamed(Routes.aiRecord)),
      ];

  AiAppBar({super.key, String? title, bool actions = true})
      : super(
          title: Text(
            title ?? 'AI生成，满足你的性幻想',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17.w,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: actions ? buildActions() : null,
        );
}
