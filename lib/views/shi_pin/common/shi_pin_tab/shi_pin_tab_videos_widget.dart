import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../components/ad_banner/ad_banner.dart';
import '../../../../components/base_refresh/base_refresh_share_tab_widget.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/extension.dart';
import '../base/shi_pin_rank_entry_cell.dart';
import '../base/shi_pin_sort_tab_bar.dart';
import '../base/shi_pin_tag_cell.dart';
import '../base/shi_pin_utils.dart';
import 'shi_pin_tab_base_widget.dart';
import 'shi_pin_tab_videos_controller.dart';

class ShiPinTabVideosWidget extends ShiPinTabBaseWidget {
  const ShiPinTabVideosWidget({super.key, required super.controllerTag});

  Widget _buildTagsTitleRow(ShiPinTabVideosController _) => Obx(
        () {
          if (_.tags.isEmpty) return const SizedBox.shrink();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('标签筛选',
                  style: TextStyle(
                      fontSize: 16.w, color: const Color(0xff18191c))),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('全部标签', style: TextStyle(fontSize: 16.w)),
                  // Image.asset(
                  //   AppImagePath.ic_right_arrow,
                  //   width: 14.w,
                  //   height: 14.w,
                  // )
                ],
              )
            ],
          ).onOpaqueTap(() {});
        },
      );

  Widget _buildTags(ShiPinTabVideosController _) => Obx(
      () => StaggeredGrid.count(
            mainAxisSpacing: 10.w,
            crossAxisSpacing: 10.w,
            crossAxisCount: 6,
            children: _.tags
                .map(
                  (e) => ShiPinTagCell(
                    e,
                    onTap: () => _.onTapTag(e.tagsId),
                    selectedId:
                        _.selectedTagIds.isEmpty ? null : _.selectedTagIds[0],
                  ),
                )
                .toList(),
          )
      // () => Wrap(
      //   spacing: 10.w,
      //   runSpacing: 10.w,
      //   alignment: WrapAlignment.start,
      //   runAlignment: WrapAlignment.start,
      //   children: _.tags
      //       .map(
      //         (e) => ShiPinTagCell(
      //           e,
      //           onTap: () => _.onTapTag(e.tagsId),
      //           selectedId:
      //               _.selectedTagIds.isEmpty ? null : _.selectedTagIds[0],
      //         ),
      //       )
      //       .toList(),
      // ),
      );

  Widget _buildSliverVideos(ShiPinTabVideosController _) {
    return Obx(() {
      final models = _.getCurrentData<VideoBaseModel>();
      final dataInited = _.currentDataInited;
      final isShort = _.classify.isShort;
      return ShiPinUtils.buildSilverLayoutVideos(
        models,
        layout: isShort ? VideoLayout.big : VideoLayout.small, // 没有改变布局按钮
        isVerticalLayout: isShort,
        dataInited: dataInited,
      );
    });
  }

  Widget _buildBody(ShiPinTabVideosController _) {
    return BaseRefreshShareTabWidget(
      _,
      child: CustomScrollView(
        slivers: [
          const AdBanner.index().baseMarginHorizontal.sliver,
          14.verticalSpaceFromWidth.sliver,
          ShiPinRankEntryCell(_.classify).baseMarginHorizontal.sliver,
          14.verticalSpaceFromWidth.sliver,
          _buildTagsTitleRow(_).baseMarginHorizontal.sliver,
          10.verticalSpaceFromWidth.sliver,
          _buildTags(_).baseMarginHorizontal.sliver,
          14.verticalSpaceFromWidth.sliver,
          ShiPinSortTabBar(
            controller: _,
            tabController: _.tabContorller,
          ).sliver,
          14.verticalSpaceFromWidth.sliver,
          _buildSliverVideos(_).sliverPaddingHorizontal(14.w),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _ = Get.find<ShiPinTabVideosController>(tag: controllerTag);
    return _buildBody(_);
  }
}
