import 'package:baby_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/no_more/no_data.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/model/play/cdn_model.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/views/player/controllers/video_play_controller.dart';
import 'package:baby_app/views/player/views/av_player_loading.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import '../../../components/easy_button.dart';
import '../../../components/text_view.dart';
import '../../../http/api/api.dart';

class ChooseLineView extends StatelessWidget {
  final VideoPlayController controller;
  final ValueCallback<CdnRsp>? onTap;
  const ChooseLineView({
    super.key,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Api.fetchCdnLines(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: Get.width,
              height: 300.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.w),
                  topRight: Radius.circular(10.w),
                ),
              ),
              child: const AvPlayerLoading(),
            );
          }
          if (snapshot.hasError || snapshot.data?.isEmpty == true) {
            return Container(
              width: Get.width,
              height: 300.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.w),
                  topRight: Radius.circular(10.w),
                ),
              ),
              child: const NoData(),
            );
          }
          final items = snapshot.data!;
          return Container(
            width: Get.width,
            height: 300.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.w),
                topRight: Radius.circular(10.w),
              ),
            ),
            child: Column(
              children: [
                17.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 18.w),
                    Expanded(
                      child: TextView(
                        text: "选择线路",
                        fontSize: 17.w,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Image.asset(
                      AppImagePath.player_close,
                      width: 18.w,
                      height: 18.w,
                    ).onTap(() => Get.back())
                  ],
                ).paddingHorizontal(14.w),
                20.verticalSpace,
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.w,
                  children: items.map((e) {
                    final isme = controller.video.value.cdnRes?.id == e.id;
                    final bgColor = isme
                        ? COLOR.themeSelectedColor
                        : Colors.white.withValues(alpha: 0.1);
                    return EasyButton(
                      e.line ?? '',
                      borderRadius: BorderRadius.circular(6.w),
                      width: (Get.width - 52.w) / 3.0,
                      height: 40.w,
                      backgroundColor: bgColor,
                      textStyle: kTextStyle(Colors.white, fontsize: 13.w),
                      onTap: () => onTap?.call(e),
                    );
                  }).toList(),
                ).baseMarginHorizontal,
              ],
            ),
          );
        });
  }
}
