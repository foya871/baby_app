import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:baby_app/model/announcement/activity_model.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import '../../utils/ad_jump.dart';
import '../image_view.dart';

class VerticalGroupActs extends StatelessWidget {
  final List<ActivityModel> models;
  final VoidCallback? dismiss;
  const VerticalGroupActs({
    super.key,
    required this.models,
    this.dismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.w,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
                maxHeight: 460.w, minWidth: 330.w, maxWidth: 330.w),
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 5.w,
                children: models
                    .map((e) => ImageView(
                          src: e.coverPicture ?? '',
                          width: 330.w,
                          height: 150.w,
                          borderRadius: BorderRadius.circular(5.w),
                        ).onTap(
                          () => jumpExternalURL(
                            e.actUrl ?? '',
                            adId: e.id,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          10.verticalSpaceFromWidth,
          Icon(
            size: 40.w,
            Icons.cancel,
            color: Colors.white,
          ).onTap(dismiss)
        ],
      ),
    );
  }
}
