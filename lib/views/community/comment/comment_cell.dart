import 'package:baby_app/components/circle_image.dart';
import 'package:baby_app/model/comment/comment_dynamic_model.dart';
import 'package:baby_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommentCell extends StatefulWidget {
  const CommentCell({
    super.key,
    required this.model,
    required this.nickName,
  });

  final CommentDynamicModel model;
  final String nickName;

  @override
  State createState() => _CommentCellState();
}

class _CommentCellState extends State<CommentCell> {
  @override
  Widget build(BuildContext context) {
    var vipType = widget.model.vipType ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleImage.network(
              widget.model.logo ?? '',
              size: 36.w,
            ),
            Row(
              children: <Widget>[
                Text(
                  widget.model.nickName ?? '',
                  style: TextStyle(
                    color: COLOR.white,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ).marginOnly(left: 8.w),
          ],
        ),
        Text(
          '回复 ${widget.nickName}：${widget.model.content}',
          style: TextStyle(
            color: COLOR.white_60,
            fontSize: 14.w,
            height: 1.5,
          ),
        ).marginOnly(top: 4.w, left: 44.w),
      ],
    ).marginOnly(left: 14.w, right: 14.w, bottom: 20.w);
  }
}
