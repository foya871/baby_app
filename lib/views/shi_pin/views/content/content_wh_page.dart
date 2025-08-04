import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../assets/styles.dart';
import '../../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../../components/base_refresh/base_refresh_tab_widget.dart';
import '../../../../components/no_more/no_data_list_view.dart';
import '../../../../components/short_widget/content/content_profile_tile.dart';
import '../../../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../../../../utils/utils.dart';
import '../../controllers/content/content_wh_page_controller.dart';

class ContentWhPage extends GetView<ContentWhPageController> {
  const ContentWhPage({super.key});

  AppBar _buildAppBar() => AppBar(title: const Text('全部网黄'));

  Widget _buildTabBar() {
    return TabBar(
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      labelColor: COLOR.color_B93FFF,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14.w,
      ),
      unselectedLabelColor: COLOR.color_808080,
      unselectedLabelStyle: TextStyle(fontSize: 14.w),
      indicator: EasyFixedIndicator(
        color: COLOR.color_B93FFF,
        width: 10.w,
        height: 3.w,
        borderRadius: Styles.borderRadius.all(1.5.w),
      ),
      indicatorWeight: 4,
      dividerHeight: 0,
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.symmetric(horizontal: 14.w),
      tabs: ContentWhPageController.sortTypeTabs
          .map((e) => Text(e.item1))
          .toList(),
    );
  }

  Widget _buildTabView(int index) {
    final tabKey = BaseRefreshTabIndexKey(index);
    if (index == ContentWhPageController.nameFilterIndex) {
      return _buildNameFilterTabView(tabKey);
    }
    final data = controller.getData(tabKey);
    return BaseRefreshTabWidget(
      controller,
      tabKey: tabKey,
      child: NoDataListView.separated(
        itemCount: data.length,
        itemBuilder: (ctx, i) => ContentProfileTile(data[i]),
        separatorBuilder: (ctx, i) => 12.verticalSpaceFromWidth,
        noData: controller.dataInited(tabKey),
      ),
    );
  }

  Widget _buildAlphabet(String alphabet) {
    return Obx(() {
      final selected = controller.selectedName.value == alphabet;
      final style = TextStyle(
        color: selected ? COLOR.white : COLOR.color_DDDDDD,
        fontSize: 14.w,
      );
      return Container(
        width: 25.w,
        height: 25.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? COLOR.color_B93FFF : null,
        ),
        child: Center(child: Text(alphabet, style: style)),
      ).onTap(() => controller.onTapName(alphabet));
    });
  }

  Widget _buildNames() {
    final rows = Utils.alphabetUpper
        .slices(10)
        .map(
          (s) => Row(
            children:
                s.map((e) => _buildAlphabet(e)).toList().joinWidth(13.55.w),
          ),
        )
        .toList()
        .joinHeight(16.w);
    return Column(children: rows);
  }

  Widget _buildNameFilterTabView(BaseRefreshTabIndexKey tabKey) {
    final data = controller.getData(tabKey);
    return Column(
      children: [
        _buildNames(),
        30.verticalSpaceFromWidth,
        Expanded(
          child: BaseRefreshTabWidget(
            controller,
            tabKey: tabKey,
            child: NoDataListView.separated(
              itemCount: data.length,
              itemBuilder: (ctx, i) => ContentProfileTile(data[i]),
              separatorBuilder: (ctx, i) => 12.verticalSpaceFromWidth,
              noData: controller.dataInited(tabKey),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTabViews() {
    return Obx(
      () => TabBarView(
        children: ContentWhPageController.sortTypeTabs.mapIndexed((index, _) {
          return _buildTabView(index).keepAlive;
        }).toList(),
      ),
    );
  }

  Widget _buildBody() => DefaultTabController(
        length: ContentWhPageController.sortTypeTabs.length,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: _buildTabBar(),
            ),
            DefaultDivider(color: COLOR.color_292A31.withOpacity(0.5)),
            14.verticalSpaceFromWidth,
            Expanded(
              child: _buildTabViews().baseMarginHorizontal,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      );
}
