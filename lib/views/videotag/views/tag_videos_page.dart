import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../components/base_refresh/base_refresh_tab_widget.dart';
import '../../../components/grid_view/heighted_grid_view.dart';
import '../../../components/short_widget/video_base_cell.dart';
import '../../../model/video_base_model.dart';
import '../../../routes/routes.dart';
import '../../../utils/color.dart';
import '../../../utils/extension.dart';
import '../controllers/tag_videos_page_controller.dart';

class TagVideosPage extends GetView<TagVideosPageController> {
  const TagVideosPage({super.key});

  List<String> get tabs => TagVideosPageController.tabs;

  AppBar _buildAppBar() => AppBar(title: Text('#${controller.tagsTitle}'));

  Widget _buildTabBar() => TabBar(
        tabs: tabs.map((e) => Text(e)).toList(),
        dividerColor: COLOR.transparent,
        dividerHeight: 0,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelStyle: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(
          color: COLOR.primaryText.withValues(alpha: 0.6),
          fontSize: 14.w,
          fontWeight: FontWeight.w500,
        ),
        indicator: const BoxDecoration(),
      );

  Widget _buildTabBarView() => TabBarView(
        children: tabs.mapIndexed((i, e) {
          final tabKey = BaseRefreshTabIndexKey(i);
          return BaseRefreshTabWidget(
            controller,
            tabKey: tabKey,
            child: CustomScrollView(
              slivers: [
                Obx(() {
                  final data = controller.getData<VideoBaseModel>(tabKey);
                  final dataInited = controller.dataInited(tabKey);
                  return HeightedGridView.sliver(
                    crossAxisCount: 2,
                    itemCount: data.length,
                    itemBuilder: (ctx, i) {
                      return controller.isVerticalLayout
                          ? VideoBaseCell.bigVertical(
                              video: data[i],
                              onTap: () => Get.toShortVideoPlay(
                                data,
                                initId: data[i].videoId,
                              ),
                            )
                          : VideoBaseCell.small(video: data[i]);
                    },
                    noData: dataInited,
                    rowSepratorBuilder: (context, index) =>
                        10.verticalSpaceFromWidth,
                  );
                })
              ],
            ),
          ).keepAlive;
        }).toList(),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: DefaultTabController(
          length: tabs.length,
          child: Column(
            children: [
              12.verticalSpaceFromWidth,
              _buildTabBar().centerLeft,
              12.verticalSpaceFromWidth,
              Expanded(child: _buildTabBarView()),
            ],
          ).baseMarginHorizontal,
        ),
      );
}
