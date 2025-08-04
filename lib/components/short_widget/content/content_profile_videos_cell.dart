import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import '../../../model/content_model.dart';
import '../../../routes/routes.dart';
import '../../../utils/color.dart';
import '../../../utils/extension.dart';
import '../../circle_image.dart';
import '../../easy_button.dart';
import 'content_video_base_cell.dart';

class ContentProfileVideosCell extends StatelessWidget {
  final ContentBaseModel model;
  final EdgeInsets? profilePadding;

  const ContentProfileVideosCell(this.model, {super.key, this.profilePadding});

  Widget _buildProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleImage.network(model.headImg, size: 40.w),
            9.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.contentName,
                  style: TextStyle(
                    fontSize: 14.w,
                    color: COLOR.color_DDDDDD,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${model.videoNum}部影片',
                  style: TextStyle(
                    fontSize: 10.w,
                    color: COLOR.color_808080,
                  ),
                ),
              ],
            )
          ],
        ),
        EasyButton(
          '进入详情',
          width: 66.w,
          height: 24.w,
          borderColor: COLOR.color_DDDDDD,
          borderRadius: Styles.borderRadius.all(12.w),
          textStyle: TextStyle(color: COLOR.color_DDDDDD, fontSize: 12.w),
        )
      ],
    ).onOpaqueTap(() {});
  }

  Widget _buildVideos() {
    return SizedBox(
      height: ContentVideoBaseCell.height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: model.videos.length,
        itemBuilder: (ctx, i) => ContentVideoBaseCell.small(model.videos[i]),
        separatorBuilder: (ctx, i) => SizedBox(width: 6.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _buildProfile().padding(profilePadding),
          12.verticalSpaceFromWidth,
          _buildVideos(),
        ],
      );
}
