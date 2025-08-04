import 'package:flutter/material.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/utils/color.dart';

class VideoOfficialRecommendCell extends StatelessWidget {
  const VideoOfficialRecommendCell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
      decoration: BoxDecoration(
        borderRadius: Styles.borderRadius.diagonalUp(8.w),
        color: COLOR.color_B940FF,
      ),
      child: Text(
        '官方推荐',
        style: TextStyle(fontSize: 10.w),
      ),
    );
  }
}
