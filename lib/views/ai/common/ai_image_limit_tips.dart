import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../services/user_service.dart';
import '../../../utils/color.dart';

class AiImageLimitTips extends StatelessWidget {
  const AiImageLimitTips({super.key});

  @override
  Widget build(BuildContext context) {
    const size = '2M';
    const interval = '60';
    return Obx(
      () {
        final aiNum = '${Get.find<UserService>().user.aiNum}';
        return EasyRichText(
          '图片不可超过$size，上传间隔为$interval秒，您有免费次数$aiNum',
          defaultStyle: TextStyle(
            color: COLOR.color_666666,
            fontSize: 12.w,
            fontWeight: FontWeight.w500,
          ),
          patternList: [
            EasyRichTextPattern(
              targetString: size,
              style: TextStyle(color: COLOR.color_B940FF, fontSize: 12.w),
            ),
            EasyRichTextPattern(
              targetString: interval,
              stringAfterTarget: '秒',
              matchWordBoundaries: false,
              style: TextStyle(color: COLOR.color_B940FF, fontSize: 12.w),
            ),
            EasyRichTextPattern(
              targetString: aiNum,
              stringBeforeTarget: '次数',
              matchWordBoundaries: false,
              style: TextStyle(color: COLOR.color_B940FF, fontSize: 12.w),
            )
          ],
        );
      },
    );
  }
}
