import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/model/community/community_model.dart';
import 'package:baby_app/model/community/community_video_model.dart';
import 'package:baby_app/utils/color.dart';

class CommunityPictureCell extends StatelessWidget {
  CommunityPictureCell({
    super.key,
    required this.model,
  });

  final CommunityModel model;
  var pictures = <String>[];
  var hasVideo = false;
  var video = CommunityVideoModel.fromJson({});
  var coverImg = '';
  var num = 0;

  void setPicture() {
    if (model.images != null) {
      for (final image in model.images!) {
        pictures.add(image);
      }
    }

    final video = model.video;
    if (video != null) {
      hasVideo = true;
      coverImg = video.coverImg ?? '';
    }

    if (hasVideo) {
      if (pictures.length > 2) {
        num = pictures.length - 2;
        pictures = pictures.sublist(0, 2);
      }
      pictures.add(coverImg);
    } else {
      if (pictures.length > 3) {
        num = pictures.length - 2;
        pictures = pictures.sublist(0, 3);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setPicture();
    if (pictures.isEmpty) return const SizedBox.shrink();
    return pictures.length == 1
        ? Stack(
            children: <Widget>[
              ImageView(
                src: pictures[0],
                width: ScreenUtil().screenWidth,
                height: 194.w,
                borderRadius: Styles.borderRadius.xs,
              ),
              if (hasVideo)
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset(
                      AppImagePath.community_video_play,
                      width: 27.w,
                      height: 27.w,
                    ),
                  ),
                ),
              if (model.dynamicMark != 0)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Image.asset(
                    model.dynamicMark == 1
                        ? AppImagePath.community_vip_icon
                        : AppImagePath.community_gold_icon,
                    width: 36.w,
                    height: 16.w,
                    fit: BoxFit.fill,
                  ),
                ),
            ],
          ).marginOnly(top: 10.w)
        : Wrap(
            spacing: 5.w,
            runSpacing: 5.w,
            children: pictures.asMap().entries.map((e) {
              var index = e.key;
              return Stack(
                children: <Widget>[
                  ImageView(
                    src: e.value,
                    width: ((ScreenUtil().screenWidth - 38.w) / 3),
                    height: ((ScreenUtil().screenWidth - 38.w) / 3),
                    borderRadius: Styles.borderRadius.xs,
                  ),
                  if (index == pictures.length - 1 && hasVideo)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Image.asset(
                          AppImagePath.community_video_play,
                          width: 27.w,
                          height: 27.w,
                        ),
                      ),
                    ),
                  if ((index == pictures.length - 1) && num > 0)
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        width: 28.w,
                        height: 16.w,
                        decoration: BoxDecoration(
                          color: COLOR.translucent_50,
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: Center(
                          child: Text(
                            '+$num',
                            style: TextStyle(
                              color: COLOR.white,
                              fontSize: 13.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (index == pictures.length - 1 && model.dynamicMark != 0)
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Image.asset(
                        model.dynamicMark == 1
                            ? AppImagePath.community_vip_icon
                            : AppImagePath.community_gold_icon,
                        width: 36.w,
                        height: 16.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                ],
              );
            }).toList(),
          ).marginOnly(top: 10.w);
  }
}
