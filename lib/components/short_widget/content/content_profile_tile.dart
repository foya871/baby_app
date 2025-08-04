import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import '../../../model/content_model.dart';
import '../../../utils/color.dart';
import '../../image_view.dart';

class ContentProfileTile extends StatelessWidget {
  final ContentHotModel model;

  const ContentProfileTile(this.model, {super.key});

  Widget _buildLeft() => ImageView(
        src: model.headImg,
        width: 60.w,
        height: 60.w,
        borderRadius: Styles.borderRadius.all(6.w),
      );

  Widget _buildRight() => Container(
        margin: EdgeInsets.symmetric(vertical: 2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.contentName,
              style: TextStyle(
                color: COLOR.color_DDDDDD,
                fontSize: 13.w,
                fontWeight: FontWeight.w500,
              ),
            ),
            5.verticalSpaceFromWidth,
            Text(
              model.info,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: COLOR.color_808080, fontSize: 10.w),
            ),
            3.verticalSpaceFromWidth,
            Text(
              '作品：${model.videoNum}  |  粉丝： ${model.fakeBuNum}',
              style: TextStyle(color: COLOR.color_808080, fontSize: 10.w),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Row(
        children: [
          _buildLeft(),
          8.horizontalSpace,
          Expanded(child: _buildRight()),
        ],
      ).onOpaqueTap(() {});
}
