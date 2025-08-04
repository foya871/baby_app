/*
 * @Author: wangdazhuang
 * @Date: 2024-08-29 09:05:46
 * @LastEditTime: 2024-10-12 09:12:57
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/src/views/player/views/comment_sub_cell.dart
 */
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/circle_image.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/model/comment/comment_model.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentSubCell extends StatefulWidget {
  final CommentModel model;
  final void Function(CommentModel) tap;
  final void Function(CommentModel) likeTap;

  const CommentSubCell(
      {super.key,
      required this.model,
      required this.tap,
      required this.likeTap});

  @override
  State<StatefulWidget> createState() {
    return CommentSubCellState();
  }
}

class CommentSubCellState extends State<CommentSubCell> {
  _buildLogo() {
    return CircleImage.network(
      widget.model.logo,
      size: 25.w,
    );
  }

  _buildLikeAndReply() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() => Image.asset(
              widget.model.isLike.value
                  ? 'AppImagePath.community_like_s'
                  : 'AppImagePath.community_like',
              width: 18.w,
              height: 18.w,
            ).onOpaqueTap(() {
              widget.likeTap(widget.model);
            })),
        SizedBox(width: 8.w),
        Obx(() => Text(Utils.numFmt(widget.model.fakeLikes.value),
            style: kTextStyle(COLOR.color_A1A1A1, fontsize: 12.w))),
        Text('回复', style: kTextStyle(COLOR.color_A1A1A1, fontsize: 12.w))
            .marginLeft(20.w)
            .onOpaqueTap(() {
          widget.tap(widget.model);
        }),
      ],
    ).marginTop(15.w);
  }

  _buildRight() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
              text: widget.model.nickName, fontSize: 12.w, color: Colors.white),
          5.verticalSpace,
          TextView(
            text: "回复${widget.model.beUserName}:${widget.model.content}",
            fontSize: 12.w,
            color: Colors.white.withValues(alpha: 0.6),
          )
          // _buildLikeAndReply(),
        ],
      ).marginLeft(10.w),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogo(),
        _buildRight(),
      ],
    ).onTap(() {
      widget.tap(widget.model);
    }).marginBottom(13.w);
  }
}
