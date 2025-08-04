import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/pay/pay_utils.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../services/user_service.dart';
import '../../utils/ad_jump.dart';
import '../app_bg_view.dart';
import '../rich_text_view.dart';
import 'model/recharge_type_model.dart';
import 'pay_enum.dart';
import 'pay_view.dart';

class PayPage extends StatefulWidget {
  final double amount; //支付金额
  final int payId; //购买的ID
  //购买类型 (1-常规充值; 2-购买VIP; 3-购买金币; 4-购买门票; 5-购买AI_VIP会员)
  final PurTypeEnum purType; //购买类型
  final List<RechargeTypeModel> payType; //支付类型
  final bool isShowBalance; //是否显示余额
  final bool isAddBalancePay; //是否添加余额支付
  final bool isDefaultSelectedFirst; //是否默认选中第一个
  final bool isShowNotPayType; //是否显示没有支付方式
  final Function(PayTypeEnum purType)? onPaySelected; //选择的支付类型回调
  final Function()? onPaySuccess; //成功后才回调
  const PayPage({
    super.key,
    required this.amount,
    required this.payId,
    required this.purType,
    required this.payType,
    this.isShowBalance = true,
    this.isAddBalancePay = true,
    this.isDefaultSelectedFirst = true,
    this.isShowNotPayType = true,
    this.onPaySelected,
    this.onPaySuccess,
  });

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  final userService = Get.find<UserService>();
  var currentPayType = PayTypeEnum.unKnown;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        20.verticalSpace,
        //标题
        _buildTitleView(),
        24.verticalSpace,
        //支付选项
        _buildPayOptionsView(),
        20.verticalSpace,
        //支付说明
        _buildPayTipView(),
        30.verticalSpace,
        //支付按钮
        _buildBottomView(),
      ],
    ).marginHorizontal(15.w);
  }

  ///标题
  _buildTitleView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.close, color: COLOR.transparent, size: 24.w),
        const Spacer(),
        TextView(
          text: "选择支付方式",
          fontSize: 15.w,
          color: COLOR.white,
        ),
        const Spacer(),
        Icon(Icons.close, color: COLOR.color_999999, size: 24.w)
            .onTap(() => Get.back()),
      ],
    );
  }

  ///支付选项
  _buildPayOptionsView() {
    return PayView(
      payType: widget.payType,
      isShowBalance: widget.isShowBalance,
      isAddBalancePay: widget.isAddBalancePay,
      isDefaultSelectedFirst: widget.isDefaultSelectedFirst,
      isShowNotPayType: widget.isShowNotPayType,
      balance: userService.assets.bala ?? 0,
      onPaySelected: (payType) {
        currentPayType = payType;
        widget.onPaySelected?.call(payType);
      },
    );
  }

  ///支付说明
  _buildPayTipView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: "支付提示：",
          fontSize: 13.w,
          color: COLOR.white,
          fontWeight: FontWeight.w500,
        ),
        10.verticalSpace,
        TextView(
          text: "1. 因超时支付无法到帐，请重新发起支付\n"
              "2. 每天发起支付不能超过5次，连续发起且未支付，账号可能被加入黑名单",
          fontSize: 12.w,
          color: COLOR.color_999999,
        ),
      ],
    );
  }

  _buildBottomView() {
    return Column(
      children: [
        AppBgView(
          backgroundColor: COLOR.themeSelectedColor,
          height: 40.w,
          radius: 20.w,
          text: "¥${widget.amount} 立即支付",
          onTap: () {
            PayUtils.startPay(
              amount: widget.amount,
              payId: widget.payId,
              purType: widget.purType,
              payType: currentPayType,
              balance: userService.assets.bala ?? 0,
              onSuccess: () {
                userService.updateAll();
                widget.onPaySuccess?.call();
                Get.back();
              },
            );
          },
        ),
        15.verticalSpace,
        RichTextView(
          text: "如有问题请联系 在线客服",
          specifyTexts: const ["在线客服"],
          style: TextStyle(fontSize: 12.w, color: COLOR.color_999999),
          highlightStyle:
              TextStyle(fontSize: 12.w, color: COLOR.themeSelectedColor),
          onTap: (value) => kOnLineService(),
        ),
        30.verticalSpace,
      ],
    ).marginHorizontal(15.w);
  }
}
