import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/app_bg_view.dart';
import '../../../routes/routes.dart';
import '../../../utils/color.dart';
import 'exchange_page_controller.dart';

class ExchangePage extends GetView<ExchangePageController> {
  const ExchangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('兑换码'),
        actions: [
          TextView(
            text: '兑换记录',
            color: COLOR.white,
            fontSize: 14.w,
          ).onOpaqueTap(() => Get.toNamed(Routes.mineExchangeRecord)),
          15.horizontalSpace,
        ],
      ),
      body: Column(
        children: [
          _buildBodyView(),
          _buildSubmitButton(),
          30.verticalSpace,
        ],
      ),
    );
  }

  _buildBodyView() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 20.verticalSpace,
          // TextView(
          //   text: '输入兑换码',
          //   fontSize: 16.w,
          //   color: COLOR.white,
          //   fontWeight: FontWeight.w500,
          // ),
          20.verticalSpace,
          Container(
            decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(8.w)),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: _buildInputView(),
          ),
          20.verticalSpace,
          TextView(
            text: '温馨提示：\n'
                '1.每个兑换码只能输入一次.\n'
                '2.官方社区领取更多福利.',
            fontSize: 12.w,
            color: COLOR.color_999999,
          ),
          20.verticalSpace,
        ],
      ),
    );
  }

  _buildInputView() {
    return TextField(
      controller: controller.codeController,
      style: TextStyle(fontSize: 14.w, color: COLOR.white),
      decoration: InputDecoration(
        hintText: '请输入兑换码 (字母大写)',
        hintStyle: TextStyle(
            fontSize: 14.w, color: COLOR.white.withValues(alpha: 0.6)),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      cursorColor: COLOR.white,
      keyboardType: TextInputType.text,
    );
  }

  _buildSubmitButton() {
    return AppBgView(
      height: 40.w,
      radius: 20.w,
      backgroundColor: COLOR.themeSelectedColor,
      text: "立即兑换",
      textSize: 14.w,
      textColor: COLOR.white,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      onTap: () => controller.submit(),
    );
  }
}
