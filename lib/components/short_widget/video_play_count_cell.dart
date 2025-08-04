import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color.dart';
import '../../utils/utils.dart';

class VideoPlayCountCell extends StatelessWidget {
  final int playCount;

  const VideoPlayCountCell({super.key, required this.playCount});

  @override
  Widget build(BuildContext context) {
    final text = '${Utils.numFmt(playCount)} 观看';
    final textStyle = TextStyle(
      color: COLOR.white,
      fontSize: 10.w,
    );
    return Text(text, style: textStyle);
  }
}
