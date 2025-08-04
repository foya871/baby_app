import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color.dart';
import '../../utils/utils.dart';

class VideoDurationCell extends StatelessWidget {
  final int? playTime;

  const VideoDurationCell({super.key, required this.playTime});
  @override
  Widget build(BuildContext context) {
    final text = Utils.secondsToTime(playTime);
    final textStyle = TextStyle(
      color: COLOR.white,
      fontSize: 10.w,
    );
    return Text(text, style: textStyle);
  }
}
