import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/community/community_model.dart';
import 'package:baby_app/model/mine/promote_income_stat_model.dart';

import '../../../../model/mine/profit_dynamic_item_model.dart';
import '../../../../services/user_service.dart';

class IncomePageController extends GetxController {
  final userService = Get.find<UserService>();
  EasyRefreshController refreshController = EasyRefreshController();
  PagingController<int, ProfitDynamicItemModel> pagingController =
      PagingController(firstPageKey: 1);
  int pageIndex = 1;
  Rx<PromoteIncomeStatModel> promoteIncomeStat = PromoteIncomeStatModel().obs;

  @override
  void onInit() {
    super.onInit();
    getPromoteIncomeStat();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getPromoteIncomeStat() {
    Api.getPromoteIncomeStat().then((response) {
      if (response != null) {
        promoteIncomeStat.value = response;
      }
    });
  }

  getHttpData({required bool isRefresh}) {
    if (isRefresh) {
      pageIndex = 1;
      pagingController.refresh();
    }

    Api.getCommunityIncomeStat(
      page: pageIndex,
    ).then((response) {
      if (response.isNotEmpty) {
        pagingController.appendPage(response, pageIndex);
        pageIndex++;
      } else {
        pagingController.appendLastPage(response);
      }
    });
  }
}
