import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/app_bg_view.dart';
import '../../../utils/color.dart';
import 'invite_page_controller.dart';

class InvitePage extends GetView<InvitePageController> {
  const InvitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('邀请码')),
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
          20.verticalSpace,
          Container(
            decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(8.w)),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: _buildInputView(),
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
        hintText: '请输入邀请码',
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
      text: "确定",
      textSize: 14.w,
      textColor: COLOR.white,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      onTap: () => controller.submit(),
    );
  }
}
