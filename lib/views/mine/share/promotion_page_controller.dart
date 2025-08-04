import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/mine/share_record_model.dart';
import 'package:baby_app/services/user_service.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PromotionPageController extends GetxController {
  final userService = Get.find<UserService>();

  EasyRefreshController refreshController = EasyRefreshController();
  PagingController<int, ShareRecordModel> pagingController =
      PagingController(firstPageKey: 1);
  int pageIndex = 1;

  getHttpData({required bool isRefresh}) {
    if (isRefresh) {
      pageIndex = 1;
      pagingController.refresh();
    }
    Api.getShareRecordList(page: pageIndex).then((response) {
      if (response.isNotEmpty) {
        pagingController.appendPage(response, pageIndex);
        pageIndex++;
      } else {
        pagingController.appendLastPage(response);
      }
    });
  }
}
