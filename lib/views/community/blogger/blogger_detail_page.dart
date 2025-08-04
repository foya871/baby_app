import 'package:baby_app/components/circle_image.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:baby_app/views/community/blogger/blogger_detail_page_controller.dart';
import 'package:baby_app/views/community/list/community_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

class BloggerDetailPage extends GetView<BloggerDetailPageController> {
  const BloggerDetailPage({super.key});

  @override
  String? get tag => Get.parameters['userId'];

  AppBar _buildAppBar() => AppBar(
        backgroundColor: COLOR.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: COLOR.white,
          onPressed: () => Get.back(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().scaleHeight,
        ),
        Obx(() {
          return ImageView(
            src: controller.userInfo.value.logo ?? '',
            width: ScreenUtil().screenWidth,
            height: 260.w,
          );
        }),
        Image.asset(
          AppImagePath.community_blogger_bg,
          width: ScreenUtil().screenWidth,
          height: 260.w,
        ),
        Obx(() => Flex(
              direction: Axis.vertical,
              children: <Widget>[
                _buildAppBar(),
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: COLOR.color_009fe8,
                    borderRadius: BorderRadius.circular(30.w),
                  ),
                  child: Center(
                    child: CircleImage.network(
                      controller.userInfo.value.logo,
                      size: 58.w,
                    ),
                  ),
                ),
                Obx(() => Text(
                      controller.userInfo.value.nickName ?? '',
                      // '火星吃瓜群众',
                      style: TextStyle(
                        fontSize: 16.w,
                        color: COLOR.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).marginOnly(top: 8.w)),
                Text(
                  '${Utils.numFmt(controller.userInfo.value.bu ?? 0)}粉丝',
                  style: TextStyle(
                    fontSize: 12.w,
                    color: COLOR.white_60,
                  ),
                ).marginOnly(left: 2.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset(
                      controller.userInfo.value.attentionHe == true
                          ? AppImagePath.community_attention
                          : AppImagePath.community_attention_no,
                      width: 60.w,
                      height: 26.w,
                    ).onOpaqueTap(() {
                      controller.bloggerAttention(
                          controller.userInfo.value.userId ?? 0,
                          controller.userInfo.value.attentionHe ?? false);
                    }),
                    Image.asset(
                      AppImagePath.community_chat,
                      width: 60.w,
                      height: 26.w,
                    ).onOpaqueTap(() {
                      Get.toMessageDetail(
                          toUserId: controller.userInfo.value.userId ?? 0);
                    }),
                  ],
                ).marginOnly(left: 115.w, top: 10.w, right: 115.w),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '帖子',
                    style: TextStyle(
                      fontSize: 15.w,
                      color: COLOR.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ).marginOnly(left: 10.w, top: 30.w),
                ),
                Expanded(
                  child: CommunityListPage(
                    dataType: 10,
                    userId: controller.userId.value,
                  ).marginOnly(top: 10.w),
                ),
              ],
            )),
      ],
    );
  }
}
