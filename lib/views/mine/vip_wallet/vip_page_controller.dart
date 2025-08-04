import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/components/diolog/loading/loading_view.dart';
import 'package:baby_app/model/reward/point_model.dart';
import 'package:baby_app/utils/timer_utils.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:get/get.dart';

import '../../../components/pay/model/vip_model.dart';
import '../../../components/pay/pay_enum.dart';
import '../../../components/pay/pay_page.dart';
import '../../../http/api/api.dart';
import '../../../services/user_service.dart';
import '../../../utils/color.dart';
import '../../../utils/logger.dart';

class VipPageController extends GetxController {
  final userService = Get.find<UserService>();

  int get userPoints => userService.user.userPoints ?? 0;

  RxList<VipModel> vipList = <VipModel>[].obs;
  Rx<VipModel> currentVipCard = VipModel().obs;
  RxList<PointModel> pointList = <PointModel>[].obs;
  int currentIndex = 0;
  RxMap<int, List<String>> countdowns = <int, List<String>>{}.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _getVipCards();
    getPoints();
  }

  _getVipCards() async {
    try {
      Api.getVipGoldCards().then((response) {
        if (response != null) {
          vipList.assignAll(response.vipCardList ?? []);
          if (vipList.isNotEmpty) {
            currentVipCard.value = vipList.first;
            // startTimer();
          }
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  getPoints() {
    Api.getPointList().then((response) {
      if (response.isNotEmpty) {
        pointList.assignAll(response);
      }
    });
  }

  void startTimer() {
    for (int i = 0; i < vipList.length; i++) {
      var item = vipList[i];
      var expiredTimeInSeconds = (item.expiredTime ?? 0) / 1000;

      if (expiredTimeInSeconds <= 0) continue;

      TimerUtils.instance.startTimer(
        taskId: "vip_$i",
        intervalSeconds: 1,
        totalSeconds: expiredTimeInSeconds.toInt(),
        startImmediately: true,
        isCountdown: true,
        resetIfExists: true,
        onTimerTick: (elapsedSeconds) {
          String formattedTime = Utils.convertSeconds(elapsedSeconds);
          final formattedTimes = formattedTime.split(':');
          countdowns[i] = formattedTimes;
        },
        onTimerFinish: () {
          countdowns.remove(i);
          _getVipCards();
        },
      );
    }
  }

  statPay() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: COLOR.color_13141F,
      PayPage(
        amount: (currentVipCard.value.disPrice ?? 0).toDouble(),
        payId: currentVipCard.value.cardId ?? 0,
        purType: PurTypeEnum.vip,
        payType: currentVipCard.value.types ?? [],
        onPaySuccess: () {
          showToast("支付成功");
        },
      ),
    );
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
      userService.updateAll();
      showToast("兑换成功");
      update();
    }
  }

  @override
  void onClose() {
    for (int i = 0; i < vipList.length; i++) {
      String taskId = "vip_$i";
      TimerUtils.instance.cancelTimer(taskId);
    }
    super.onClose();
  }
}
