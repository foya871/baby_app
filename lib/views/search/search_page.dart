import 'package:baby_app/components/no_more/no_data.dart';
import 'package:baby_app/components/no_more/no_more.dart';
import 'package:baby_app/utils/extension.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/ad_banner/classify_ads.dart';
import '../../components/base_page/base_loading_widget.dart';
import '../../components/base_refresh/base_refresh_widget.dart'
    show BaseRefreshWidget;
import '../../components/image_view.dart';
import '../../components/short_widget/video_base_cell.dart' show VideoBaseCell;
import '../../components/text_view.dart';
import '../../generate/app_image_path.dart';
import '../../utils/color.dart';
import '../../utils/widget_utils.dart';
import '../community/widget/community_ad.dart';
import 'search_page_controller.dart';

class SearchPage extends GetView<SearchPageController> {
  SearchPage({super.key});

  final SearchPageController logic = Get.find<SearchPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBarView(),
      body: _buildBodyView(),
    );
  }

  _buildAppBarView() {
    return AppBar(
      titleSpacing: 0,
      title: Container(
        decoration: BoxDecoration(
          color: COLOR.white_10,
          borderRadius: BorderRadius.circular(16.w),
        ),
        height: 35.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            ImageView(
              src: AppImagePath.home_ic_search_logo,
              width: 15.w,
            ),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: WidgetUtils.buildTextField(
                      null, 30.w, 14.sp, COLOR.white, "输入搜索内容",
                      controller: controller.searchTextController,
                      backgroundColor: COLOR.transparent,
                      focusNode: controller.inputFocus),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Image.asset(
                    AppImagePath.search_ic_delete,
                    width: 15.w,
                  ),
                ).onTap(() => controller.searchTextController.clear()),
              ],
            )),
          ],
        ),
      ),
      actions: [
        Container(
          alignment: Alignment.center,
          height: 35.w,
          margin: EdgeInsets.only(right: 5.w),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            '搜索',
            style: TextStyle(fontSize: 15.w, color: COLOR.white),
          ),
        ).onTap(() => controller.startToSearch(controller.getSearchKey(), 1)),
      ],
    );
  }

  _buildBodyView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.ads.isNotEmpty) ...[
            // 10.verticalSpaceFromWidth,
            CommunityAd(ads: controller.ads).baseMarginHorizontal
          ],
          Obx(() {
            if (controller.history.isNotEmpty) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextView(
                    text: "历史记录",
                    color: COLOR.white,
                    fontSize: 15.w,
                    fontWeight: FontWeight.w500,
                  ),
                  const Spacer(),
                  ImageView(
                          src: AppImagePath.home_ic_clear,
                          width: 20.w,
                          height: 20.w)
                      .onOpaqueTap(
                    () => controller.clearHistory(),
                  ),
                ],
              ).marginOnly(top: 20.w, bottom: 10.w, left: 10, right: 10);
            }
            return const SizedBox.shrink();
          }),
          Container(
            child: _buildSearchHistory(),
          ).marginHorizontal(10),
          20.verticalSpaceFromWidth,
          TextView(text: "大家都在搜", color: COLOR.white, fontSize: 16.w)
              .marginHorizontal(10),
          10.verticalSpaceFromWidth,
          Container(child: _buildSearchHotWord()).marginHorizontal(10),
          15.verticalSpaceFromWidth,
          buildSelectBtn(),
          5.verticalSpaceFromWidth,
          Container(child: _verticalList()).marginHorizontal(10),
        ],
      ),
    );
  }

  Widget _verticalList() {
    return GetBuilder<SearchPageController>(builder: (controller) {
      final arr = controller.list1 ?? [];
      if (arr.isEmpty) {
        if (controller.request) {
          return Center(
            child: SizedBox(
              height: 300.w,
              child: const BaseLoadingWidget(),
            ),
          );
        }
        return Center(
          child: SizedBox(
            height: 300.w,
            child: const NoData(),
          ),
        );
      }
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.list1.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.11,
            crossAxisSpacing: 7.w,
            mainAxisSpacing: 10.w),
        itemBuilder: (context, index) {
          return VideoBaseCell.small(video: logic.list1[index]);
        },
      );
    });
  }

  _buildSearchHistory() {
    return Obx(
      () => Wrap(
          spacing: 8.w,
          runSpacing: 8.w,
          alignment: WrapAlignment.start,
          children: controller.history
              .map((e) => buildSearchHistoryItem(e))
              .toList()),
    );
  }

  _buildSearchHotWord() {
    return Obx(
      () => Wrap(
          spacing: 8.w,
          runSpacing: 8.w,
          alignment: WrapAlignment.start,
          children: controller.tags
              .map((e) => Row(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                        height: 30.w,
                        decoration: BoxDecoration(
                            color: COLOR.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4.w)),
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        constraints: BoxConstraints(minWidth: 61.w),
                        child: Center(
                          child: TextView(
                            text: e.hotTitle ?? '',
                            color: COLOR.white.withValues(alpha: 0.6),
                            fontSize: 12.w,
                          ),
                        )).onOpaqueTap(() {
                      controller.startToSearch(e.hotTitle ?? "", 1);
                    }),
                  ]))
              .toList()),
    );
    // return Obx(() => GridView.builder(
    //       padding: EdgeInsets.zero,
    //       shrinkWrap: true,
    //       physics: const NeverScrollableScrollPhysics(),
    //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 4,
    //           childAspectRatio: 2,
    //           crossAxisSpacing: 1,
    //           mainAxisSpacing: 12),
    //       itemCount: controller.tags.length,
    //       itemBuilder: (context, index) {
    //         return Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Stack(
    //               clipBehavior: Clip.none,
    //               children: [
    //                 Container(
    //                     height: 35.w,
    //                     decoration: BoxDecoration(
    //                         color: COLOR.white.withValues(alpha: 0.1),
    //                         borderRadius: BorderRadius.circular(20.w)),
    //                     padding: EdgeInsets.symmetric(horizontal: 24.w),
    //                     child: Center(
    //                       child: TextView(
    //                         text: controller.tags[index].hotTitle ?? '',
    //                         color: COLOR.white,
    //                         fontSize: 12.w,
    //                       ),
    //                     )).onOpaqueTap(() {
    //                   controller.startToSearch(
    //                       controller.tags[index].hotTitle ?? "", 1);
    //                 }),
    //               ],
    //             ),
    //           ],
    //         ).onOpaqueTap(() {
    //           controller.startToSearch(controller.tags[index].hotTitle ?? "",
    //               controller.tags[index].videoMark ?? 0);
    //         });
    //       },
    //     ));
  }

  buildSelectBtn() {
    return SizedBox(
      width: 1.sw,
      child: GetBuilder<SearchPageController>(builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: logic.listTag1
              .mapIndexed((index, e) => GestureDetector(
                    onTap: () {
                      logic.setListIndex(logic.listTag1, index);
                    },
                    child: Container(
                      height: 30.w,
                      alignment: Alignment.center,
                      child: TextView(
                          text: e,
                          fontSize: 13.w,
                          fontWeight: logic.index1 == index
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: logic.index1 == index
                              ? COLOR.white
                              : COLOR.white_60),
                    ),
                  ))
              .toList(),
        );
      }),
    );
  }

  Widget buildSearchHistoryItem(String item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
                height: 30.w,
                constraints: BoxConstraints(minWidth: 64.w),
                decoration: BoxDecoration(
                    color: COLOR.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.w)),
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Center(
                  child: TextView(
                    text: item,
                    color: COLOR.white.withValues(alpha: 0.6),
                    fontSize: 12.w,
                  ),
                )).onOpaqueTap(() {
              controller.startToSearch(item, 1);
            }),
          ],
        ),
      ],
    );
  }
}
