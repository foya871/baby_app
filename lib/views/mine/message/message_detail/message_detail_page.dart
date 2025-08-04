import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/easy_button.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/services/user_service.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/mine/message/message_detail/views/message_cell.dart';
import 'package:baby_app/views/mine/message/message_detail/views/message_refresh_header.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'message_detail_controller.dart';

class MessageDetailPage extends GetView<MessageDetailController> {
  const MessageDetailPage({super.key});

  Widget _buildInputView() {
    return Container(
      height: 50.w,
      color: COLOR.color_0B1018,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBgView(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 11.w),
            width: 260.w,
            height: 36.w,
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(42.w / 2),
            child: TextField(
              focusNode: controller.textInputFocusNode,
              controller: controller.inputController,
              style: TextStyle(
                  fontSize: 13.w, color: Colors.white.withValues(alpha: 0.6)),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '私信需要消费100金币',
                hintStyle: TextStyle(color: COLOR.color_999999, fontSize: 14.w),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              ),
            ),
          ),
          19.horizontalSpace,
          EasyButton.child(
            ImageView(
              src: AppImagePath.mine_message_image_send,
              width: 30.w,
              height: 30.w,
            ),
            width: 30.w,
            height: 30.w,
            onTap: () async {
              await controller.sendPictureMesage();
            },
          ),
          16.horizontalSpace,
          EasyButton.child(
            ImageView(
              src: AppImagePath.mine_message_text_send,
              width: 30.w,
              height: 30.w,
            ),
            width: 30.w,
            height: 30.w,
            onTap: () async {
              await controller.sendMessage();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return TextView(
            text: controller.toUserInfo.value.nickName ?? '',
          );
        }),
        actions: [
          ImageView(
            src: controller.toUserInfo.value.logo ??
                AppImagePath.app_default_avatar,
            width: 32.w,
            height: 32.w,
            borderRadius: BorderRadius.circular(32.w / 2),
          ).paddingRight(10.w).onOpaqueTap(() {
            Get.toBloggerDetail(
                userId: controller.toUserInfo.value.userId ?? 0);
          })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: EasyRefresh(
              header: MessageRefreshHeader(),
              controller: controller.refreshController,
              onRefresh: () async {
                controller.loadMoreMessageList();
              },
              child: Obx(() {
                return ListView.separated(
                  controller: controller.scrollController,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                  itemBuilder: (context, index) {
                    final message = controller.messageList[index];
                    final isMe = message.msgType != 0
                        ? message.sendUserId ==
                            Get.find<UserService>().user.userId
                        : false;

                    return MessageCell(
                      isMe: isMe,
                      message: message,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return 26.verticalSpaceFromWidth;
                  },
                  itemCount: controller.messageList.length,
                );
              }),
            ),
          ),
          _buildInputView(),
          Builder(
            builder: (context) {
              final bottomPadding = MediaQuery.of(context).padding.bottom;
              final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

              final height = (keyboardHeight > 0) ? 0.0 : bottomPadding;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: height,
                color: COLOR.color_0B1018,
              );
            },
          ),
        ],
      ),
    );
  }
}
