import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import '../../../components/app_bar/app_bar_view.dart';
import '../../../components/base_page/base_error_widget.dart';
import '../../../components/base_page/base_loading_widget.dart';
import '../../../components/base_refresh/base_refresh_share_tab_widget.dart';
import '../../../components/grid_view/heighted_grid_view.dart';
import '../../../components/short_widget/video_base_cell.dart';
import '../../../components/short_widget/video_layout_button.dart';
import '../../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/video_base_model.dart';
import '../../../utils/color.dart';
import '../../../utils/enum.dart';
import '../../../utils/extension.dart';
import 'video_box_page_controller.dart';

class VideoBoxPage extends GetView<VideoBoxPageController> {
  const VideoBoxPage({super.key});

  PreferredSizeWidget _buildAppBar() => AppBarView(
        titleText: '片库',
        actions: [
          Image.asset(
            AppImagePath.app_default_search,
            width: 16.w,
            height: 16.w,
          ).onTap(() {}).baseMarginR,
        ],
      );

  Widget _buildTabBar(List<String> tabs,
      {required TabController tabController}) {
    return SizedBox(
      height: 23.w,
      child: TabBar(
        controller: tabController,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
        indicatorColor: COLOR.transparent,
        dividerHeight: 0,
        indicator: EasyFixedIndicator(
          height: 23.w,
          widthExtra: 16.w,
          color: COLOR.color_B940FF,
          borderRadius: Styles.borderRadius.all(11.5.w),
        ),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
        labelStyle: TextStyle(color: COLOR.white, fontSize: 12.w),
        unselectedLabelStyle: TextStyle(color: COLOR.white, fontSize: 12.w),
      ),
    );
  }

  Widget _buildMarkTabBar() => _buildTabBar(
        VideoBoxPageController.markTabs.map((e) => e.item1).toList(),
        tabController: controller.markTabController,
      );

  Widget _buildTagsTitleTabBar() => _buildTabBar(
        controller.tagTabs.map((e) => e.tagsTitle).toList(),
        tabController: controller.tagsTabController!,
      );

  Widget _buildVideoTypeTabBarRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTabBar(
          VideoBoxPageController.videoTypeTabs.map((e) => e.item1).toList(),
          tabController: controller.videoTypeTabController,
        ),
        Obx(
          () => VideoLayoutButton(
            controller.layout.value,
            text: '视图切换',
            onTap: controller.onTapLayout,
          ),
        )
      ],
    );
  }

  Widget _buildTarBarView() => BaseRefreshShareTabWidget.builder(
        controller,
        childBuilder: (context, physics) {
          return CustomScrollView(
            physics: physics,
            slivers: [
              Obx(
                () {
                  final data = controller.getCurrentData<VideoBaseModel>();
                  final dataInited = controller.currentDataInited;
                  final isSmallLayout =
                      controller.layout.value == VideoLayout.small;
                  return HeightedGridView.sliver(
                    crossAxisCount: isSmallLayout ? 2 : 1,
                    itemCount: data.length,
                    itemBuilder: (ctx, i) => isSmallLayout
                        ? VideoBaseCell.small(video: data[i])
                        : VideoBaseCell.big(video: data[i], onTap: () {}),
                    rowSepratorBuilder: (ctx, i) => 10.verticalSpaceFromWidth,
                    noData: dataInited,
                  );
                },
              )
            ],
          );
        },
      ).baseMarginHorizontal;

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMarkTabBar().baseMarginL,
        14.verticalSpaceFromWidth,
        _buildTagsTitleTabBar().baseMarginL,
        14.verticalSpaceFromWidth,
        _buildVideoTypeTabBarRow().baseMarginHorizontal,
        20.verticalSpaceFromWidth,
        Expanded(child: _buildTarBarView()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: COLOR.scaffoldBg,
        appBar: _buildAppBar(),
        body: controller.obx(
          (_) => _buildBody(),
          onLoading: const BaseLoadingWidget(),
          onError: (_) => BaseErrorWidget(onTap: controller.fetchTags),
        ),
      );
}
