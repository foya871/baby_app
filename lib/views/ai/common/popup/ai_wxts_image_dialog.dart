import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/styles.dart';
import '../../../../components/easy_button.dart';
import '../../../../components/popup/dialog/abstract_dialog.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../utils/color.dart';

class AiWxtsImageDialog extends AbstractDialog {
  final VoidCallback onConfirm;
  AiWxtsImageDialog({required this.onConfirm})
      : super(borderRadius: Styles.borderRadius.l);

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EasyButton(
          '取消',
          width: 117.5.w,
          height: 37.w,
          backgroundColor: COLOR.color_F2F2F2,
          textStyle: TextStyle(fontSize: 15.w, color: COLOR.color_8e8e93),
          borderRadius: Styles.borderRadius.all(18.5.w),
          onTap: () => Get.back(),
        ),
        EasyButton(
          '同意并上传',
          width: 117.5.w,
          height: 37.w,
          textStyle: TextStyle(
            fontSize: 15.w,
            color: COLOR.white,
            fontWeight: FontWeight.w500,
          ),
          borderRadius: Styles.borderRadius.all(18.5.w),
          backgroundColor: COLOR.themeSelectedColor,
          onTap: () {
            Get.back();
            onConfirm();
          },
        )
      ],
    );
  }

  @override
  Widget build() {
    return Container(
      padding: EdgeInsets.only(
        left: 14.w,
        right: 14.w,
        top: 26.w,
        bottom: 24.w,
      ),
      width: 275.w,
      decoration: BoxDecoration(
        color: COLOR.white,
        borderRadius: Styles.borderRadius.all(12.w),
      ),
      child: Column(
        spacing: 20.w,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AiWxtsImageTips(),
          _buildButtons(),
        ],
      ),
    );
  }
}

class AiWxtsImageTips extends StatelessWidget {
  const AiWxtsImageTips({super.key});

  Widget _buildTitle() {
    return Text(
      '注意事项',
      style: TextStyle(fontSize: 14.w),
    );
  }

  Widget _buildCases() {
    return Row(
      spacing: 20.w,
      children: [
        Image.asset(AppImagePath.ai_home_case_1, width: 58.w, height: 58.w),
        Image.asset(AppImagePath.ai_home_case_2, width: 58.w, height: 58.w),
        Image.asset(AppImagePath.ai_home_case_3, width: 58.w, height: 58.w),
      ],
    );
  }

  Widget _buildDesc() {
    // final headStyle = TextStyle(fontSize: 14.w, fontWeight: FontWeight.w500);
    final style = TextStyle(
        fontSize: 12.w, color: COLOR.primaryText.withValues(alpha: 0.8));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Align(
        //   alignment: Alignment.center,
        //   child: Text('照片相关说明', style: headStyle),
        // ),
        // 14.verticalSpaceFromWidth,
        Text(
            '1.您上传的图片系统仅用于视频图片合成，作品生成后，您可以在历史记录里删除您的图片平台不会拿做它用，处于您的因素考虑，当视频合成完成后，可以在历史记录里删除信息，仅您自己能看见或使用',
            style: style),
        5.verticalSpaceFromWidth,
        Text('2.上传图片尽量清晰，上传间隔60S', style: style),
        5.verticalSpaceFromWidth,
        Text('3.不支持多人图片，禁止上传未成年人，如发现面临封号', style: style),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Column(
        spacing: 10.w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          _buildCases(),
          _buildDesc(),
        ],
      );
}
