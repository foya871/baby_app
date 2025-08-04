import 'package:baby_app/components/ad/ad_multiple_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/ad_banner/classify_ads.dart';
import 'package:baby_app/components/base_refresh/base_refresh_widget.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/model/classify/classify_models.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/home/home_forbidden/home_forbidden_logic.dart';
import 'package:baby_app/views/home/home_forbidden/home_forbidden_state.dart';
import '../../../components/ad/ad_enum.dart';
import '../../../components/base_page/base_loading_widget.dart';
import '../../../components/circle_image.dart';
import '../../../components/short_widget/video_base_cell.dart';
import '../../../components/text_view.dart';
import '../../../model/tags_model.dart';
import '../../../utils/color.dart';
import '../../community/widget/community_ad.dart';
import '../home_controller.dart';
import '../widget/home_insert_ad.dart';
import 'package:baby_app/views/community/community_page_controller.dart';

///暗网
class HomeForbiddenPage extends StatefulWidget {
  final ClassifyModel? model;
  final HomeForbiddenLogic? controller;

  const HomeForbiddenPage({Key? key, this.model, this.controller})
      : super(key: key);

  @override
  State<HomeForbiddenPage> createState() => _HomeNonagePageState();
}

class _HomeNonagePageState extends State<HomeForbiddenPage> {
  String get _tag => widget.model?.classifyTitle ?? '';

  CommunityPageController controller = Get.find<CommunityPageController>();

  HomeForbiddenLogic get logic =>
      Get.find<HomeForbiddenLogic>(tag: widget.model?.classifyTitle ?? '');

  @override
  void dispose() {
    Get.delete<HomeForbiddenLogic>();
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

  HomeForbiddenState get state => Get.find<HomeForbiddenLogic>(tag: _tag).state;

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
            title:  buildSelectList(state, logic),
            pinned: true,
            toolbarHeight: 25.w,
            elevation: 0,
            expandedHeight: 0,
          ),
          12.verticalSpaceFromWidth.sliver,
          GetBuilder<HomeForbiddenLogic>(
              tag: _tag,
              builder: (controller) {
                return _verticalList();
              })
        ],
      );

  _buildAd() {
    return AdMultipleView.smallIcons(
      type: AdApiType.INSERT_ICON,
      spacing: 10.w,
    ).marginSymmetric(horizontal: 12.w, vertical: 14.w).sliver;
  }

  Widget _verticalClassList() {
    return GetBuilder<HomeForbiddenLogic>(
        tag: _tag,
        builder: (controller) {
          Get.log("===========>刷新完成");

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
                (context, i) => buildVideoTag(i, video: logic!.tagList[i]),
                childCount: logic!.tagList.length, // 空安全校验后可安全使用!
              ),
            ),
          );
        });
  }

  Widget buildNoAgeTag(int index, {required TagsModel video}) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          CircleImage.network(
            video.logo,
            size: 60.w,
          ).onOpaqueTap(() {
            logic.setSelectIndext(index);
          }),
          SizedBox(
            height: 6.h,
          ),
          Text(
            maxLines: 1,
            video.tagsTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.w,
            ),
          ),
        ],
      ),
    ).onOpaqueTap(() {
      logic.setSelectIndext(index);
    });
  }

  Widget buildVideoTag(int index, {required TagsModel video}) {
    return Stack(
      children: [
        Image.asset(
          height: 30.h,
          AppImagePath.home_forbidden_tag_bg,
          // Replace with your actual image path
          fit: BoxFit.fill,
        ),
        Center(
          child: Text(
            video.tagsTitle,
            style: TextStyle(
              color: Color(0xfff29e9e),
              fontSize: 13.w,
            ),
          ),
        ).onOpaqueTap(() {
          logic.setSelectIndext(index);
        })
      ],
    );
  }

  // final intervalNum2 = initRuleIntervalNum(AdApiType.HOME_LIST_INSERT);

  Widget _verticalList() {
    return GetBuilder<HomeForbiddenLogic>(
        tag: _tag,
        builder: (controller) {
          final arr = logic.pageController.itemList ?? [];
          if (arr.isEmpty) return const BaseLoadingWidget().sliver;
          return SliverMasonryGrid.count(
            childCount: logic.pageController.itemList?.length ?? 0,
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

  Widget buildSelectList(HomeForbiddenState state, HomeForbiddenLogic logic) {
    return GetBuilder<HomeForbiddenLogic>(
        id: "buildSelectBtn",
        tag: _tag,
        builder: (context) {
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
                      GetBuilder<HomeForbiddenLogic>(
                          tag: _tag,
                          builder: (controller) {
                            return ImageView(
                              src: !logic.isList
                                  ? AppImagePath.home_home_list_icon
                                  : AppImagePath.home_home_more_icon,
                              width: 14.w,
                              height: 14.w,
                            );
                          })
                    ],
                  ).onOpaqueTap(() {
                    logic.switchBtn();
                  }),
                )
              ],
            ),
          );
        });
  }

  buildSelectBtn(List<String> list, int index, HomeForbiddenLogic logic) {
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
