import 'package:baby_app/components/no_more/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/model/classify/classify_models.dart';
import 'package:baby_app/model/tags_model.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import '../../../components/base_page/base_loading_widget.dart';
import '../../../components/image_view.dart';
import '../../../components/short_widget/video_base_cell.dart';
import '../../../utils/color.dart';
import '../../community/community_page_controller.dart';
import '../../community/widget/community_ad.dart';
import '../widget/home_insert_ad.dart';
import 'home_baby_logic.dart';
import 'home_baby_state.dart';
import 'package:baby_app/components/ad_banner/classify_ads.dart';
import 'package:baby_app/components/base_refresh/base_refresh_widget.dart';

///宝宝
class HomeBabyPage extends StatefulWidget {
  final ClassifyModel? model;

  const HomeBabyPage({Key? key, this.model}) : super(key: key);

  @override
  State<HomeBabyPage> createState() => _HomeBabyPageState();
}

class _HomeBabyPageState extends State<HomeBabyPage> {
  HomeBabyState state = Get.find<HomeBabyLogic>().state;
  CommunityPageController controller = Get.find<CommunityPageController>();

  HomeBabyLogic get logic => Get.find<HomeBabyLogic>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.loadData(1);
    logic.initTag(widget.model);
  }

  @override
  void dispose() {
    Get.delete<HomeBabyLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: BaseRefreshWidget(logic!, child: _buildBody()),
        )
      ],
    );
  }

  Widget _buildBody() => CustomScrollView(
    controller: ScrollController(),
    slivers: [
      8.verticalSpaceFromWidth.sliver,
      GetBuilder<HomeBabyLogic>(builder: (controller) {
        return SizedBox(
          height: 85.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: logic.tagList.length > 5 ? 5 : logic.tagList.length,
            itemBuilder: (context, index) {
              var tag = logic.tagList![index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50.w),
                      // 设置20.w的圆角
                      child: ImageView(
                        src: tag.logo!,
                        width: 60,
                        height: 60,
                        defaultPlace: AppImagePath.app_default_avatar,
                      )),
                  Container(
                    child: Text(
                      maxLines: 2,
                      tag.tagsTitle ?? '',
                      style: TextStyle(
                        color: COLOR.white.withValues(alpha: 0.6),
                        fontSize: 13.w,
                        fontWeight: FontWeight.w500,
                      ),
                    ).marginOnly(top: 6.w),
                  )
                ],
              ).marginOnly(right: 7.w, left: 7.w).onOpaqueTap(() {
                logic.setSelectIndext(index);
              });
            },
          ),
        ).marginLeft(10);
      }).sliver,
      12.verticalSpaceFromWidth.sliver,
      buildSelectList(state, logic).sliver,
      12.verticalSpaceFromWidth.sliver,
      GetBuilder<HomeBabyLogic>(builder: (controller) {
        return _verticalList();
      })
    ],
  );
  Widget buildSelectList(HomeBabyState state, HomeBabyLogic logic) {
    return Obx(() => Container(
          margin: EdgeInsets.only(bottom: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSelectBtn(state.list1, state, logic),
              Container(
                margin: EdgeInsets.only(top: 7.w),
                child: Row(
                  children: [
                    Text(
                      "切换",
                      style: TextStyle(
                          fontSize: 12.sp, color: Colors.white.withAlpha(0xAF)),
                    ),
                    ImageView(
                      src: !logic.isList.value
                          ? AppImagePath.home_home_list_icon
                          : AppImagePath.home_home_more_icon,
                      width: 14.w,
                      height: 14.w,
                    )
                  ],
                ).onOpaqueTap(() {
                  logic.switchBtn();
                }),
              )
            ],
          ),
        ));
  }

  buildSelectBtn(List<String> list, HomeBabyState state, HomeBabyLogic logic) {
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
                                  fontWeight:
                                      state.index1.value == list.indexOf(e)
                                          ? FontWeight.w600
                                          : FontWeight.w300,
                                  color: state.index1.value == list.indexOf(e)
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

  Widget _verticalClassList() {
    return GetBuilder<HomeBabyLogic>(builder: (controller) {
      Get.log("===========>刷新完成");
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

  Widget _verticalList() {
    return GetBuilder<HomeBabyLogic>(builder: (controller) {
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
                if (!logic.isList.value) 5.verticalSpaceFromWidth,
                if (!logic.isList.value) 15.verticalSpace,
              ],
            );
          }
          return logic.isList.value
              ? VideoBaseCell.big(video: logic.pageController.itemList![index])
              : VideoBaseCell.small(
                  video: logic.pageController.itemList![index]);
        },
        mainAxisSpacing: 10.w,
        crossAxisSpacing: 8.w,
        crossAxisCount: logic.isList.value ? 1 : 2,
      ).sliverPaddingHorizontal(14.w);
    });
  }

// 自定义跨列widget

  Widget buildVideoTag(int index, {required TagsModel video}) {
    return Container(
      width: 78.w,
      height: 30.w,
      decoration: BoxDecoration(
          color: logic.selectIndex == index
              ? Color(0xff181921)
              : Color(0xff181921),
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
}

Widget buildTagItem(String v, {VoidCallback? onTap}) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xff181921),
      borderRadius: BorderRadius.circular(5.r),
    ),
    width: 80.w,
    height: 35.w,
    alignment: Alignment.center,
    child: Text(
      v,
      style: TextStyle(
          fontSize: 13.w, color: COLOR.white, fontWeight: FontWeight.w500),
    ),
  ).onTap(onTap);
}
