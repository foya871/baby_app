import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/no_more/no_data.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import '../../../components/ad/ad_enum.dart';
import '../../../components/ad/ad_multiple_view.dart';
import '../../../components/ad_banner/classify_ads.dart';
import '../../../components/base_page/base_loading_widget.dart';
import '../../../components/base_refresh/base_refresh_widget.dart';
import '../../../components/image_view.dart';
import '../../../components/short_widget/video_base_cell.dart';
import '../../../components/text_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/classify/classify_models.dart';
import '../../../model/tags_model.dart';
import '../../../utils/color.dart';
import '../../../utils/enum.dart';
import '../../community/community_page_controller.dart';
import '../../community/widget/community_ad.dart';
import '../widget/home_insert_ad.dart';
import 'home_common_logic.dart';
import 'home_common_state.dart';

class HomeCommonPage extends StatefulWidget {
  final ClassifyModel model;

  const HomeCommonPage({super.key, required this.model});

  @override
  State<HomeCommonPage> createState() => _HomeCommonPageState();
}

class _HomeCommonPageState extends State<HomeCommonPage> {
  ClassifyModel get model => widget.model;

  HomeCommonLogic get logic =>
      Get.find<HomeCommonLogic>(tag: model.classifyTitle);

  HomeCommonState get state => logic.state;
  CommunityPageController controller = Get.find<CommunityPageController>();

  String get tag => model.classifyTitle;

  @override
  void dispose() {
    Get.delete<HomeCommonLogic>(tag: model.classifyTitle);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: BaseRefreshWidget(logic, child: _buildBody()),
        )
      ],
    );
  }

  Widget _buildBody() => CustomScrollView(
        controller: ScrollController(),
        slivers: [
          // const ClassifyAds().sliver,
          _buildAd(),
          // 15.verticalSpaceFromWidth.sliver,
          _verticalClassList(),
          12.verticalSpaceFromWidth.sliver,
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: buildSelectList(state),
            pinned: true,
            toolbarHeight: 25.w,
            elevation: 0,
            expandedHeight: 0,
          ),
          12.verticalSpaceFromWidth.sliver,
          GetBuilder<HomeCommonLogic>(
              tag: tag,
              builder: (controller) {
                return _verticalList();
              })
        ],
      );

  _buildAd() {
    return AdMultipleView.smallIcons(
      type: AdApiType.INSERT_ICON,
      spacing: 11.w,
    ).marginSymmetric(horizontal: 10.w, vertical: 10.w).sliver;
  }

  Widget _verticalClassList() {
    return GetBuilder<HomeCommonLogic>(
        tag: tag,
        builder: (logic) {
          // 空安全校验：确保logic不为null
          if (logic == null) {
            return const SliverToBoxAdapter(child: SizedBox()); // 空逻辑时返回空组件
          }

          return SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            // 使用SliverPadding替代扩展方法
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 6.w,
                crossAxisSpacing: 6.w,
                childAspectRatio: 2.3, // 建议添加子项宽高比，避免布局异常
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) =>
                    buildVideoTag(logic, i, video: logic!.tagList[i]),
                childCount: logic!.tagList.length, // 空安全校验后可安全使用!
              ),
            ),
          );
        });
  }

  Widget buildVideoTag(HomeCommonLogic logic, int index,
      {required TagsModel video}) {
    return Container(
      width: 78.w,
      decoration: BoxDecoration(
          color: logic.selectIndex == index
              ? Color(0xff191a21)
              : Color(0xff191a21),
          borderRadius: BorderRadius.all(Radius.circular(4.w))),
      alignment: Alignment.center,
      child: Text(
        video.tagsTitle,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.6),
          fontSize: 13.w,
        ),
      ),
    ).onOpaqueTap(() {
      logic.setSelectIndext(index);
    });
  }

  // final intervalNum2 = initRuleIntervalNum(AdApiType.HOME_LIST_INSERT);

  Widget _verticalList() {
    return GetBuilder<HomeCommonLogic>(
        tag: tag,
        builder: (logic) {
          final arr = logic.pageController.itemList ?? [];
          if (arr.isEmpty) return const BaseLoadingWidget().sliver;
          return SliverMasonryGrid.count(
            childCount: arr.length,
            itemBuilder: (ctx, index) {
              final item = logic.pageController.itemList![index];
              if (item.isVideAdMark) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HomeInsertAd(
                    //   adress: AdApiType.HOME_LIST_INSERT,
                    //   height: logic.isList ? 160.w : 91.w,
                    //   asp: logic.isList ? 332.0 / 160 : 162.w / 91.w,
                    // ),
                    8.verticalSpaceFromWidth,
                    TextView(
                      text: '广告',
                      color: Colors.white,
                      fontSize: 13.w,
                    ),
                    if (!logic.isList) 5.verticalSpaceFromWidth,
                    if (!logic.isList) 15.verticalSpace,
                  ],
                );
              }
              return logic.isList
                  ? VideoBaseCell.big(
                      video: logic.pageController.itemList![index])
                  : VideoBaseCell.small(
                      video: logic.pageController.itemList![index]);
            },
            mainAxisSpacing: 10.w,
            crossAxisSpacing: 8.w,
            crossAxisCount: logic.isList ? 1 : 2,
          );
        }).sliverPaddingHorizontal(14.w);
  }

  Widget buildCategoryItem(String icon, String title) {
    return Column(
      children: [
        ImageView(
          src: icon,
          width: 54.r,
        ),
        6.verticalSpace,
        Text(
          title,
          style: TextStyle(fontSize: 13.sp, color: COLOR.white),
        ),
      ],
    ).onTap(() {});
  }

  Widget buildSelectList(HomeCommonState state) {
    return GetBuilder<HomeCommonLogic>(
        id: "buildSelectBtn",
        tag: tag,
        builder: (logic) {
          return Container(
            margin: EdgeInsets.only(bottom: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildSelectBtn(state.list1, state.index1, logic),
                Container(
                  margin: EdgeInsets.only(top: 7.w),
                  child: Row(
                    children: [
                      Text(
                        "切换",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white.withAlpha(0xAF)),
                      ),
                      GetBuilder<HomeCommonLogic>(
                          tag: tag,
                          builder: (logic) {
                            return ImageView(
                              src: !logic.isList
                                  ? AppImagePath.home_home_list_icon
                                  : AppImagePath.home_home_more_icon,
                              width: 14.w,
                              height: 14.w,
                            );
                          })
                    ],
                  ).onOpaqueTap(() => logic.switchBtn()),
                )
              ],
            ),
          );
        });
  }

  buildSelectBtn(List<String> list, int index, HomeCommonLogic logic) {
    return Container(
      width: 0.75.sw,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: ScrollController(),
        child: Container(
          padding: EdgeInsets.only(top: 8.w),
          child: Row(
            children: list
                .map((e) => GestureDetector(
                      onTap: () {
                        logic.setListIndex(list, list.indexOf(e));
                      },
                      child: Container(
                        height: 22.w,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text(
                              e,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 13.w,
                                  fontWeight: index == list.indexOf(e)
                                      ? FontWeight.w600
                                      : FontWeight.w300,
                                  color: index == list.indexOf(e)
                                      ? COLOR.white
                                      : COLOR.color_666666.withAlpha(180)),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
