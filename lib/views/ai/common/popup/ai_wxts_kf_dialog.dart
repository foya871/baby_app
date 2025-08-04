import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../assets/styles.dart';
import '../../../../components/easy_button.dart';
import '../../../../components/popup/dialog/abstract_dialog.dart';
import '../../../../utils/ad_jump.dart';
import '../../../../utils/color.dart';

class AiWxtsKfDialog extends AbstractDialog {
  AiWxtsKfDialog() : super(borderRadius: Styles.borderRadius.all(12.w));

  Widget _buildTitle() {
    return Text(
      '温馨提示',
      style: TextStyle(
        fontSize: 16.w,
        fontWeight: FontWeight.w500,
        color: COLOR.color_333333,
      ),
    );
  }

  Widget _buildDesc() {
    final style = TextStyle(fontSize: 12.w, color: COLOR.color_333333);
    final highlightStyle = style.copyWith(color: COLOR.color_B940FF);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('1.订单超过12个小时未处理请及时联系在线客服进行解决', style: style),
        Text('2.去衣效果不理想，超过两次重绘将在第二次进行人工去衣，人工会在48小时内给您制作完成', style: style),
        EasyRichText(
          '3.专属定制AI换脸长视频请联系在线客服',
          defaultStyle: style,
          patternList: [
            EasyRichTextPattern(
              targetString: '3.专属定制AI换脸长视频',
              style: highlightStyle,
            )
          ],
        ),
        EasyRichText(
          '4.专属定制视频去衣请联系在线客服',
          defaultStyle: style,
          patternList: [
            EasyRichTextPattern(
              targetString: '4.专属定制视频去衣',
              style: highlightStyle,
            )
          ],
        ),
        Text('5.有其他问题欢迎联系在线客服，我们会在第一时间尽享处理', style: style),
      ].joinHeight(10.w),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EasyButton(
          '在线客服',
          width: 112.w,
          height: 36.w,
          backgroundColor: COLOR.color_E5E5E5,
          textStyle: TextStyle(
            fontSize: 16.w,
            color: COLOR.color_666666,
          ),
          borderRadius: Styles.borderRadius.all(18.w),
          onTap: () {
            Get.back();
            kOnLineService();
          },
        ),
        EasyButton(
          '明白了',
          width: 112.w,
          height: 36.w,
          textStyle: TextStyle(
            fontSize: 16.w,
            color: COLOR.white,
          ),
          backgroundGradient: Styles.gradient.purpleDeepToLight,
          borderRadius: Styles.borderRadius.all(18.w),
          onTap: () => Get.back(),
        )
      ],
    );
  }

  @override
  Widget build() {
    return Container(
      padding: EdgeInsets.only(
        top: 15.w,
        bottom: 19.w,
      ),
      height: 332.w,
      width: 300.w,
      child: Column(
        spacing: 19.w,
        children: [
          _buildTitle(),
          const DefaultDivider(),
          _buildDesc().marginHorizontal(16.w),
          _buildButtons().marginHorizontal(30.w),
        ],
      ),
    );
  }
}
