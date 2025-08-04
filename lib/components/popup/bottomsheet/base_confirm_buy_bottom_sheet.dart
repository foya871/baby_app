import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/easy_button.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/popup/bottomsheet/abstract_bottom_sheet.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/services/user_service.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../generate/app_image_path.dart';

class BaseConfirmBuyBottomSheet extends AbstractBottomSheet {
  ///
  String? titleText;
  TextStyle? titleStyle;
  Widget? titleWidget;

  ///
  VoidCallback? onTapClose;
  bool autoBackOnTapClose;

  ///
  String? desc1Text;
  TextStyle? desc1Style;
  Widget? desc1Widget;

  ///
  String? desc2Text;
  TextStyle? desc2Style;
  Widget? desc2Widget;

  ///
  String? priceText;

  VoidCallback? onTapRecharge;
  Function(int payType)? onTapPay;
  bool autoBackOnTapConfirm;

  final payType = 1.obs;

  BaseConfirmBuyBottomSheet(
      {this.titleText,
      this.titleStyle,
      this.titleWidget,
      this.onTapClose,
      this.autoBackOnTapClose = true,
      this.desc1Text,
      this.desc1Style,
      this.desc1Widget,
      this.desc2Text,
      this.desc2Style,
      this.desc2Widget,
      this.priceText,
      this.autoBackOnTapConfirm = false,
      this.onTapPay,
      this.onTapRecharge})
      : super(
          isDismissible: true,
          backgroundColor: Colors.transparent,
          borderRadius: Styles.borderRaidus.top(10.w),
        );

  Widget _buildCloseButton() {
    return ImageView(
      src: AppImagePath.ann_cancel,
      width: 30.w,
      height: 30.w,
    ).paddingRight(10.w).onOpaqueTap(() {
      if (onTapClose != null) {
        onTapClose!();
      } else {
        Get.back();
      }
    });
  }

  Widget? _buildTitle() {
    Widget? widget = titleWidget;
    if (widget == null) {
      if (priceText != null) {
        widget = Text(
          "本次需支付${priceText!}",
          style: titleStyle ??
              TextStyle(
                color: Styles.color.bgColor,
                fontSize: Styles.fontSize.lm,
                fontWeight: FontWeight.w600,
              ),
        );
      }
    }
    return widget;
  }

  Widget _buildDesc1() {
    if (desc1Widget != null) {
      return desc1Widget!;
    }
    return Text(
      desc1Text ?? "支付方式",
      style: desc1Style ??
          TextStyle(
            color: Styles.color.bgColor,
            fontSize: 15.w,
          ),
    );
  }

  Widget _buildDesc2() {
    if (desc2Widget != null) {
      return desc2Widget!;
    }

    return Text(
      desc2Text ?? "1金币=10萝莉币",
      style: desc2Style ??
          TextStyle(
            color: COLOR.color_8e8e93,
            fontSize: 13.w,
          ),
    );
  }

  Widget _buildCoinBalance(int type) {
    final isGold = type == 1;
    final goldNum = Get.find<UserService>().assets.gold ?? 0;
    final loliNum = Get.find<UserService>().assets.integral ?? 0;

    return Obx(() {
      return AppBgView(
        width: 170.w,
        height: 47.w,
        backgroundColor: COLOR.color_f3f5f8,
        border: type == payType.value
            ? Border.all(color: COLOR.color_63d2ff, width: 1.w)
            : null,
        borderRadius: BorderRadius.circular(10.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageView(
                  src: isGold
                      ? AppImagePath.app_default_pay_gold_coin
                      : AppImagePath.app_default_pay_loli_coin,
                  width: 27.w,
                  height: 27.w,
                ),
                5.w.horizontalSpace,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: isGold ? "金币" : "萝莉币",
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 13.w,
                    ),
                    TextView(
                      text: "余额：${isGold ? "$goldNum" : "$loliNum"}",
                      color: Colors.black,
                      fontSize: 11.w,
                    ),
                  ],
                )
              ],
            ),
            type == payType.value
                ? Positioned(
                    right: 0,
                    bottom: 0,
                    child: ImageView(
                      src: AppImagePath.app_default_pay_selected,
                      width: 18.w,
                      height: 18.w,
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
        onTap: () {
          payType.value = type;
        },
      );
    });
  }

  Widget _buildRecharge() {
    return EasyButton(
      "充值金币",
      width: 170.w,
      height: 37.w,
      borderRadius: BorderRadius.circular(37.w / 2),
      borderColor: COLOR.color_63d2ff,
      borderWidth: 1.w,
      backgroundColor: Colors.white,
      textStyle: TextStyle(
          color: COLOR.color_63d2ff,
          fontSize: 15.w,
          fontWeight: FontWeight.w500),
      onTap: () {
        onTapRecharge?.call();
        if (autoBackOnTapConfirm) {
          Get.back();
        }
      },
    );
  }

  Widget _buildPay() {
    return EasyButton(
      "立即支付",
      width: 170.w,
      height: 37.w,
      borderRadius: BorderRadius.circular(37.w / 2),
      backgroundColor: COLOR.color_63d2ff,
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 15.w,
        fontWeight: FontWeight.w500,
      ),
      onTap: () {
        if (autoBackOnTapConfirm) {
          Get.back();
        }
        onTapPay?.call(payType.value);
      },
    );
  }

  Widget _buildColumn() {
    Widget? title = _buildTitle();
    final desc1 = _buildDesc1();
    final desc2 = _buildDesc2();

    final children = <Widget>[];

    if (titleWidget != null) {
      children.add(titleWidget!);
    } else if (title != null) {
      children.add(title);
    }

    children.add(15.w.verticalSpace);
    final descWidget = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [desc1, desc2],
    );
    children.add(descWidget);

    children.add(10.w.verticalSpace);
    final coinWidget = Row(
      spacing: 5.w,
      children: [_buildCoinBalance(1), _buildCoinBalance(2)],
    );

    children.add(coinWidget);
    children.add(15.w.verticalSpace);

    final buttons = Row(
      spacing: 5.w,
      children: [_buildRecharge(), _buildPay()],
    );

    children.add(buttons);
    return Column(children: children);
  }

  @override
  Widget build() {
    final contentHeight = 240.w;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildCloseButton(),
        10.w.verticalSpace,
        Container(
          height: contentHeight,
          decoration:
              BoxDecoration(borderRadius: borderRadius, color: Colors.white),
          padding: EdgeInsets.only(
              top: 15.w,
              left: 14.w,
              right: 14.w,
              bottom: ScreenUtil().bottomBarHeight),
          alignment: Alignment.center,
          child: _buildColumn(),
        ),
      ],
    );
  }
}
