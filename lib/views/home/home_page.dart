import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../assets/styles.dart';
import '../../routes/routes.dart';
import '../../utils/color.dart';
import '../../utils/extension.dart';
import 'home_controller.dart';
import 'home_video_page.dart';

class HomePage extends StatelessWidget {
  ///是否是禁区
  final bool? forbidden;

  HomePage({super.key, this.forbidden});

  bool get _isForbidden => forbidden == true;

  HomePageController get controller => Get.find<HomePageController>(
        tag: _isForbidden
            ? HomePageController.forbiddenTag
            : HomePageController.homeTag,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        centerTitle: true,
        title: _buildAppBar(),
        // actions: [
        //   _isForbidden
        //       ? IconButton(
        //           icon: const Icon(Icons.search),
        //           onPressed: () {
        //             Get.toSearchPage(classifyId: 0);
        //           },
        //         )
        //       : Container(),
        // ],
      ),
      body: HomeVideoPage(
        controller,
        forbidden: forbidden ?? false,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      shadowColor: const Color.fromRGBO(0, 0, 0, 0),
      iconTheme: const IconThemeData(color: COLOR.transparent),
      title: Row(
        children: <Widget>[
          Container(
            width: 300.w,
            height: 32.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImagePath.community_search_bg),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              children: <Widget>[
                Image.asset(
                  AppImagePath.community_search,
                  width: 18.w,
                  height: 18.w,
                ).marginOnly(left: 18.w),
                Text(
                  '请输入搜索关键词',
                  style: TextStyle(
                    color: COLOR.white_30,
                    fontSize: 13.w,
                  ),
                ).marginOnly(left: 10.w),
              ],
            ),
          ).marginOnly(left: 10.w).onOpaqueTap(() {
            Get.toSearchPage(classifyId: 0);
          }),
        ],
      ),
      titleSpacing: 0,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Image.asset(
            AppImagePath.community_vip,
            width: 34.w,
            height: 34.w,
          ).onOpaqueTap(() {
            Get.toVip();
          }),
        ),
      ],
    );
  }
}
