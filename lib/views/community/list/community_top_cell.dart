import 'package:baby_app/components/circle_image.dart';
import 'package:baby_app/model/community/community_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommunityTopCell extends StatefulWidget {
  const CommunityTopCell({
    super.key,
    required this.model,
  });

  final CommunityModel model;

  @override
  State createState() => _CommunityTopCellState();
}

class _CommunityTopCellState extends State<CommunityTopCell> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleImage.network(
              widget.model.logo ?? '',
              size: 40.w,
            ).onOpaqueTap(() {
              Get.toBloggerDetail(userId: widget.model.userId ?? 0);
            }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      widget.model.nickName ?? '',
                      style: TextStyle(
                        color: COLOR.white,
                        fontSize: 13.w,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  Utils.dateFmt(
                    widget.model.checkAt ?? '',
                    ['yyyy', '.', 'mm', '.', 'dd'],
                  ),
                  style: TextStyle(
                    color: COLOR.color_999999,
                    fontSize: 12.w,
                  ),
                ),
              ],
            ).marginOnly(left: 8.w),
          ],
        ),
      ],
    );
  }
}
