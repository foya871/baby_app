import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/model/message/message_model.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:baby_app/views/mine/message/message_detail/views/picture_message_view.dart';
import 'package:baby_app/views/mine/message/message_detail/views/text_mesage_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageCell extends StatelessWidget {
  const MessageCell({
    super.key,
    this.isMe = false,
    required this.message,
  });

  final MessageModel message;

  final bool isMe;

  Widget _buildContentView() {
    // 消息类型 0-时间，1-文字，2-图片
    switch (message.msgType) {
      case 0:
        return TextView(
          text: Utils.dateFmtWith(
              message.createdAt ?? '', ['yyyy', '.', 'mm', '.', 'dd']),
          style: TextStyle(
            fontSize: 12.w,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        );
      case 1:
        return TextMesasgeView(
          text: message.content ?? '',
          isMe: isMe,
        );
      case 2:
        return PictureMessageView(
          url: message.imgs?.first ?? "",
          isMe: isMe,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 如果是日期分隔符（msgType=0），居中显示
    if (message.msgType == 0) {
      return Align(
        alignment: Alignment.center,
        child: _buildContentView(),
      );
    }

    // 普通消息显示
    final children = [
      ImageView(
        src: message.sendLogo ?? AppImagePath.app_default_avatar,
        width: 36.w,
        height: 36.w,
        borderRadius: BorderRadius.circular(36.w / 2),
      ),
      10.horizontalSpace,
      _buildContentView()
    ];

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isMe ? children.reversed.toList() : children,
    );
  }
}
