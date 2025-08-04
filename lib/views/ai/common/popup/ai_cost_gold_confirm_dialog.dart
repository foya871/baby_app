import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../components/popup/dialog/base_confirm_dialog.dart';
import '../../../../utils/color.dart';

class AiCostGoldConfirmDialog extends BaseConfirmDialog {
  AiCostGoldConfirmDialog._(String cost,
      {super.onConfirm, required String name})
      : super(
          titleText: '温馨提示',
          descWidget: EasyRichText(
            '$cost金币解锁$name',
            defaultStyle: TextStyle(
              color: COLOR.primaryText.withValues(alpha: 0.7),
              fontSize: 16.w,
              fontWeight: FontWeight.w600,
            ),
            patternList: [
              EasyRichTextPattern(
                targetString: cost,
                style: const TextStyle(color: COLOR.themeSelectedColor),
              )
            ],
          ),
          cancelText: '取消',
          confirmText: '确定',
          autoBackOnCancel: true,
          autoBackOnConfirm: true,
        );

  AiCostGoldConfirmDialog.cloth(double cost, {required VoidCallback onConfirm})
      : this._(cost.toStringAsShort(), name: 'AI去衣', onConfirm: onConfirm);

  AiCostGoldConfirmDialog.faceImage(double cost,
      {required VoidCallback onConfirm})
      : this._(cost.toStringAsShort(), name: 'AI换脸', onConfirm: onConfirm);

  AiCostGoldConfirmDialog.faceVideo(double cost,
      {required VoidCallback onConfirm})
      : this._(cost.toStringAsShort(), name: 'AI视频', onConfirm: onConfirm);

  AiCostGoldConfirmDialog.faceCustom(double cost,
      {required VoidCallback onConfirm})
      : this._(cost.toStringAsShort(), name: '自定义换脸', onConfirm: onConfirm);
}
