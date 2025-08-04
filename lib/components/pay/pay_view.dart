import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/image_view.dart';

import '../../generate/app_image_path.dart';
import '../../utils/color.dart';
import '../text_view.dart';
import 'model/recharge_type_model.dart';
import 'pay_enum.dart';

/// 支付列表控件，仅只做支付列表
/// 具体UI样式排版可根据UI改动
class PayView extends StatefulWidget {
  final List<RechargeTypeModel> payType; //支付类型
  final double? balance; //余额
  final bool isShowBalance; //是否显示余额
  final bool isAddBalancePay; //是否添加余额支付
  final bool isDefaultSelectedFirst; //是否默认选中第一个
  final bool isShowNotPayType; //是否显示没有支付方式
  final Function(PayTypeEnum purType)? onPaySelected; //选择的支付类型回调
  final Function()? onPaySuccess; //成功后才回调

  const PayView({
    super.key,
    required this.payType,
    this.balance,
    this.isShowBalance = true,
    this.isAddBalancePay = true,
    this.isDefaultSelectedFirst = true,
    this.isShowNotPayType = true,
    this.onPaySelected,
    this.onPaySuccess,
  });

  @override
  State<PayView> createState() => PayViewState();
}

class PayViewState extends State<PayView> {
  late List<RechargeTypeModel> payType; //支付类型
  final currentPayType = RechargeTypeModel.empty().obs;

  @override
  void initState() {
    super.initState();
    payType = widget.payType;
    if (widget.isAddBalancePay) {
      if (!payType.any((element) => element.payMent == '0001')) {
        payType.add(RechargeTypeModel.balance());
      }
    }

    if (widget.isDefaultSelectedFirst) {
      currentPayType.value = payType.first;
      widget.onPaySelected?.call(_getPayType(currentPayType.value));
    }
  }

  PayTypeEnum _getPayType(RechargeTypeModel model) {
    switch (model.payMent) {
      case '0001':
        return PayTypeEnum.balance;
      case '1001':
        return PayTypeEnum.alipay;
      case '1002':
        return PayTypeEnum.wechat;
      case '1003':
        return PayTypeEnum.unionPay;
      default:
        return PayTypeEnum.unKnown;
    }
  }

  @override
  void didUpdateWidget(PayView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.payType != oldWidget.payType) {
      payType = widget.payType;
      if (widget.isAddBalancePay) {
        if (!payType.any((element) => element.payMent == '0001')) {
          payType.add(RechargeTypeModel.balance());
        }
      }

      if (widget.isDefaultSelectedFirst) {
        currentPayType.value = payType.first;
        widget.onPaySelected?.call(_getPayType(currentPayType.value));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return payType.isEmpty
        ? widget.isShowNotPayType
            ? _buildNotPayTypeView()
            : const SizedBox.shrink()
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: payType.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  currentPayType.value = payType[index];
                  widget.onPaySelected?.call(_getPayType(currentPayType.value));
                },
                child: Obx(() => _buildPayOptionsItemView(
                    payType[index], currentPayType.value == payType[index])),
              );
            },
            separatorBuilder: (context, index) => 15.verticalSpace,
          );
  }

  /// 没有支付方式
  _buildNotPayTypeView() {
    return Container(
      width: double.infinity,
      height: 50.w,
      alignment: Alignment.center,
      child: Text(
        "暂无支付方式",
        style: TextStyle(color: Colors.grey, fontSize: 14.w),
      ),
    );
  }

  /// 支付选项Item
  _buildPayOptionsItemView(RechargeTypeModel rechargeType, bool isSelected) {
    String payIcon;
    if (rechargeType.isAlipay) {
      payIcon = AppImagePath.app_default_pay_ali;
    } else if (rechargeType.isWechat) {
      payIcon = AppImagePath.app_default_pay_wechat;
    } else if (rechargeType.isUnion) {
      payIcon = AppImagePath.app_default_pay_ysf;
    } else {
      payIcon = AppImagePath.app_default_pay_balance;
    }

    return Row(
      children: [
        ImageView(src: payIcon, width: 40.w, height: 40.w),
        10.horizontalSpace,
        TextView(
          text: rechargeType.name,
          fontSize: 14.w,
          color: COLOR.white,
        ),
        if (widget.isShowBalance && rechargeType.isBalance)
          TextView(
            text: " (${widget.balance ?? 0})",
            fontSize: 12.w,
            color: COLOR.white,
          ),
        const Spacer(),
        if (isSelected)
          Icon(
            Icons.check_circle,
            size: 24.w,
            color: COLOR.themeSelectedColor,
          ),
      ],
    );
  }
}
