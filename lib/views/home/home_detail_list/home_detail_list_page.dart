import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/ad_banner/classify_ads.dart';
import 'package:baby_app/components/base_refresh/base_refresh_widget.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import '../../../components/base_page/base_loading_widget.dart';
import '../../../components/no_more/no_data.dart';
import '../../../components/short_widget/video_base_cell.dart';
import '../../../components/text_view.dart';
import '../../../utils/color.dart';
import '../../../utils/enum.dart';
import '../widget/home_insert_ad.dart';
import 'home_detail_list_logic.dart';
import 'home_detail_list_state.dart';

///标签
class HomeDetailListPage extends StatefulWidget {
  const HomeDetailListPage({Key? key}) : super(key: key);

  @override
  State<HomeDetailListPage> createState() => _HomeDetailListPageState();
}

class _HomeDetailListPageState extends State<HomeDetailListPage> {
  final HomeDetailListLogic logic = Get.put(HomeDetailListLogic());
  final HomeDetailListState state = Get.find<HomeDetailListLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.initTag();
  }

  @override
  void dispose() {
    Get.delete<HomeDetailListLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text(logic.title.value))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BaseRefreshWidget(logic, child: _buildBody()),
          )
        ],
      ),
    );
  }

  Widget _buildBody() => CustomScrollView(
        controller: ScrollController(),
        slivers: [
          const ClassifyAds().sliver,
          5.verticalSpaceFromWidth.sliver,
          SliverToBoxAdapter(
            child: Center(
              child: buildSelectList2(),
            ),
          ),
          12.verticalSpaceFromWidth.sliver,
          GetBuilder<HomeDetailListLogic>(builder: (controller) {
            if (controller.request) {
              return const Center(child: BaseLoadingWidget()).sliver;
            } else {
              return _verticalList();
            }
          })
        ],
      );
  // final intervalNum2 = initRuleIntervalNum(AdApiType.HOME_LIST_INSERT);

  Widget _verticalList() {
    return GetBuilder<HomeDetailListLogic>(builder: (controller) {
      final arr = logic.pageController.itemList ?? [];
      if (arr.isEmpty) return const NoData().sliver;
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
              ? VideoBaseCell.big(video: logic.pageController.itemList![index])
              : VideoBaseCell.small(
                  video: logic.pageController.itemList![index]);
        },
        mainAxisSpacing: 10.w,
        crossAxisSpacing: 8.w,
        crossAxisCount: logic.isList ? 1 : 2,
      );
    }).sliverPaddingHorizontal(14.w);
  }

  Widget buildSelectList() {
    return GetBuilder<HomeDetailListLogic>(
        id: "buildSelectBtn",
        builder: (context) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildSelectBtn(state.list1, state.index1),
                Row(
                  children: [
                    Text(
                      "切换",
                      style: TextStyle(
                          fontSize: 12.sp, color: Colors.white.withAlpha(0xAF)),
                    ),
                    GetBuilder<HomeDetailListLogic>(builder: (controller) {
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
                })
              ],
            ),
          );
        });
  }

  Widget buildSelectList2() {
    return Obx(() => Container(
          width: 140.w,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Color(0xFF23262B), // 背景色（可根据你的页面调整）
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: List.generate(logic.tabs.length, (index) {
              final bool selected = logic.selectedIndex.value == index;
              return GestureDetector(
                onTap: () {
                  logic.selectedIndex.value = index;
                  logic.setIndexType(index);
                },
                child: Container(
                  width: 70,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? Color(0xFF19B5FE) : Color(0xFF23262B),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    logic.tabs[index],
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }),
          ),
        ));
  }

  buildSelectBtn(List<String> list, int index) {
    return Container(
      width: 0.7.sw,
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
}
