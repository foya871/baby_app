import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/model/message/message_notice_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessageCommentListCell extends StatelessWidget {
  const MessageCommentListCell({super.key, required this.model});

  final MessageNoticeModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageView(
          src: model.producerLogo ?? '',
          width: 44.w,
          height: 44.w,
          borderRadius: BorderRadius.circular(44.w / 2),
        ).onOpaqueTap(() {
          final id = model.producerUserId;
          //TODO: 跳转用户详情
        }),
        10.horizontalSpace,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 7.w,
                children: [
                  TextView(
                    text: model.producerName ?? '',
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  TextView(
                    text: model.msgActionDesc ?? '',
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ],
              ),
              2.verticalSpaceFromWidth,
              TextView(
                text: Utils.dateAgo(model.createdAt ?? ''),
                fontSize: 12.w,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.6),
              ),
              11.verticalSpaceFromWidth,
              AppBgView(
                radius: 4.w,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                height: 60.w,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                child: Row(
                  children: [
                    ImageView(
                      src: model.quoteMsg?.quoteSubImg ??
                          AppImagePath.app_default_placeholder_v,
                      width: 50.w,
                      height: 50.w,
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    10.horizontalSpace,
                    TextView(
                      text: model.quoteMsg?.quoteSubContent ?? '',
                      fontSize: 14.w,
                      color: Colors.white.withValues(alpha: 0.8),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                onTap: () {
                  final id = model.quoteMsg?.quoteSubId;
                  if (model.quoteMsg?.quoteSubLinkType == 1) {
                    Get.toCommunityDetail(dynamicId: id ?? 0);
                  } else if (model.quoteMsg?.quoteSubLinkType == 2) {
                    Get.toPlayVideo(videoId: id ?? 0);
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
