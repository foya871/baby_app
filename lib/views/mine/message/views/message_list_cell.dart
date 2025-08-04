import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/model/message/chat_list_model.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageListCell extends StatelessWidget {
  const MessageListCell({super.key, required this.model});

  final ChatListModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageView(
          src: model.logo ?? '',
          width: 48.w,
          height: 48.w,
          borderRadius: BorderRadius.circular(48.w / 2),
        ),
        8.horizontalSpace,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2.w,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: model.nickName ?? '',
                    fontSize: 13.w,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  TextView(
                    text: Utils.dateFmtWith(model.newMessageDate ?? '',
                        ['yyyy', '.', 'mm', '.', 'dd']),
                    fontSize: 11.w,
                    color: COLOR.color_999999,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: model.newMessage ?? '',
                    fontSize: 12.w,
                    color: COLOR.color_999999,
                  ),
                  if (model.noReadNum != 0)
                    AppBgView(
                      radius: 4.w,
                      backgroundColor: COLOR.color_f50d4b,
                      constraints: BoxConstraints(minWidth: 16.w),
                      height: 16.w,
                      borderRadius: BorderRadius.circular(16.w / 2),
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: TextView(
                        text: "${model.noReadNum}",
                        fontSize: 11.w,
                        color: Colors.white,
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
