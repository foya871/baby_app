import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/image_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/search/search_video_result_model.dart';
import '../../../utils/color.dart';
import '../../../utils/utils.dart';

class HomeHorizontalVideoCell extends StatelessWidget {
  final double width;
  final SearchVideoResultModel model;

  const HomeHorizontalVideoCell({required this.width, required this.model});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Stack(
            children: [
              ImageView(
                src: model.coverImg ?? "",
                width: width,
                height: 85.w,
                borderRadius: BorderRadius.circular(5.w),
              ),
              Positioned(
                bottom: 5.w,
                left: 3.w,
                right: 3.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ImageView(
                          src: AppImagePath.home_ic_white_play,
                          width: 12.w,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          Utils.numFmt(model.watchNum ?? 0),
                          style: TextStyle(fontSize: 11.sp, color: COLOR.white),
                        ),
                      ],
                    ),
                    Text(
                      Utils.secondsToTime(model.playTime),
                      style: TextStyle(fontSize: 11.sp, color: COLOR.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.w,
          ),
          Text(
            model.title ?? "",
            style: TextStyle(
              fontSize: 13.w,
              color: COLOR.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
