import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../components/base_page/base_error_widget.dart';
import '../../../../components/base_page/base_loading_widget.dart';
import '../../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../../components/base_refresh/base_refresh_tab_widget.dart';
import '../../../../components/no_more/no_data_sliver_list.dart';
import '../../../../model/ai/ai_models.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../../common/ai_face_stencil_block.dart';
import '../../common/ai_sort_cell.dart';
import '../../common/popup/ai_face_image_make_bottom_sheet.dart';
import '../../controllers/tabs/ai_tab_face_image_page_controller.dart';

class AiTabFaceImagePage extends GetView<AiTabFaceImagePageController> {
  const AiTabFaceImagePage({super.key});

  Widget _buildTabBar() => TabBar(
        tabs: controller.classifyList.map((e) => Text(e.classTitle)).toList(),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicator: const BoxDecoration(),
        labelStyle: TextStyle(
          fontSize: 16.w,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          color: COLOR.primaryText.withValues(alpha: 0.6),
          fontSize: 16.w,
        ),
      );

  Widget _buildSort(BaseRefreshTabIndexKey tabKey) => Obx(() {
        final AiStencilSortArgs(type: sortType, asc: sortAsc) =
            controller.sortArgs[tabKey.index];
        return Row(
          spacing: 12.w,
          children: [
            AiSortCell(
              text: '上架时间',
              asc: sortType == AiStenceilSortType.time ? sortAsc : null,
              onTap: () => controller.onTapSort(
                tabKey,
                AiStenceilSortType.time,
              ),
            ),
            AiSortCell(
              text: '价格排序',
              asc: sortType == AiStenceilSortType.price ? sortAsc : null,
              onTap: () => controller.onTapSort(
                tabKey,
                AiStenceilSortType.price,
              ),
            ),
            AiSortCell(
              text: '使用次数',
              asc: sortType == AiStenceilSortType.usedCount ? sortAsc : null,
              onTap: () => controller.onTapSort(
                tabKey,
                AiStenceilSortType.usedCount,
              ),
            ),
          ],
        );
      });

  Widget _buildStencils(BaseRefreshTabIndexKey tabKey) => BaseRefreshTabWidget(
        controller,
        tabKey: tabKey,
        child: CustomScrollView(
          slivers: [
            Obx(
              () {
                final data = controller.getData<AiStencilModel>(tabKey);
                final dataInited = controller.dataInited(tabKey);
                final blocks =
                    data.slices(AiFaceStencilBlock.showModelCountMax).toList();

                return NoDataSliverList.separated(
                  itemCount: blocks.length,
                  itemBuilder: (context, index) => AiFaceStencilBlock(
                    blocks[index],
                    onTap: (i) {
                      final stencil = blocks[index][i];
                      AiFaceImageMakeBottomSheet(
                        stencil: stencil,
                        onTapMake: (f) => controller.onTapMake(stencil, f),
                      ).show();
                    },
                  ),
                  separatorBuilder: (context, index) =>
                      10.verticalSpaceFromWidth,
                  noData: dataInited,
                );
              },
            )
          ],
        ),
      );

  Widget _buildTabBarView() => TabBarView(
        children: controller.classifyList.mapIndexed(
          (i, e) {
            final tabKey = BaseRefreshTabIndexKey(i);
            return Column(
              children: [
                _buildSort(tabKey),
                12.verticalSpaceFromWidth,
                Expanded(child: _buildStencils(tabKey)),
              ],
            ).keepAlive;
          },
        ).toList(),
      );

  Widget _buildBody() => DefaultTabController(
        length: controller.classifyList.length,
        child: Column(
          children: [
            12.verticalSpaceFromWidth,
            _buildTabBar(),
            12.verticalSpaceFromWidth,
            Expanded(child: _buildTabBarView()),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => controller.obx(
        (_) => _buildBody(),
        onLoading: const BaseLoadingWidget(),
        onError: (_) => BaseErrorWidget(onTap: controller.fetchClassify),
      );
}
