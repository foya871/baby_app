import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/easy_button.dart';
import 'package:baby_app/components/grid_view/heighted_grid_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/player/controllers/video_play_controller.dart';
import '../../../components/text_view.dart';

class ChooseSerialVideosView extends StatelessWidget {
  final VideoPlayController controller;
  final ValueCallback<int>? onTap;
  const ChooseSerialVideosView({
    super.key,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ids = controller.video.value.videoIds ?? [];

    return Container(
      width: Get.width,
      height: 500.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.w),
          topRight: Radius.circular(10.w),
        ),
      ),
      child: CustomScrollView(
        slivers: [
          17.verticalSpace.sliverBox,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 18.w),
              Expanded(
                child: TextView(
                  text: "剧集",
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
          ).paddingHorizontal(14.w).sliverBox,
          20.verticalSpace.sliverBox,
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            sliver: HeightedGridView.sliver(
              crossAxisCount: 6,
              itemCount: ids.length,
              columnSpacing: 14.w,
              rowMainAxisAlignment: MainAxisAlignment.start,
              itemBuilder: (context, index) {
                final itemW = (Get.width - 7 * 14.w) / 6.0;
                final itemH = 36.w;

                final isme = ids[index] == controller.video.value.videoId;
                final bgColor = isme
                    ? COLOR.themeSelectedColor
                    : Colors.white.withValues(alpha: 0.1);
                return EasyButton(
                  '${index + 1}',
                  backgroundColor: bgColor,
                  borderRadius: BorderRadius.circular(5.w),
                  width: itemW,
                  height: itemH,
                  textStyle: kTextStyle(Colors.white,
                      fontsize: 15.w, weight: FontWeight.bold),
                  onTap: () {
                    if (isme) return;
                    onTap?.call(ids[index]);
                  },
                );
              },
              rowSepratorBuilder: (context, index) => SizedBox(height: 14.w),
            ),
          )
        ],
      ),
    );
  }
}
