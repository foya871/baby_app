import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../http/api/api.dart';
import '../../../model/mine/official_community_model.dart';

class GroupPageController extends GetxController {
  EasyRefreshController refreshController = EasyRefreshController();
  PagingController<int, OfficialCommunityModel> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getOfficialGroup();
    super.onReady();
  }

  getOfficialGroup() {
    Api.getOfficialGroup().then((response) {
      if (response.isNotEmpty) {
        pagingController.refresh();
        pagingController.appendLastPage(response);
      }
    });
  }
}
