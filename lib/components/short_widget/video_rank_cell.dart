import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generate/app_image_path.dart';
import '../../utils/color.dart';

class VideoRankCell extends StatelessWidget {
  final int rank;

  const VideoRankCell(this.rank, {super.key});
  @override
  Widget build(BuildContext context) {
    String bg = AppImagePath.shi_pin_rank;
    if (rank == 1) {
      bg = AppImagePath.shi_pin_rank1;
    } else if (rank == 2) {
      bg = AppImagePath.shi_pin_rank2;
    } else if (rank == 3) {
      bg = AppImagePath.shi_pin_rank3;
    }

    return Container(
      width: 52.w,
      height: 19.w,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bg)),
      ),
      child: Center(
        child: Text(
          'TOP$rank',
          style: TextStyle(
            color: COLOR.primaryText,
            fontSize: 12.w,
          ),
        ),
      ),
    );
  }
}
