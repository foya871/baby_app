import 'package:baby_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/rich_text_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../generate/app_image_path.dart';
import 'withdrawal_page_controller.dart';

class WithdrawalPage extends GetView<WithdrawalPageController> {
  const WithdrawalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_0e141e,
      appBar: AppBar(
        title: Text('收益提现',
            style: TextStyle(
                fontSize: 17.w,
                fontWeight: FontWeight.w500,
                color: COLOR.white)),
        actions: [
          TextView(
            text: "记录",
            style: TextStyle(
                fontSize: 14.w,
                fontWeight: FontWeight.w500,
                color: COLOR.white),
          ).onOpaqueTap(() {
            Get.toNamed(Routes.mineWithdrawalRecord);
          }).marginRight(10.w),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildBodyView()),
          _buildSubmitButton(),
          30.verticalSpace,
        ],
      ).marginHorizontal(15.w),
    );
  }

  _buildBodyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        _buildTypeView(),
        20.verticalSpace,
        _buildTitleView('姓名'),
        _buildInputView(controller.nameController, '请输入姓名'),
        25.verticalSpace,
        Obx(() =>
            _buildTitleView(controller.isAliPay.value ? '支付宝账号' : '银行卡号')),
        Obx(() => _buildInputView(controller.accountController,
            controller.isAliPay.value ? '请输入支付宝账号' : '请输入银行卡号')),
        25.verticalSpace,
        _buildTitleView('提现金额'),
        _buildInputView(
          controller.amountController,
          '0',
          fontSize: 30.w,
          keyboardType: TextInputType.number,
          prefix: TextView(
            text: '¥ ',
            fontSize: 18.w,
            color: COLOR.white.withValues(alpha: 0.6),
          ).marginTop(8.w),
          suffix: TextView(
            text: '全部提现',
            fontSize: 14.w,
            color: COLOR.themeSelectedColor,
          ).onOpaqueTap(() {
            controller.amountController.text =
                '${(controller.userService.assets.gold ?? 0).toInt()}';
          }),
        ),
        15.verticalSpace,
        Row(
          children: [
            RichTextView(
              text: '余额：${controller.userService.assets.gold ?? 0}',
              specifyTexts: ['${controller.userService.assets.gold ?? 0}'],
              style: TextStyle(
                fontSize: 12.w,
                color: COLOR.white.withValues(alpha: 0.6),
              ),
              highlightStyle: TextStyle(
                fontSize: 14.w,
                color: COLOR.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Obx(() => RichTextView(
                  text:
                      '满${(controller.withdrawConfig.value.minQuota ?? 0).toInt()}可提现，最高额度:${(controller.withdrawConfig.value.maxQuota ?? 0).toInt()}',
                  specifyTexts: [
                    '${(controller.withdrawConfig.value.minQuota ?? 0).toInt()}',
                    '${(controller.withdrawConfig.value.maxQuota ?? 0).toInt()}',
                    '0'
                  ],
                  style: TextStyle(
                    fontSize: 12.w,
                    color: COLOR.white.withValues(alpha: 0.6),
                  ),
                  highlightStyle: TextStyle(fontSize: 12.w, color: COLOR.white),
                )),
          ],
        ),
        30.verticalSpace,
        TextView(
          text: '温馨提示：\n'
              '1.请填写正确的支付宝账号及姓名，如资料错误可能导致提现失败.\n'
              '2.提现到账时间为1-2个工作日，请留意银行卡账单状体.\n'
              '3.你的个人资料将严格保密，不会用于第三方.',
          color: COLOR.color_999999,
          fontSize: 12.w,
        ),
      ],
    );
  }

  _buildTypeView() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImageView(
              src: controller.isAliPay.value
                  ? AppImagePath.mine_withdrawal_ali_check
                  : AppImagePath.mine_withdrawal_ali_uncheck,
              height: 60.w,
              fit: BoxFit.fill,
            ).onOpaqueTap(() {
              controller.isAliPay.value = true;
            }),
            15.horizontalSpace,
            ImageView(
              src: controller.isAliPay.value
                  ? AppImagePath.mine_withdrawal_bank_uncheck
                  : AppImagePath.mine_withdrawal_bank_check,
              height: 60.w,
              fit: BoxFit.fill,
            ).onOpaqueTap(() {
              controller.isAliPay.value = false;
            }),
          ],
        ));
  }

  _buildTitleView(String title) {
    return TextView(
      text: title,
      color: COLOR.white,
      fontSize: 16.w,
      fontWeight: FontWeight.w500,
    );
  }

  _buildInputView(
    TextEditingController controller,
    String hintText, {
    double? fontSize,
    Widget? prefix,
    Widget? suffix,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: fontSize ?? 14.w, color: COLOR.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: fontSize ?? 14.w,
            color: COLOR.white.withValues(alpha: 0.6)),
        prefixIcon: prefix,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        suffixIcon: suffix,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        border: UnderlineInputBorder(
            borderSide: BorderSide(
          color: COLOR.white.withValues(alpha: 0.3),
          width: 1,
        )),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: COLOR.white,
          width: 1,
        )),
      ),
      cursorColor: COLOR.white,
      keyboardType: keyboardType ?? TextInputType.text,
    );
  }

  _buildSubmitButton() {
    return AppBgView(
      height: 40.w,
      radius: 20.w,
      backgroundColor: COLOR.hexColor("#009fe8"),
      text: '确认提现',
      textColor: COLOR.white,
      textSize: 14.w,
      onTap: () => controller.startWithdraw(),
    );
  }
}
