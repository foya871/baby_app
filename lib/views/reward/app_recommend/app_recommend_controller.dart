import 'package:get/get.dart';

import '../../../http/api/api.dart';
import '../../../model/application/application_partner_child_model.dart';
import '../../../utils/ad_jump.dart';

class AppRecommendController extends GetxController {
  final RxList<ApplicationPartnerChildModel> list =
      <ApplicationPartnerChildModel>[].obs;

  final RxList<ApplicationPartnerChildModel> bottom =
      <ApplicationPartnerChildModel>[].obs;

  var topLabel = 0;
  var bottomLabel = 1;

  AppRecommendController();

  //业务上 是去外链
  void toExternal(ApplicationPartnerChildModel item) async {
    jumpExternalURL(item.link ?? "");
    // Api.userReport();
  }

  @override
  void onReady() {
    super.onReady();
    requestList();
  }

  void requestList() async {
    list.value = await Api.getAdList(labelType: 0);
    // list.addAll(List.generate(10, (index) => ApplicationPartnerChildModel(name: "xxx")));

    bottom.value = await Api.getAdList(labelType: 1);
    // bottom.addAll(List.generate(10, (index) => ApplicationPartnerChildModel()));
  }

  //业务上 是去下载
  toDownload(ApplicationPartnerChildModel item) {
    jumpExternalURL(item.link ?? "");
    // Api.userReport(dailyBenefitNum: item);
  }
}
