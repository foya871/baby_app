import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../assets/styles.dart';
import '../../../../components/easy_button.dart';
import '../../../../components/popup/bottomsheet/abstract_bottom_sheet.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/color.dart';

class AiCostGoldConfirmBottomSheet extends AbstractBottomSheet {
  final double cost;
  final VoidCallback? onConfirm;
  final bool autoBack;
  AiCostGoldConfirmBottomSheet(
    this.cost, {
    this.onConfirm,
    this.autoBack = true,
  }) : super(
          isScrolledControlled: true,
        );
  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox.shrink(),
        Text(
          '支付提示',
          style: TextStyle(
            fontSize: 18.w,
            fontWeight: FontWeight.w600,
            color: COLOR.black,
          ),
        ),
        const SizedBox.shrink(),
        // Image.asset(AppImagePath.app_default_close, width: 18.w, height: 18.w)
        //     .onTap(() => Get.back()),
      ],
    );
  }

  Widget _buildDesc() {
    return Text(
      '撩她需要支付${cost.toStringAsShort()}金币，确认支付吗?',
      style: TextStyle(
        color: COLOR.color_666666,
        fontSize: 14.w,
      ),
    );
  }

  Widget _buildCost() {
    return Text(
      '${cost.toStringAsShort()}金币',
      style: TextStyle(
        fontSize: 26.w,
        fontWeight: FontWeight.w600,
        color: COLOR.black,
      ),
    );
  }

  Widget _buildUserGold() {
    return Obx(() {
      final userService = Get.find<UserService>().assets.gold ?? .0;
      return Text(
        '金币余额:${userService.toStringAsShort()}',
        style: TextStyle(
          color: COLOR.color_666666,
          fontSize: 14.w,
        ),
      );
    });
  }

  Widget _buildConfirmButton() {
    return EasyButton(
      '确认',
      width: double.infinity,
      height: 48.w,
      backgroundColor: COLOR.themeSelectedColor,
      textStyle: TextStyle(
        color: COLOR.white,
        fontSize: 16.w,
        fontWeight: FontWeight.w500,
      ),
      borderRadius: Styles.borderRadius.all(30.w),
      onTap: () {
        if (autoBack) {
          Get.back();
        }
        onConfirm?.call();
      },
    );
  }

  @override
  Widget build() {
    return Container(
      height: 300.w,
      decoration: BoxDecoration(
        color: COLOR.white,
        borderRadius: Styles.borderRadius.all(8.w),
      ),
      child: Column(
        children: [
          28.verticalSpaceFromWidth,
          _buildTitleRow(),
          23.verticalSpaceFromWidth,
          _buildDesc(),
          30.verticalSpaceFromWidth,
          _buildCost(),
          9.verticalSpaceFromWidth,
          _buildUserGold(),
          28.verticalSpaceFromWidth,
          _buildConfirmButton(),
        ],
      ).marginHorizontal(33.w),
    );
  }
}
