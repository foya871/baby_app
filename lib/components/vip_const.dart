/*
 * @Author: wangdazhuang
 * @Date: 2024-08-27 21:28:21
 * @LastEditTime: 2024-08-27 21:30:34
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/src/components/vip_const.dart
 */
import 'package:baby_app/model/user/user_info_model.dart';
import 'package:baby_app/services/user_service.dart';
import 'package:get/get.dart';

class VipConst {
  static UserInfo userInfo = Get.find<UserService>().user;

  static getVipTypeName(int level) {
    String typeName = '';
    switch (level) {
      case 4:
        typeName = '月卡会员';
        break;
      case 5:
        typeName = '季卡会员';
        break;
      case 6:
        typeName = '年卡会员';
        break;
      case 8:
        typeName = '永久卡会员';
        break;
      case 10:
        typeName = '至尊卡会员';
        break;
      default:
        typeName = '你还未开通会员';
        break;
    }
    return typeName;
  }

  static isVip() {
    if (userInfo.vipType! > 0) {
      return true;
    } else {
      return false;
    }
  }

  static getPayTypeIcon(String payMent) {
    String icon = '';
    switch (payMent) {
      case '1001': //支付宝
        icon = 'assets/mine/icon_pay_alipay.png';
        break;
      case '1002': //微信
        icon = 'assets/mine/icon_pay_wechat.png';
        break;
      case '1003': //云闪付
        icon = 'assets/mine/icon_pay_ysf.png';
        break;
      default: //余额
        icon = 'assets/mine/icon_pay_balance.png';
        break;
    }
    return icon;
  }

  //支付类型 (0-余额; 1-支付宝; 2-微信; 3-云闪付)
  static getRechType(String payMent) {
    int rechType = 0;
    switch (payMent) {
      case '1001': //支付宝
        rechType = 1;
        break;
      case '1002': //微信
        rechType = 2;
        break;
      case '1003': //云闪付
        rechType = 3;
        break;
      default: //余额
        rechType = 0;
        break;
    }
    return rechType;
  }
}
