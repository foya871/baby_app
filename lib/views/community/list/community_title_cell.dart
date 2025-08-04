import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/model/community/community_model.dart';
import 'package:baby_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityTitleCell extends StatelessWidget {
  const CommunityTitleCell({
    super.key,
    required this.model,
  });

  final CommunityModel model;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <InlineSpan>[
          if (model.topDynamic == true)
            WidgetSpan(
              child: Container(
                width: 32.w,
                height: 18.w,
                alignment: Alignment.center,
                child: Image.asset(
                  AppImagePath.community_top,
                  width: 32.w,
                  height: 18.w,
                ),
              ),
              alignment: PlaceholderAlignment.middle,
            ),
          if (model.topDynamic == true)
            WidgetSpan(
              child: SizedBox(
                width: 5.w,
              ),
            ),
          TextSpan(
            text: model.title ?? '',
            style: TextStyle(
              color: COLOR.white,
              fontSize: 13.w,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
