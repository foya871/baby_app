import 'package:get/get.dart';
import 'package:baby_app/components/pay/pay_enum.dart';
import 'package:baby_app/components/pay/pay_page.dart';
import 'package:baby_app/utils/color.dart';

import '../../../components/pay/model/gold_model.dart';
import '../../../http/api/api.dart';
import '../../../services/user_service.dart';
import '../../../utils/logger.dart';

class WalletPageController extends GetxController {
  final userService = Get.find<UserService>();

  RxList<GoldModel> goldList = <GoldModel>[].obs;
  Rx<GoldModel> currentGoldCard = GoldModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _getVipCards();
  }

  _getVipCards() async {
    try {
      Api.getVipGoldCards().then((response) {
        if (response != null) {
          goldList.assignAll(response.goldVipList ?? []);
          if (goldList.isNotEmpty) {
            currentGoldCard.value = goldList.first;
          }
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  statPay() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: COLOR.color_13141F,
      PayPage(
        amount: currentGoldCard.value.price ?? 0,
        payId: currentGoldCard.value.goldId ?? 0,
        purType: PurTypeEnum.gold,
        payType: currentGoldCard.value.types ?? [],
        onPaySuccess: () {},
      ),
    );
  }
}
