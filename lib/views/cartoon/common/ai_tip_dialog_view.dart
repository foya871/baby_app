import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';

class AiTipDialogView extends StatelessWidget {
  const AiTipDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
        25.verticalSpace,
        TextView(
          text: "照片相关说明",
          fontSize: 14.w,
        ),
        15.verticalSpace,
        TextView(
          text: "1.您上传的图片系统仅用于视频图片合成，作品生成后，您可以在历史记录里删除您的图片，平台不会拿做它用，"
              "处于您的因素考虑，当视频合成完成后，"
              "可以在历史记录里删除信息，仅您自己能看见或使用\n\n"
              "2.上传图片尽量清晰，上传间隔60S\n\n"
              "3.不支持多人图片，禁止上传未成年人，如发现面临封号",
          fontSize: 12.w,
        )
      ],
    );
  }
}
