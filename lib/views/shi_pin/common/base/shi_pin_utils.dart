import 'package:baby_app/components/ad/ad_enum.dart';
import 'package:baby_app/components/ad/ad_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/grid_view/heighted_grid_view.dart';
import '../../../../components/short_widget/video_base_or_ad_cell.dart';
import '../../../../model/video_base_model.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/enum.dart';

abstract class ShiPinUtils {
  static void _onTapVerticalVideo(
      VideoBaseModel video, List<VideoBaseModel> models) {
    if (models.isEmpty) return;
    final index = models.indexWhere((e) => e.videoId == video.videoId);
    int idx = 0;
    if (index >= 0) idx = index;
    // Get.toShortVideoPlay(models, idx: idx);
  }

  static Widget buildSilverLayoutVideos(
    List<VideoBaseModel> models, {
    required VideoLayout layout, // 布局 大、小
    bool isVerticalLayout = false, // 布局 横、竖
    required bool dataInited,
  }) {
    AdApiType place = AdApiType.INVALID;
    if (isVerticalLayout) {
      // if (layout == VideoLayout.big) {
      //   place = AdApiType.VIDEO_LIST_INSERT;
      // } else {
      //   place = AdApiType.VIDEO_LIST_INSERT;
      // }
    } else {
      if (layout == VideoLayout.big) {
        // place = AdApiType.VIDEO_WIDGET;
      } else {
        // place = AdApiType.VIDEO_WIDGET;
      }
    }
    final interval = AdUtils().interval(place);
    final isSmallLayout = layout == VideoLayout.small;
    if (isVerticalLayout) {
      return HeightedGridView.sliver(
        crossAxisCount: isSmallLayout ? 3 : 2,
        itemCount: AdUtils().withAdLength(models.length, interval: interval),
        rowMainAxisAlignment: isSmallLayout
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        columnSpacing: isSmallLayout ? 7.4.w : null,
        itemBuilder: (ctx, i) {
          return SizedBox.shrink();
          // final model = AdUtils.modelByBuildIndex(
          //   i,
          //   models: models,
          //   interval: interval,
          //   place: place,
          // );
          // return isSmallLayout
          //     ? VideoBaseOrAdCell.smallVertical(
          //         model,
          //         onTapVideo: () => _onTapVerticalVideo(model, models),
          //       )
          //     : VideoBaseOrAdCell.bigVertical(
          //         model,
          //         onTapVideo: () => _onTapVerticalVideo(model, models),
          //       );
        },
        noData: dataInited,
        rowSepratorBuilder: (ctx, i) => 10.verticalSpaceFromWidth,
      );
    } else {
      return HeightedGridView.sliver(
        crossAxisCount: isSmallLayout ? 2 : 1,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        itemCount: AdUtils().withAdLength(models.length, interval: interval),
        itemBuilder: (ctx, i) {
          return SizedBox.shrink();
          // final model = AdUtils.modelByBuildIndex(
          //   i,
          //   models: models,
          //   interval: interval,
          //   place: place,
          // );
          // return isSmallLayout
          //     ? VideoBaseOrAdCell.small(model)
          //     : VideoBaseOrAdCell.big(model);
        },
        noData: dataInited,
        rowSepratorBuilder: (ctx, i) => 10.verticalSpaceFromWidth,
      );
    }
  }
}
