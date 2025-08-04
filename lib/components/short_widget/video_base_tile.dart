import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../assets/styles.dart';
import '../../generate/app_image_path.dart';
import '../../model/video_base_model.dart';
import '../../utils/color.dart';
import '../../utils/utils.dart';
import '../image_view.dart';
import 'video_duration_cell.dart';

class VideoBaseTile extends StatelessWidget {
  final VideoBaseModel video;
  final int? rank;
  final VoidCallback? onTap;

  const VideoBaseTile(this.video, {this.rank, super.key, this.onTap});

  VideoBaseTile.fromIndex(VideoBaseModelWithIndex v, {super.key, this.onTap})
      : video = v.video,
        rank = v.rank;

  String _getRankBg(int rank) => switch (rank) {
        1 => AppImagePath.shi_pin_rank1,
        2 => AppImagePath.shi_pin_rank2,
        3 => AppImagePath.shi_pin_rank3,
        _ => AppImagePath.shi_pin_rank,
      };

  Widget _buildRank() => Container(
        width: 20.w,
        height: 20.w,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(_getRankBg(rank!))),
        ),
        alignment: Alignment.center,
        child: Text(
          '$rank',
          style: TextStyle(
            color: COLOR.white,
            fontWeight: FontWeight.w600,
            fontSize: 14.w,
          ),
        ),
      );

  Widget _buildDuration() => Container(
        // decoration: BoxDecoration(
        //     color: COLOR.black.withOpacity(0.5),
        //     borderRadius: Styles.borderRadius.all(2.w)),
        alignment: Alignment.center,
        child: VideoDurationCell(playTime: video.playTime),
      );

  Widget _buildLeft() => Stack(
        children: [
          ImageView(
            src: video.hCover,
            width: 162.w,
            height: 90.w,
            borderRadius: Styles.borderRadius.all(8.w),
          ),
          if (rank != null) Positioned(left: 15.w, child: _buildRank()),
          Positioned(bottom: 6.w, right: 6.w, child: _buildDuration()),
        ],
      );

  Widget _buildRight() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            video.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: const Color(0xff18191c), fontSize: 13.w),
          ),
          Row(
            children: [
              Text(
                '${Utils.numFmt(video.fakeWatchNum ?? 0)}播放',
                style: TextStyle(
                  color: const Color(0xff676c73),
                  fontSize: 12.sp,
                ),
              ),
              10.horizontalSpace,
              Text(
                '${Utils.numFmt(video.fakeLikes ?? 0)}喜欢',
                style: TextStyle(
                  color: const Color(0xff676c73),
                  fontSize: 12.sp,
                ),
              ),
            ],
          )
        ],
      );

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          children: [
            _buildLeft(),
            8.horizontalSpace,
            Expanded(child: _buildRight().marginVertical(4.w)),
          ],
        ).onOpaqueTap(() {
          if (onTap == null) {
            Get.toPlayVideo(videoId: video.videoId ?? 0);
          } else {
            onTap!();
          }
        }),
      );
}
