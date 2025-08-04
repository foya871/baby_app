import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/image_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/play/video_info_model.dart';
import '../../../utils/color.dart';
import '../../../utils/utils.dart';

class HomeRankCell extends StatelessWidget {
  final MapEntry<int, VideoInfoModel> v;
  HomeRankCell(this.v);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, left: 15.w, right: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageView(
                src: v.value.coverImg ?? '',
                height: 194.w,
                width: 345.w,
                borderRadius: BorderRadius.circular(10.w),
              ),
              Positioned(
                left: 10.w,
                child: Visibility(
                  visible: v.key < 2,
                  child: ImageView(
                    src: v.key == 0
                        ? AppImagePath.home_ic_rank_first
                        : AppImagePath.home_ic_rank_second,
                    width: 25.w,
                  ),
                ),
              ),
              Positioned(
                bottom: 5.h,
                left: 10.w,
                right: 10.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      Utils.secondsToTime(v.value.playTime),
                      style: TextStyle(fontSize: 12.sp, color: COLOR.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5.w),
          Text(
            v.value.title ?? '',
            style: TextStyle(fontSize: 13.w, color: COLOR.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          3.verticalSpaceFromWidth,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                ImageView(src: AppImagePath.home_ic_grey_time, width: 12.w),
                SizedBox(width: 3.w),
                Text(Utils.formatTime(v.value.createdAt ?? ''),
                    style:
                        TextStyle(fontSize: 12.w, color: COLOR.color_8e8e93)),
              ]),
              Row(
                children: [
                  ImageView(
                    src: AppImagePath.home_ic_grey_comment,
                    width: 12.r,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    '${v.value.commentNum ?? 0}',
                    style:
                        TextStyle(fontSize: 12.sp, color: COLOR.color_8e8e93),
                  ),
                ],
              ),
              Row(
                children: [
                  ImageView(
                    src: AppImagePath.home_ic_grey_play,
                    width: 12.r,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    Utils.numFmt(v.value.watchNum ?? 0),
                    style:
                        TextStyle(fontSize: 12.sp, color: COLOR.color_8e8e93),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ).onOpaqueTap(() => Get.toPlayVideo(videoId: v.value.videoId ?? 0));
  }
}
