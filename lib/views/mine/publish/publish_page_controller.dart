import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/http/api/api.dart';

import '../../../model/community/community_model.dart';

class PublishPageController extends GetxController {
  EasyRefreshController refreshController = EasyRefreshController();
  PagingController<int, CommunityModel> pagingController =
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
    Api.getPersonDynamicList(
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
