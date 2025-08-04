import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import '../../../components/base_refresh/base_refresh_tab_widget.dart';
import '../../../components/no_more/no_data_masonry_grid_view.dart';
import '../../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../../utils/color.dart';
import '../../../utils/extension.dart';
import '../common/ai_record_cell.dart';
import '../controllers/ai_record_page_controller.dart';

class AiRecordPage extends GetView<AiRecordPageController> {
  const AiRecordPage({super.key});

  AppBar _buildAppBar() => AppBar(title: const Text('记录'));

  Widget _buildStatusTabBar(int typeIndex) => SizedBox(
        height: 30.w,
        child: TabBar(
          tabs: AiRecordPageController.statusTabs
              .map((e) => Tab(text: e))
              .toList(),
          labelStyle: TextStyle(
            color: COLOR.white,
            fontSize: 14.w,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 14.w,
            color: COLOR.color_8e8e93,
          ),
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          indicator: EasyFixedIndicator(
            widthExtra: 20.w,
            height: 25.w,
            borderRadius: Styles.borderRadius.all(12.w),
            color: COLOR.themeSelectedColor,
          ),
          indicatorPadding: EdgeInsets.only(bottom: 2.w),
          padding: EdgeInsets.zero,
          indicatorWeight: 0,
          dividerColor: COLOR.transparent,
          dividerHeight: 0,
          labelPadding: EdgeInsets.only(right: 20.w),
          controller: controller.getStatusTabController(typeIndex),
        ),
      );

  Widget _buildTypeTabBarView() => TabBarView(
        children: AiRecordPageController.typeTabs
            .mapIndexed((i, _) => _buildStatusTab(i))
            .toList(),
      );

  Widget _buildTypeTabBar() => SizedBox(
        height: 35.w,
        child: TabBar(
          tabs:
              AiRecordPageController.typeTabs.map((e) => Tab(text: e)).toList(),
          labelStyle: TextStyle(
            fontSize: 16.w,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16.w,
            color: COLOR.primaryText.withValues(alpha: 0.6),
          ),
          dividerHeight: 0,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          indicator: EasyFixedIndicator(
            width: 20.w,
            height: 3.w,
            borderRadius: Styles.borderRadius.all(2.w),
            color: COLOR.themeSelectedColor,
          ),
          indicatorWeight: 0,
          indicatorPadding: EdgeInsets.only(bottom: 1.5.w),
          padding: EdgeInsets.zero,
          dividerColor: COLOR.transparent,
          labelPadding: EdgeInsets.only(right: 30.w),
        ),
      );

  Widget _buildStatusTabBarRow(int typeIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatusTabBar(typeIndex),
        Obx(
          () => controller.statusTabControllerIndexes[typeIndex] ==
                  AiRecordPageController.statusTabFailureIndex
              ? Text(
                  '删除',
                  style: TextStyle(
                    color: COLOR.color_666666,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                  ),
                ).onTap(() => controller.onTapDeleteStatus(typeIndex))
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildStatusTabBarView(int typeIndex) => TabBarView(
        controller: controller.getStatusTabController(typeIndex),
        children: AiRecordPageController.statusTabs.mapIndexed((i, _) {
          return _buildStatusContent(typeIndex, i).keepAlive;
        }).toList(),
      );

  Widget _buildStatusTab(int typeIndex) => Column(
        children: [
          _buildStatusTabBarRow(typeIndex).marginLeft(11.w),
          18.verticalSpaceFromWidth,
          Expanded(
            child: _buildStatusTabBarView(typeIndex),
          ),
        ],
      );

  Widget _buildStatusContent(int typeIndex, int statusIndex) {
    final tabKey = AiRecordTabKey(typeIndex, statusIndex);

    // 瀑布流
    return BaseRefreshTabWidget(
      controller,
      tabKey: tabKey,
      child: Obx(
        () {
          final data = controller.getData<AiRecordCellOption>(tabKey);
          return NoDataMasonryGridView.count(
            crossAxisCount: 2,
            itemBuilder: (ctx, i) => AiRecordCell.auto(option: data[i]),
            itemCount: data.length,
            mainAxisSpacing: 6.w,
            crossAxisSpacing: 7.w,
            noData: controller.dataInited(tabKey),
          );
        },
      ),
    );
  }

  Widget _buildBody() => DefaultTabController(
        length: AiRecordPageController.typeTabs.length,
        child: Column(
          spacing: 10.w,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTypeTabBar(),
            Expanded(child: _buildTypeTabBarView()),
          ],
        ).baseMarginHorizontal,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      );
}
