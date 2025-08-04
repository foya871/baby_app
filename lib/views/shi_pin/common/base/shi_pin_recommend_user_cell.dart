import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/model/user/user_info_model.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../components/circle_image.dart';
import '../../../../model/attention/attenion_models.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';

class ShiPinRecommendUserCell extends StatelessWidget {
  static final double width = 50.w;
  static final double height = 72.w;
  final UserInfo model;

  const ShiPinRecommendUserCell(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          CircleImage.network(model.logo, size: width),
          3.verticalSpaceFromWidth,
          Text(
            model.nickName ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: COLOR.color_808080, fontSize: 12.w),
          )
        ],
      ),
    ).onTap(() {
      {}
    });
  }
}
