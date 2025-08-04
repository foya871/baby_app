/*
 * @Author: wangdazhuang
 * @Date: 2025-01-16 09:35:38
 * @LastEditTime: 2025-01-30 15:59:29
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/views/shi_pin/views/station/station_detail_with_ranking_page.dart
 */
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../components/background_app_bar.dart';
import '../../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../../components/no_more/no_data_sliver_list.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../../controllers/station/station_detail_with_ranking_page_controller.dart';

class StationDetailWithRankingPage
    extends GetView<StationDetailWithRankdingPageController> {
  const StationDetailWithRankingPage({super.key});

  Widget _buildBody() {
    return BaseRefreshSimpleWidget(
      controller,
      useRefreshLocator: true,
      enableLoad: false,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 130.w,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              controller.station.stationName,
              style: TextStyle(
                color: COLOR.primaryText,
                fontSize: 18.w,
              ),
            ),
            flexibleSpace: BackgroundFlexibleSpaceBar(
              background: Image.asset(
                AppImagePath.shi_pin_rank_detail_bg,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const HeaderLocator.sliver(),
          SizedBox(height: 12.w).sliver,
          // Obx(
          //   () => NoDataSliverList.separated(
          //     itemCount: controller.data.length,
          //     itemBuilder: (ctx, i) => ItemVideoLongView(
          //       controller.data[i].video,
          //       rank: controller.data[i].rank,
          //     ),
          //     separatorBuilder: (ctx, i) => 12.verticalSpaceFromWidth,
          //     noData: controller.dataInited,
          //   ).sliverPaddingHorizontal(14.w),
          // ),
          const FooterLocator.sliver(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _buildBody());
}
