import 'package:baby_app/model/community/community_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/views/community/list/community_bottom_cell.dart';
import 'package:baby_app/views/community/list/community_picture_cell.dart';
import 'package:baby_app/views/community/list/community_title_cell.dart';
import 'package:baby_app/views/community/list/community_top_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

class CommunityCell extends StatelessWidget {
  const CommunityCell({
    super.key,
    required this.model,
  });

  final CommunityModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommunityTopCell(model: model).marginOnly(left: 14.w, right: 14.w),
        CommunityTitleCell(model: model)
            .marginOnly(left: 14.w, top: 8.w, right: 14.w),
        CommunityPictureCell(model: model).marginOnly(left: 14.w, right: 14.w),
        Row(
          children: [
            CommunityBottomCell(model: model)
                .marginOnly(left: 14.w, right: 14.w),
            Spacer(),
            if (model.topics != null && model.topics!.isNotEmpty)
              Text(
                "#${model.topics![0]}",
                style: const TextStyle(color: Colors.blueAccent),
              ).onOpaqueTap(() => Get.toNamed(
                    Routes.searchResult,
                    arguments: {
                      'keyWord': model.topics![0],
                    },
                  )),
            SizedBox(
              width: 14,
            ),
          ],
        ),
        Divider(
          color: COLOR.white_10,
          thickness: 1.w,
          height: 0.w,
        ).marginOnly(left: 14.w, right: 14.w),
      ],
    ).marginOnly(bottom: 10.w).onOpaqueTap(() {
      Get.toCommunityDetail(dynamicId: model.dynamicId ?? 0);
    });
  }
}
