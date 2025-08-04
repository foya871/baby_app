import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../http/api/api.dart';
import '../../../../model/mine/proxy_record_model.dart';
import '../../../../model/mine/share_record_model.dart';
import '../../../../services/user_service.dart';

class ShareDataListController extends GetxController {
  final userService = Get.find<UserService>();

  EasyRefreshController refreshController = EasyRefreshController();
  PagingController<int, ProxyRecordModel> pagingController =
      PagingController(firstPageKey: 1);
  int pageIndex = 1;

  getHttpData({required bool isRefresh}) {
    if (isRefresh) {
      pageIndex = 1;
      pagingController.refresh();
    }
    Api.getProxyRecordList(page: pageIndex).then((response) {
      if (response.isNotEmpty) {
        pagingController.appendPage(response, pageIndex);
        pageIndex++;
      } else {
        pagingController.appendLastPage(response);
      }
    });
  }
}
