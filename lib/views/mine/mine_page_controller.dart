import 'dart:io';

import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/ad_jump.dart';
import 'package:baby_app/utils/app_utils.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:baby_app/views/mine/account_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../services/user_service.dart';

class MinePageController extends GetxController {
  final userService = Get.find<UserService>();
  var isFirstShow = false.obs;
  List<Tuple2> list1 = [];
  List<Tuple2> list2 = [];

  String appUrl = "";
  var permanentAddress = ''.obs;

  @override
  void onInit() {
    initViewData();
    super.onInit();
    // getAppUrl();
    // getPermanentAddress();
    if (GetPlatform.isAndroid) {
      if (!isFirstShow.value &&
          (userService.user.account != null &&
              userService.user.account!.isNotEmpty)) {
        isFirstShow.value == true;
      }
    }
  }

  void initViewData() {
    list1.add(const Tuple2(AppImagePath.mine_icon_up_1, '我的帖子'));
    list1.add(const Tuple2(AppImagePath.mine_icon_up_2, '我的收藏'));
    list1.add(const Tuple2(AppImagePath.mine_icon_up_3, '我的关注'));
    list1.add(const Tuple2(AppImagePath.mine_icon_up_4, '原创入驻'));

    ///
    list2.add(const Tuple2(AppImagePath.mine_icon_down_1, '应用推荐'));
    list2.add(const Tuple2(AppImagePath.mine_icon_down_2, '我的购买'));
    if (!kIsWeb) list2.add(const Tuple2(AppImagePath.mine_icon_down_3, '下载缓存'));
    list2.add(const Tuple2(AppImagePath.mine_icon_down_4, '填写邀请码'));
    list2.add(const Tuple2(AppImagePath.mine_icon_down_5, '填写兑换码'));
    list2.add(const Tuple2(AppImagePath.mine_icon_down_6, '帮助反馈'));
    list2.add(const Tuple2(AppImagePath.mine_icon_down_7, '官方交流群'));
    if (Platform.isAndroid) {
      list2.add(const Tuple2(AppImagePath.mine_icon_down_8, '桌面图标'));
    }
  }

  onClick(String title) {
    switch (title) {
      case '消息中心':
        Get.toNamed(Routes.mineMessage);
        break;
      case '在线客服':
        kOnLineService();
        break;
      case '编辑资料':
      case '设置':
        Get.toNamed(Routes.mineSetting);
        break;
      case '复制':
        AppUtils.copyToClipboard((userService.user.userId ?? 0).toString());
        break;
      case '账号凭证':
        print("click 账号凭证");
        // showAccountDialog();
        Get.toNamed(Routes.mineAccountProfile);
        break;
      case 'VIP':
        Get.toVip();
        break;
      case '金币充值':
        Get.toWallet();
        break;
      case '分享邀请':
        Get.toShare();
        break;
      case '福利任务':
        Get.toNamed(Routes.reward);
        break;
      case 'AI':
        Get.toNamed(Routes.aiHome);
        break;
      case '我的帖子':
        Get.toNamed(Routes.minePublish);
        break;
      case '我的收藏':
        Get.toNamed(Routes.mineFavorites);
        break;
      case '我的关注':
        Get.toNamed(Routes.mineFollow);
        break;
      case '原创入驻':
        Get.toNamed(Routes.mineOriginalPage);
        break;
      case '应用推荐':
        Get.toNamed(Routes.mineAppRecommend);
        break;
      case '我的购买':
        Get.toNamed(Routes.minePurchase);
        break;
      case '下载缓存':
        Get.toNamed(Routes.mineDownloadPage);
        break;
      case '填写邀请码':
        if (userService.user.proxyCode?.isNotEmpty == true) {
          showToast("您已填写过邀请码");
          return;
        }
        Get.toNamed(Routes.mineInvitePage);
        break;
      case '填写兑换码':
        Get.toNamed(Routes.mineExchange);
        break;
      case '帮助反馈':
        Get.toNamed(Routes.mineFeedback);
        break;
      case '官方交流群':
        Get.toNamed(Routes.mineGroup);
        break;
      case '桌面图标':
        Get.toNamed(Routes.mineChangeIcon);
        break;
      case '历史记录':
        Get.toNamed(Routes.mineHistory);
        break;
      case '我的点赞':
        Get.toNamed(Routes.mineLike);
        break;
      default:
        break;
    }
  }

  getAppUrl() {
    Api.getRecommendH5Url().then((response) {
      if (response.isNotEmpty) {
        appUrl = response;
      }
    });
  }

  getPermanentAddress() {
    Api.getPermanentAddress().then((response) {
      if (response.isNotEmpty) {
        permanentAddress.value = response.first.domain ?? "";
      }
    });
  }

  showAccountDialog() {
    SmartDialog.show(
        clickMaskDismiss: true,
        alignment: Alignment.center,
        builder: (context) {
          return const AccountPage();
        });
  }
}
