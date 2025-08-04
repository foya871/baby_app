import 'package:flutter/material.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

class VideoLayoutButton extends StatelessWidget {
  final VideoLayout layout;
  final String text;
  final VoidCallback onTap;

  const VideoLayoutButton(this.layout,
      {super.key, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          layout == VideoLayout.small
              ? AppImagePath.shi_pin_layout_small
              : AppImagePath.shi_pin_layout_big,
          width: 15.w,
          height: 14.w,
        ),
        4.horizontalSpace,
        Text(
          text,
          style: TextStyle(fontSize: 12.w, color: COLOR.color_808080),
        )
      ],
    ).onTap(onTap);
  }
}
