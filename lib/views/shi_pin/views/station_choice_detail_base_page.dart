import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../components/base_refresh/base_refresh_tab_widget.dart';
import '../../../components/image_view.dart';
import '../../../model/video_base_model.dart';
import '../../../utils/color.dart';
import '../../../utils/extension.dart';
import '../common/base/shi_pin_sort_tab_bar.dart';
import '../common/base/shi_pin_utils.dart';
import '../controllers/station_choice_detail_base_page_controller.dart';

abstract class StationChoiceBasePage<
    T extends StationChoiceDetailBasePageController> extends GetView<T> {
  const StationChoiceBasePage({super.key});

  List<(String, int)> get sortTabs => ShiPinSortTabBar.tabs;

  PreferredSize _buildAppBar() {
    final statusBarHeight = ScreenUtil().statusBarHeight;
    final height = 60.0 + (statusBarHeight == 0 ? 30 : statusBarHeight);

    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: AppBar(
        title: Text(controller.title, style: TextStyle(fontSize: 18.w)),
        backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            controller.info,
            style: TextStyle(color: COLOR.color_FEE041, fontSize: 15.w),
          ),
          centerTitle: true,
          background: Stack(
            children: [
              ImageView(
                src: controller.coverImg,
                height: height + 56,
                width: 1.sw,
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabView(int index) {
    final tabKey = BaseRefreshTabIndexKey(index);
    return BaseRefreshTabWidget(
      controller,
      tabKey: tabKey,
      child: CustomScrollView(
        slivers: [
          Obx(
            () {
              final data = controller.getData<VideoBaseModel>(tabKey);
              final dataInited = controller.dataInited(tabKey);
              final layout = controller.layout.value;
              final isVerticalLayout = controller.isVerticalLayout;
              return ShiPinUtils.buildSilverLayoutVideos(
                data,
                layout: layout,
                dataInited: dataInited,
                isVerticalLayout: isVerticalLayout,
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildTabViews() => TabBarView(
        children: sortTabs
            .mapIndexed(
              (index, _) => _buildTabView(index).keepAlive,
            )
            .toList(),
      );

  Widget _buildBody() {
    return Column(
      children: [
        8.verticalSpaceFromWidth,
        ShiPinSortTabBar(controller: controller),
        20.verticalSpaceFromWidth,
        Expanded(child: _buildTabViews().baseMarginHorizontal),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: sortTabs.length,
        initialIndex: ShiPinSortTabBar.defaultIndex,
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        ),
      );
}
