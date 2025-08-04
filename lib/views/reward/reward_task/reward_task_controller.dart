import 'dart:async';

import 'package:baby_app/model/video_base_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/components/diolog/loading/loading_view.dart';
import 'package:baby_app/model/reward/point_model.dart';
import 'package:baby_app/model/reward/reward_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/services/user_service.dart';
import 'package:baby_app/utils/ad_jump.dart';
import 'package:baby_app/utils/utils.dart';

import '../../../http/api/api.dart';
import '../../../model/announcement/activity_model.dart';
import '../../../utils/color.dart';
import '../../main/controllers/main_controller.dart';

class RewardTaskController extends GetxController {
  var userService = Get.find<UserService>();
  RxList<VideoBaseModel> videoList = <VideoBaseModel>[].obs;
  RxList<PointModel> pointList = <PointModel>[].obs;
  RxList<RewardModel> rewardList = <RewardModel>[].obs;

  String get userAvatar => userService.user.logo ?? "";

  String get userName => userService.user.nickName ?? "";

  int get watchNum => userService.user.freeWatches ?? 0;

  int get userPoints => userService.user.userPoints ?? 0;

  int get userInviteNum => userService.user.inviteUserNum ?? 0;

  String get expireTime => userService.user.expiredVip ?? "";

  String get topTips =>
      !isVip ? "剩余观看次数$watchNum次" : "到期时间 ${Utils.dateFmt(expireTime)}";

  bool get isVip => userService.isVIP;

  var prefix = "新人限时特惠";
  var countDownTime = "".obs;
  var haveDuct = false.obs;
  var totalTime = 0;
  Timer? _timer;

  @override
  void onReady() {
    requestData();
    super.onReady();
  }

  //请求任务
  void requestData() async {
    await LoadingView.singleton.wrap(
        color: COLOR.white,
        context: Get.context!,
        background: COLOR.transparent,
        asyncFunction: () async {
          Api.getReward().then((value) {
            rewardList.value = value;
            rewardList.refresh();
          });
          Api.getDeduct().then((value) {
            if (value != null) {
              totalTime = value.countDown ?? 0;
              //如果不是VIP，且有新人特惠，显示
              haveDuct.value = !isVip;
              calculateTime();
            }
          });
          Api.getPointList().then((value) {
            pointList.value = value;
            pointList.refresh();
          });
          videoList.value = await Api.getFreeVideoList();
          videoList.refresh();
        });
    refreshUser();
  }

  void refreshUser() async {
    //上半部分变化
    await userService.updateAll();
    update();
  }

  //页面可见，刷新上面任务状态
  void refreshTop() async {
    await LoadingView.singleton.wrap(
        color: COLOR.white,
        context: Get.context!,
        background: COLOR.transparent,
        asyncFunction: () async {
          rewardList.value = await Api.getReward();
          rewardList.refresh();
        });
    refreshUser();
  }

  //兑换积分
  void exchangePoint(PointModel model) {
    if (model.redemptionType == 4) {
      if (userPoints < (model.redemptionIntegral ?? 0)) {
        showToast("积分不足");
        return;
      }
      //神秘盲盒
      showToast("库存不足");
      return;
    }
    _exchange(model);
  }

  //实际兑换接口调用
  void _exchange(PointModel model) async {
    var success = await LoadingView.singleton.wrap(
        color: COLOR.white,
        context: Get.context!,
        asyncFunction: () async {
          return await Api.exchangePoint(model);
        });
    if (success) {
      //上半部分变化
      showToast("兑换成功");
      refreshUser();
    }
  }

  //福利兑换详情
  void exchangeDetail() {
    Get.toNamed(Routes.exchangeRewardRecord);
  }

  //VIP限免专区
  void toVideoFree() {
    Get.toNamed(Routes.rewardVideo);
  }

  //跳转路由
  // 每日福利编号(1.每日登陆 2.发帖并通过审核 3.发表评论 4.下载app )
  // 1.每日登陆  不跳转 当前页面领取
  // 2.发帖并通过审核  跳转到社区
  // 3.发表评论 跳到首页
  // 4.下载app  跳转到外部
  void toTask(int? dailyBenefitNum, String url) {
    switch (dailyBenefitNum) {
      case 2:
        Get.toNamed(Routes.communityRelease);
        break;
      case 3:
        Get.find<MainController>().changeMainTabIndex(0);
        break;
      case 5:
        Get.toVip();
        break;
      case 4:
        jumpExternalURL(url);
        Api.userReport(dailyBenefitNum: dailyBenefitNum ?? 0);
        break;
      case 1:
        break;
    }
  }

  //将totalTime 转换为hh:mm:ss
  //并且开始倒计时
  void calculateTime() {
    // 先清理旧的定时器
    _timer?.cancel();

    // 毫秒转秒，向上取整，防止有小数
    int seconds = (totalTime / 1000).ceil();

    totalTime = seconds;
    // 立即显示一次
    countDownTime.value = prefix + _formatTime(totalTime);

    // 开始倒计时
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (totalTime <= 0) {
        timer.cancel();
        countDownTime.value = "${prefix}00:00:00";
      } else {
        totalTime--;
        countDownTime.value = prefix + _formatTime(totalTime);
      }
    });
  }

  // 格式化秒为 hh:mm:ss
  String _formatTime(int seconds) {
    int h = seconds ~/ 3600;
    int m = (seconds % 3600) ~/ 60;
    int s = seconds % 60;
    return '${h.toString().padLeft(2, '0')}:'
        '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
