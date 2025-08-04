import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/http/api/api.dart';

import '../../../../model/mine/buy_dynamic.dart';

class IncomeDetailsPageController extends GetxController {
  final dynamicId = Get.arguments;
  EasyRefreshController refreshController = EasyRefreshController();
  PagingController<int, BuyDynamic> pagingController =
      PagingController(firstPageKey: 1);
  int pageIndex = 1;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getHttpData({required bool isRefresh}) {
    if (isRefresh) {
      pageIndex = 1;
      pagingController.refresh();
    }
    Api.getBuyDynamicDetails(dynamicId: dynamicId, page: pageIndex)
        .then((response) {
      if (response.isNotEmpty) {
        pagingController.appendPage(response, pageIndex);
        pageIndex++;
      } else {
        pagingController.appendLastPage(response);
      }
    });
  }
}
