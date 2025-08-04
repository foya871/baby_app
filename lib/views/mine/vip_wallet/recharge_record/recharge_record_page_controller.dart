import 'package:baby_app/http/api/api.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../model/mine/record_model.dart';

class RechargeRecordPageController extends GetxController {
  var type = 2.obs; // 2:购买记录, 3:金币记录
  EasyRefreshController refreshController = EasyRefreshController();

  final PagingController<int, RecordModel> pagingController =
      PagingController(firstPageKey: 1);

  int pageIndex = 1;

  @override
  void onInit() {
    type.value = Get.arguments ?? 0;
    super.onInit();
  }

  getHttpData({required bool isRefresh}) {
    if (isRefresh) {
      pageIndex = 1;
      pagingController.refresh();
    }

    Api.geRechargeRecordList(tranType: type.value, page: pageIndex)
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
