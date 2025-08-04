import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/services/user_service.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:screenshot/screenshot.dart';

import '../rich_text_view.dart';

///自定义toast
showToast(String message, {double offsetY = 0}) {
  SmartDialog.showToast(
    message,
    alignment: Alignment(0, offsetY),
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: COLOR.translucent_50,
          borderRadius: BorderRadius.circular(5.w),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Text(
          message,
          style: TextStyle(
            color: COLOR.white,
            fontSize: 16.w,
          ),
        ),
      );
    },
  );
}

dismiss({String? tag}) async {
  await SmartDialog.dismiss(tag: tag);
}

showAlertDialog(
  BuildContext context, {
  double? width,
  double? height,
  Widget? titleWidget,
  String? title,
  TextStyle? titleTextStyle,
  Color? titleTextColor,
  String? message,
  int? messageMaxLines,
  List<String>? messageSpecifyText,
  TextStyle? messageSpecifyTextStyle,
  Color? messageSpecifyTextColor,
  TextStyle? messageTextStyle,
  Color? messageTextColor,
  TextAlign? messageTextAlign,
  Widget? content,
  String leftText = "取消",
  String rightText = "确定",
  TextStyle? leftTextStyle,
  TextStyle? rightTextStyle,
  Color? leftTextColor,
  Color? rightTextColor,
  VoidCallback? onLeftButton,
  VoidCallback? onRightButton,
  Color? leftBgColor,
  Color? rightBgColor,
  String? leftImage,
  String? rightImage,
  bool clickMaskDismiss = false,
  bool isSingleButton = false,
  VoidCallback? onMask,
  Color? backgroundColor,
  String? backgroundImage,
}) {
  SmartDialog.show(
    clickMaskDismiss: clickMaskDismiss,
    onMask: onMask,
    builder: (context) {
      return Container(
        width: width ?? 310.w,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? COLOR.color_090B16,
          borderRadius: BorderRadius.circular(12.w),
          image: backgroundImage != null
              ? DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            20.verticalSpace,
            titleWidget ??
                Text(
                  title ?? "温馨提示",
                  style: titleTextStyle ??
                      TextStyle(
                        color: titleTextColor ?? COLOR.white,
                        fontSize: 15.w,
                        fontWeight: FontWeight.w500,
                      ),
                ),
            20.verticalSpace,
            content ??
                RichTextView(
                  text: message ?? "",
                  specifyTexts: messageSpecifyText ?? [],
                  style: messageTextStyle ??
                      TextStyle(
                        color: messageTextColor ?? COLOR.white,
                        fontSize: 15.w,
                      ),
                  highlightStyle: messageSpecifyTextStyle ??
                      TextStyle(
                        color: messageSpecifyTextColor ?? COLOR.color_009FE8,
                        fontSize: 15.w,
                      ),
                  textAlign: messageTextAlign ?? TextAlign.center,
                  maxLines: messageMaxLines,
                ),
            27.verticalSpace,
            Row(
              children: [
                Visibility(
                    visible: !isSingleButton,
                    child: Expanded(
                        flex: 1,
                        child: AppBgView(
                          width: double.infinity,
                          height: 40.w,
                          backgroundColor:
                              leftBgColor ?? COLOR.white.withValues(alpha: 0.1),
                          imagePath: leftImage,
                          radius: 20.w,
                          text: leftText,
                          textSize: 13.w,
                          textColor: leftTextColor ??
                              COLOR.white.withValues(alpha: 0.8),
                          onTap: () async {
                            await dismiss();
                            onLeftButton?.call();
                          },
                        ))),
                Visibility(
                  visible: !isSingleButton,
                  child: 16.horizontalSpace,
                ),
                Expanded(
                    flex: 1,
                    child: AppBgView(
                      width: double.infinity,
                      height: 40.w,
                      backgroundColor: rightBgColor ?? COLOR.themeSelectedColor,
                      imagePath: rightImage,
                      radius: 20.w,
                      text: rightText,
                      textSize: 13.w,
                      textColor: rightTextColor ?? COLOR.white,
                      onTap: () async {
                        await dismiss();
                        onRightButton?.call();
                      },
                    )),
              ],
            ),
            20.verticalSpace,
          ],
        ),
      );
    },
  );
}

/// 显示购买作品弹窗，包含高斯模糊背景和购买信息
///
/// eg:
///  showToPayDialog(
//             discount: 0,
//             discountPrice: 80,
//             originPrice: 100,
//             myCoin: 100,
//             Get.context!,
//             onRightButton: () => logger.d("onRightButton"),
//             onRechargeButton: () => logger.d("onRechargeButton"),
//             onDiscountButton: () => logger.d("onDiscountButton"),
//             onMask: () => logger.d("onMask"),
//             onPay: () => logger.d("onPay"),
//           );
///
/// 参数说明：
/// [discountPrice] 折后价格
/// [originPrice] 原价
/// [discount] 折扣比例（0 表示无折扣）
/// [hideVipAndOrigin] 是否忽略原价和VIP
/// [myCoin] 用户当前金币数
/// [onRechargeButton] "充值"区域点击回调
/// [onDiscountButton] 折扣说明点击回调
/// [onPay] 购买点击回调
/// [clickMaskDismiss] 点击遮罩是否关闭弹窗（默认 false）
/// [isSingleButton] 是否为单按钮模式（隐藏左按钮）
/// [onMask] 点击遮罩的回调
/// [backgroundColor] 弹窗背景颜色
/// [backType] backType 默认normal 返回会关闭弹框
///  block 拦截返回事件, 不关闭dialog, 也不关闭页面
///  ignore 不拦截返回事件, 返回事件将不会关闭dialog

var _uniquePayDialogShowing = false;
showToPayDialog(
  BuildContext context, {
  required num discountPrice,
  required num originPrice,
  bool unique = false,
  int discount = 0,
  VoidCallback? onRechargeButton,
  VoidCallback? onDiscountButton,
  VoidCallback? onPay,
  bool clickMaskDismiss = false,
  bool isSingleButton = false,
  bool hideVipAndOrigin = false,
  VoidCallback? onMask,
  VoidCallback? onBack,
  Color? backgroundColor,
  SmartBackType? backType,
}) {
  if (unique) {
    if (_uniquePayDialogShowing) return;
    _uniquePayDialogShowing = true;
  }

  double myCoin = Get.find<UserService>().assets.gold ?? 0;
  final future = SmartDialog.show(
    backType: backType,
    alignment: Alignment.bottomCenter,
    clickMaskDismiss: clickMaskDismiss,
    onMask: onMask,
    builder: (context) {
      Widget _buildVipAndOrigin() {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextView(
                    text: '作品原价',
                    fontSize: 13.w,
                    color: COLOR.white,
                  ),
                ),
                TextView(
                  text: '$originPrice金币',
                  style: TextStyle(
                    fontSize: 13.w,
                    decorationColor: COLOR.white_50,
                    color: COLOR.white_50,
                    decoration: TextDecoration.lineThrough,
                  ),
                )
              ],
            ),
            20.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: TextView(
                    text: discount == 0 ? '您当前不享受折扣' : '您当前享受$discount折优惠',
                    fontSize: 13.w,
                    color: COLOR.white,
                  ),
                ),
                TextView(
                  text: discount == 0 ? '购买VIP享受折扣' : '升级会员免费看',
                  style: TextStyle(
                    fontSize: 13.w,
                    decorationColor: COLOR.white,
                    color: COLOR.white,
                    decorationThickness: 2,
                    decoration: TextDecoration.underline,
                  ),
                ).onTap(() async {
                  await dismiss();
                  onDiscountButton?.call();
                })
              ],
            ),
            20.verticalSpace,
          ],
        );
      }

      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 14.w),
                width: 1.sw,
                decoration:
                    BoxDecoration(color: backgroundColor ?? COLOR.color_13141F),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: TextView(
                            text: "购买作品",
                            fontSize: 17.w,
                            color: COLOR.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.close,
                            size: 22.w,
                            color: COLOR.color_999999,
                          ).onTap(() => dismiss()),
                        )
                      ],
                    ),
                    18.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: TextView(
                            text: '作品解锁',
                            fontSize: 13.w,
                            color: COLOR.white,
                          ),
                        ),
                        TextView(
                          text: '$discountPrice金币',
                          fontSize: 13.w,
                          color: COLOR.white,
                        )
                      ],
                    ),
                    20.verticalSpace,
                    if (!hideVipAndOrigin) _buildVipAndOrigin(),
                    Divider(
                      height: 1.w,
                      thickness: 1.w,
                      color: COLOR.white_10,
                    ),
                    20.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: TextView(
                            text: '我的金币',
                            fontSize: 13.w,
                            color: COLOR.white,
                          ),
                        ),
                        TextView(
                          text: '$myCoin金币',
                          fontSize: 13.5.w,
                          color: COLOR.white,
                        ),
                        10.horizontalSpace,
                        TextView(
                          text: '充值',
                          fontSize: 13.w,
                          color: COLOR.white,
                        )
                      ],
                    ).onOpaqueTap(() async {
                      await dismiss();
                      onRechargeButton?.call();
                    }),
                    32.verticalSpace,
                    Container(
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: COLOR.color_1F7CFF,
                        borderRadius: BorderRadius.circular(21.w),
                      ),
                      child: Center(
                        child: TextView(
                          text: '$discountPrice金币购买',
                          fontSize: 14.w,
                          color: COLOR.white,
                        ),
                      ),
                    ).onTap(() async {
                      await dismiss();
                      onPay?.call();
                    })
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  );

  future.then((_) {}).whenComplete(() {
    if (unique) {
      _uniquePayDialogShowing = false;
    }
  });
}

/// 参数说明：
/// [width] 弹窗宽度，默认 286.w
/// [height] 弹窗高度
/// [titleWidget] 自定义标题组件（可选）
/// [title] 标题文本（默认："支付失败"）
/// [titleTextStyle] 标题样式
/// [titleTextColor] 标题颜色
/// [message] 主提示信息（默认："金币余额不足"）
/// [messageTextStyle] 信息样式
/// [messageTextColor] 信息颜色
/// [messageTextAlign] 信息对齐方式
/// [content] 可选自定义内容组件
/// [leftText] 左按钮文字（默认："取消"）
/// [rightText] 右按钮文字（默认："立即充值"）
/// [leftTextStyle] 左按钮文字样式
/// [rightTextStyle] 右按钮文字样式
/// [leftTextColor] 左按钮文字颜色
/// [rightTextColor] 右按钮文字颜色
/// [onLeftButton] 左按钮点击回调
/// [onRightButton] 右按钮点击回调
/// [leftBgColor] 左按钮背景色
/// [rightBgColor] 右按钮背景色
/// [leftImage] 左按钮背景图
/// [rightImage] 右按钮背景图
/// [clickMaskDismiss] 点击遮罩是否关闭弹窗（默认 false）
/// [isSingleButton] 是否为单按钮模式（隐藏左按钮）
/// [onMask] 点击遮罩的回调
/// [backgroundColor] 弹窗背景颜色
/// [backgroundImage] 弹窗背景图
/// [backType] backType 默认normal 返回会关闭弹框
///  block 拦截返回事件, 不关闭dialog, 也不关闭页面
///  ignore 不拦截返回事件, 返回事件将不会关闭dialog

showPayFailedDialog(
  BuildContext context, {
  double? width,
  double? height,
  Widget? titleWidget,
  String? title,
  TextStyle? titleTextStyle,
  Color? titleTextColor,
  String? message,
  TextStyle? messageTextStyle,
  Color? messageTextColor,
  TextAlign? messageTextAlign,
  Widget? content,
  String leftText = "取消",
  String rightText = "立即充值",
  TextStyle? leftTextStyle,
  TextStyle? rightTextStyle,
  Color? leftTextColor,
  Color? rightTextColor,
  VoidCallback? onLeftButton,
  VoidCallback? onRightButton,
  Color? leftBgColor,
  Color? rightBgColor,
  String? leftImage,
  String? rightImage,
  bool clickMaskDismiss = false,
  bool isSingleButton = false,
  VoidCallback? onMask,
  VoidCallback? onBack,
  Color? backgroundColor,
  String? backgroundImage,
  SmartBackType? backType,
}) {
  SmartDialog.show(
    backType: backType,
    alignment: Alignment.center,
    clickMaskDismiss: clickMaskDismiss,
    onMask: onMask,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width ?? 286.w,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor ?? COLOR.color_13141F,
            borderRadius: BorderRadius.circular(12.w),
            image: backgroundImage != null
                ? DecorationImage(
                    image: AssetImage(backgroundImage),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, bottom: 25.w, top: 44.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              titleWidget ??
                  Text(
                    title ?? "支付失败",
                    style: titleTextStyle ??
                        TextStyle(
                          color: titleTextColor ?? COLOR.white,
                          fontSize: 16.w,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
              9.verticalSpace,
              content ??
                  Text(
                    message ?? "金币余额不足",
                    style: messageTextStyle ??
                        TextStyle(
                          color: messageTextColor ?? COLOR.white_70,
                          fontSize: 15.w,
                        ),
                    textAlign: messageTextAlign ?? TextAlign.start,
                  ),
              33.verticalSpace,
              Row(
                children: [
                  Visibility(
                      visible: !isSingleButton,
                      child: Expanded(
                          flex: 1,
                          child: AppBgView(
                            width: double.infinity,
                            height: 40.w,
                            backgroundColor: leftBgColor ?? COLOR.white_10,
                            imagePath: leftImage,
                            radius: 20.w,
                            text: leftText,
                            textSize: 14.w,
                            textColor: leftTextColor ?? COLOR.white_80,
                            onTap: () async {
                              await dismiss();
                              onLeftButton?.call();
                            },
                          ))),
                  Visibility(
                    visible: !isSingleButton,
                    child: 12.horizontalSpace,
                  ),
                  Expanded(
                      flex: 1,
                      child: AppBgView(
                        width: double.infinity,
                        height: 40.w,
                        backgroundColor: rightBgColor ?? COLOR.color_1F7CFF,
                        imagePath: rightImage,
                        radius: 20.w,
                        text: rightText,
                        textSize: 14.w,
                        textColor: rightTextColor ?? COLOR.white,
                        onTap: () async {
                          await dismiss();
                          onRightButton?.call();
                        },
                      )),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// 显示开通会员的底部弹框
///   eg
///   showToOpenVipDialog(
//             Get.context!,
//             message: "你还不是会员\n请购买VIP",
//             onRightButton: () => logger.d("onRightButton"),
//           );
///
/// 参数说明：
/// [width] 弹窗宽度，默认 286.w
/// [height] 弹窗高度
/// [titleWidget] 自定义标题组件（可选）
/// [title] 标题文本（默认："温馨提示"）
/// [titleTextStyle] 标题样式
/// [titleTextColor] 标题颜色
/// [message] 主提示信息（默认："你还不是会员，开通会员观看完整版"）
/// [messageTextStyle] 信息样式
/// [messageTextColor] 信息颜色
/// [messageTextAlign] 信息对齐方式
/// [content] 可选自定义内容组件
/// [leftText] 左按钮文字（默认："取消"）
/// [rightText] 右按钮文字（默认："开通会员"）
/// [leftTextStyle] 左按钮文字样式
/// [rightTextStyle] 右按钮文字样式
/// [leftTextColor] 左按钮文字颜色
/// [rightTextColor] 右按钮文字颜色
/// [onLeftButton] 左按钮点击回调
/// [onRightButton] 右按钮点击回调
/// [leftBgColor] 左按钮背景色
/// [rightBgColor] 右按钮背景色
/// [leftImage] 左按钮背景图
/// [rightImage] 右按钮背景图
/// [clickMaskDismiss] 点击遮罩是否关闭弹窗（默认 false）
/// [isSingleButton] 是否为单按钮模式（隐藏左按钮）
/// [onMask] 点击遮罩的回调
/// [backgroundColor] 弹窗背景颜色
/// [backgroundImage] 弹窗背景图
/// [backType] backType 默认normal 返回会关闭弹框
///  block 拦截返回事件, 不关闭dialog, 也不关闭页面
///  ignore 不拦截返回事件, 返回事件将不会关闭dialog
var _uniqueOpenVipDialogShowing = false;
showToOpenVipDialog(
  BuildContext context, {
  bool unique = false,
  double? width,
  double? height,
  Widget? titleWidget,
  String? title,
  TextStyle? titleTextStyle,
  Color? titleTextColor,
  String? message,
  TextStyle? messageTextStyle,
  Color? messageTextColor,
  TextAlign? messageTextAlign,
  Widget? content,
  String leftText = "取消",
  String rightText = "开通会员",
  TextStyle? leftTextStyle,
  TextStyle? rightTextStyle,
  Color? leftTextColor,
  Color? rightTextColor,
  VoidCallback? onLeftButton,
  VoidCallback? onRightButton,
  Color? leftBgColor,
  Color? rightBgColor,
  String? leftImage,
  String? rightImage,
  bool clickMaskDismiss = false,
  bool isSingleButton = true,
  VoidCallback? onMask,
  Color? backgroundColor,
  String? backgroundImage,
  SmartBackType? backType,
}) {
  if (unique) {
    if (_uniqueOpenVipDialogShowing) return;
    _uniqueOpenVipDialogShowing = true;
  }
  final future = SmartDialog.show(
    backType: backType,
    alignment: Alignment.bottomCenter,
    clickMaskDismiss: clickMaskDismiss,
    onMask: onMask,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: width ?? 1.sw,
                height: height,
                decoration: BoxDecoration(
                  color: backgroundColor ?? COLOR.color_13141F,
                  borderRadius: BorderRadius.circular(12.w),
                  image: backgroundImage != null
                      ? DecorationImage(
                          image: AssetImage(backgroundImage),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, bottom: 25.w, top: 19.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: titleWidget ??
                              Text(
                                title ?? "温馨提示",
                                style: titleTextStyle ??
                                    TextStyle(
                                      color: titleTextColor ?? COLOR.white,
                                      fontSize: 16.w,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.close,
                            size: 22.w,
                            color: COLOR.color_999999,
                          ).onTap(() => dismiss()),
                        )
                      ],
                    ),
                    44.verticalSpace,
                    content ??
                        TextView(
                          text: message ?? "你还不是会员\n开通会员即可观看完整版",
                          style: messageTextStyle ??
                              TextStyle(
                                height: 2.w,
                                color: messageTextColor ?? COLOR.white_60,
                                fontSize: 16.w,
                              ),
                          textAlign: messageTextAlign ?? TextAlign.center,
                        ),
                    65.verticalSpace,
                    Row(
                      children: [
                        Visibility(
                            visible: !isSingleButton,
                            child: Expanded(
                                flex: 1,
                                child: AppBgView(
                                  width: double.infinity,
                                  height: 40.w,
                                  backgroundColor:
                                      leftBgColor ?? COLOR.white_10,
                                  imagePath: leftImage,
                                  radius: 20.w,
                                  text: leftText,
                                  textSize: 14.w,
                                  textColor: leftTextColor ?? COLOR.white_80,
                                  onTap: () async {
                                    await dismiss();
                                    onLeftButton?.call();
                                  },
                                ))),
                        Visibility(
                          visible: !isSingleButton,
                          child: 12.horizontalSpace,
                        ),
                        Expanded(
                            flex: 1,
                            child: AppBgView(
                              width: double.infinity,
                              height: 40.w,
                              backgroundColor:
                                  rightBgColor ?? COLOR.color_1F7CFF,
                              imagePath: rightImage,
                              radius: 20.w,
                              text: rightText,
                              textSize: 14.w,
                              textColor: rightTextColor ?? COLOR.white,
                              onTap: () async {
                                await dismiss();
                                onRightButton?.call();
                              },
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  future.then((_) {}).whenComplete(() {
    if (unique) {
      _uniqueOpenVipDialogShowing = false;
    }
  });
}
