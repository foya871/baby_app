import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/no_more/no_data.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/utils/ad_jump.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/views/mine/message/views/message_comment_list_cell.dart';
import 'package:baby_app/views/mine/message/views/message_list_cell.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'message_controller.dart';
import '../../../components/tab_bar_indicator/easy_fixed_indicator.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  Widget _buildTabbar() {
    return SizedBox(
      height: 30.w,
      child: TabBar(
        controller: controller.tabController,
        labelColor: COLOR.color_009FE8,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        indicator: EasyFixedIndicator(
          color: COLOR.color_009FE8,
          width: 10.w,
          height: 4.w,
          borderRadius: BorderRadius.all(Radius.circular(2.w)),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: const EdgeInsets.only(bottom: 2),
        isScrollable: false,
        tabAlignment: TabAlignment.center,
        labelPadding: const EdgeInsets.symmetric(horizontal: 20),
        tabs: controller.tabList.map((e) => Tab(text: e.title)).toList(),
      ),
    );
  }

  Widget _buildChatList() {
    return Obx(() {
      if (controller.chatList.isEmpty) {
        return const NoData();
      }
      return EasyRefresh(
        onRefresh: () => controller.fetchChatList(isRefresh: true),
        onLoad: () => controller.fetchChatList(),
        child: Obx(() {
          return ListView.separated(
            itemBuilder: (context, index) {
              return MessageListCell(
                model: controller.chatList[index],
              ).onOpaqueTap(() {
                Get.toMessageDetail(
                    toUserId: controller.chatList[index].userId ?? 0);
              });
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 33.w,
                color: Colors.white.withValues(alpha: 0.1),
              );
            },
            itemCount: controller.chatList.length,
          ).paddingHorizontal(10.w);
        }),
      );
    });
  }

  Widget _buildCommentList() {
    return Obx(() {
      if (controller.userNoticeList.isEmpty) {
        return const NoData();
      }
      return EasyRefresh(
        onRefresh: () => controller.fetchUserNoticeList(isRefresh: true),
        onLoad: () => controller.fetchUserNoticeList(),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return MessageCommentListCell(
              model: controller.userNoticeList[index],
            );
          },
          separatorBuilder: (context, index) {
            return 20.verticalSpaceFromWidth;
          },
          itemCount: controller.userNoticeList.length,
        ).paddingHorizontal(10.w),
      );
    });
  }

  Widget _buildService() {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          10.horizontalSpace,
          AppBgView(
            width: 48.w,
            height: 48.w,
            borderRadius: BorderRadius.circular(48.w / 2),
            backgroundColor: COLOR.color_009FE8,
            child: ImageView(
              src: AppImagePath.mine_icon_service,
              width: 30.w,
              height: 30.w,
            ),
          ),
          8.horizontalSpace,
          TextView(
            text: '官方客服',
            fontSize: 13.w,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ],
      ).onOpaqueTap(() {
        kOnLineService();
      }),
    );
  }

  Widget _buildTabBarView(MessageSegment segment) {
    switch (segment) {
      case MessageSegment.comment:
        return _buildCommentList();
      case MessageSegment.message:
        return _buildChatList();
      case MessageSegment.service:
        return _buildService();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息中心'),
      ),
      body: Column(children: [
        _buildTabbar(),
        20.verticalSpaceFromWidth,
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: controller.tabList.map(_buildTabBarView).toList(),
          ),
        ),
      ]),
    );
  }
}
