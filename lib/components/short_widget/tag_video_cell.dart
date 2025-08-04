/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-27 20:11:16
 * @LastEditors: wangdazhuang
 * @LastEditTime: 2024-10-11 17:03:58
 * @FilePath: /baby_app/lib/src/components/short_widget/tag_video_cell.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/easy_button.dart';
import 'package:baby_app/model/video_base_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TagVideoCell extends StatelessWidget {
  final VideoBaseModel video;
  const TagVideoCell({super.key, required this.video});

  Widget _buildDuration(int duration) {
    final text = Utils.secondsToTime(duration);
    final textStyle = TextStyle(
      fontSize: Styles.fontSize.xs,
      color: Styles.color.whiteText,
    );
    return Positioned(
      bottom: 6.w,
      right: 6.w,
      child: EasyButton.child(
        Text(text, style: textStyle),
        height: 16.w,
        minWidth: 40.w,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        borderRadius: Styles.borderRaidus.xs,
        backgroundColor: Styles.color.whiteTextOpacityBg,
      ),
    );
  }

  Widget _buildPayType(String text) {
    final textStyle = TextStyle(
      fontSize: Styles.fontSize.xs,
      color: Styles.color.whiteText,
    );
    return Positioned(
      top: 6.w,
      right: 6.w,
      child: EasyButton.child(
        Text(text, style: textStyle),
        height: 16.w,
        minWidth: 32.w,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        borderRadius: Styles.borderRaidus.xs,
        backgroundGradient: Styles.gradient.pinkToBule,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (video.videoId != null) {
          Get.toPlayVideo(videoId: video.videoId!);
        }
      },
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 150.w,
                height: 100.w,
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6.w)),
                child: ImageView(
                  src: video.coverImg?[0] ?? '',
                  fit: BoxFit.fill,
                ),
              ),
              _buildDuration(video.playTime ?? 0),
              video.price! > 0
                  ? _buildPayType('${video.price}金币')
                  : const SizedBox.shrink()
            ],
          ),
          Padding(padding: EdgeInsets.only(right: 8.w)),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${video.title}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13.w, color: Colors.white),
              ),
              Wrap(
                  children: video.tagTitles!.isNotEmpty
                      ? video.tagTitles!.map((v) {
                          return Container(
                            margin: EdgeInsets.only(right: 6.w, top: 7.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 6.w),
                            decoration: BoxDecoration(
                                color: COLOR.hexColor('#ffffff'),
                                borderRadius: BorderRadius.circular(16.w)),
                            child: Text(v),
                          );
                        }).toList()
                      : [])
            ],
          ))
        ],
      ),
    );
  }
}
