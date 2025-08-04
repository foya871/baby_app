import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/community/community_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/utils/utils.dart';

class CommunityBottomCell extends StatefulWidget {
  const CommunityBottomCell({
    super.key,
    required this.model,
  });

  final CommunityModel model;

  @override
  State createState() => _CommunityBottomCellState();
}

class _CommunityBottomCellState extends State<CommunityBottomCell> {
  Future communityFavorite(int dynamicId, bool isFavorite) async {
    final result = await Api.communityFavorite(
      dynamicId: dynamicId,
      isFavorite: isFavorite,
    );

    if (result) {
      setState(() {
        if (isFavorite == true) {
          widget.model.fakeFavorites = (widget.model.fakeFavorites! - 1);
        } else {
          widget.model.fakeFavorites = (widget.model.fakeFavorites! + 1);
        }
        widget.model.isFavorite = !isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var topic = '';
    var id = '';
    if (widget.model.topic != null) {
      topic = widget.model.topic!.name ?? '';
      id = widget.model.topic!.id ?? '';
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    AppImagePath.community_watch,
                    width: 20.w,
                    height: 20.w,
                  ),
                  Text(
                    Utils.numFmtCh(widget.model.fakeWatchTimes ?? 0),
                    style: TextStyle(
                      color: COLOR.white_50,
                      fontSize: 12.w,
                    ),
                  ).marginOnly(left: 2.w),
                ],
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    widget.model.isFavorite == true
                        ? AppImagePath.community_praise
                        : AppImagePath.community_praise_no,
                    width: 20.w,
                    height: 20.w,
                  ),
                  Text(
                    Utils.numFmtCh(widget.model.fakeFavorites ?? 0),
                    style: TextStyle(
                      color: COLOR.white_50,
                      fontSize: 12.w,
                    ),
                  ).marginOnly(left: 2.w),
                ],
              ).marginOnly(left: 20.w).onOpaqueTap(() {
                communityFavorite(widget.model.dynamicId ?? 0,
                    widget.model.isFavorite ?? false);
              }),
              Row(
                children: <Widget>[
                  Image.asset(
                    AppImagePath.community_comment,
                    width: 20.w,
                    height: 20.w,
                  ),
                  Text(
                    Utils.numFmtCh(widget.model.commentNum ?? 0),
                    style: TextStyle(
                      color: COLOR.white_50,
                      fontSize: 12.w,
                    ),
                  ).marginOnly(left: 2.w),
                ],
              ).marginOnly(left: 20.w),
            ],
          ),
          if (topic != '')
            Text(
              '#$topic',
              style: TextStyle(
                color: COLOR.color_009FE8,
                fontSize: 13.w,
              ),
            ).onOpaqueTap(() {
              Get.toTopicDetail(topic: topic, id: id);
            }),
        ],
      ),
    );
  }
}
