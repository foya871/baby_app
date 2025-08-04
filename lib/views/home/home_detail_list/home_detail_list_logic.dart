import 'package:collection/collection.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/components/no_more/no_more.dart';
import 'package:baby_app/model/classify/classify_models.dart';
import '../../../http/api/api.dart';
import '../../../model/video_base_model.dart';
import '../../../utils/enum.dart';
import 'home_detail_list_state.dart';
import 'package:baby_app/components/base_refresh/base_refresh_controller.dart';

// 标签
class HomeDetailListLogic extends BaseRefreshController
    with GetTickerProviderStateMixin {
  final HomeDetailListState state = HomeDetailListState();
  bool isList = false;
  PagingController<int, VideoBaseModel> pageController =
      PagingController<int, VideoBaseModel>(firstPageKey: 1);
  Map<String, dynamic> bodyParmas = {};
  final List<String> tabs = ['最新', '最热'];
  RxInt selectedIndex = 0.obs;

  var _noMore = false;

  @override
  void onInit() {
    super.onInit();
    pageController.addPageRequestListener((page) {
      _loadData(pageKey: 1, tagTitle: title.value, pageSize: _pageSize);
    });
  }

  final _pageSize = 30;
  var nextPageKey = 1;
  bool request = false;

  ///1-最新 2-本周最热 3-最多观看 4-推荐
  var _sorType = 1;

  Future<IndicatorResult> _loadData({
    required String tagTitle,
    required int pageKey,
    required int pageSize,
  }) async {
    final result = await Api.fetchVideoByClassify(
      videoMark: 1,
      page: pageKey,
      tagsTitle: tagTitle,
      pageSize: _pageSize,
      sortType: _sorType,
      // classifyId: classifyId,
    );
    if (result != null) {
      final isLastPage = result.length < _pageSize;
      List<VideoBaseModel> arr = result;
      nextPageKey = pageKey + 1;
      if (isLastPage) {
        pageController.appendLastPage(arr);
        update();
        return IndicatorResult.noMore;
      } else {
        pageController.appendPage(arr, nextPageKey as int?);
        update();
        return IndicatorResult.success;
      }
    } else {
      pageController.appendLastPage([]);
      update();
      return IndicatorResult.noMore;
    }
  }

  @override
  Future<IndicatorResult> onRefresh({bool isRefresh = false}) async {
    pageController.refresh();
    _loadData(pageKey: 1, tagTitle: title.value, pageSize: _pageSize);

    return IndicatorResult.success;
  }

  @override
  Future<IndicatorResult> onLoad() {
    return _loadData(
      pageKey: nextPageKey,
      tagTitle: title.value,
      pageSize: _pageSize,
    );
  }

  setListIndex(List<String> list, int index) {
    pageController.refresh();
    request = true;
    update();
    if (list == state.list1) {
      state.index1 = index;
      state.index2 = 0;
    } else if (list == state.list2) {
      state.index2 = index;
    }
    if (index == 0) {
      _sorType = 2;
    } else if (index == 1) {
      _sorType = 3;
    } else {
      _sorType = 1;
    }
    _loadData(pageKey: 1, tagTitle: title.value, pageSize: _pageSize);
    update(["buildSelectBtn"]);
  }

  setIndexType(int index) {
    if (index == 0) {
      _sorType = 1;
    } else {
      _sorType = 5;
    }
    pageController.refresh();
    _loadData(pageKey: 1, tagTitle: title.value, pageSize: _pageSize);
  }

  Map<String, dynamic> getBodyMap() {
    Map<String, dynamic> bodyParmas = {};
    bodyParmas["sortType"] = state.index1 + 1;
    // 未成年
    bodyParmas["templateType"] = 1;
    return bodyParmas;
  }

  void switchBtn() {
    isList = !isList;
    update();
  }

  int? classifyId;
  RxString title = "".obs;

  void initTag() {
    classifyId = int.tryParse(Get.parameters['classifyId'] ?? '') ?? 0;
    title.value = Get.parameters['title'] ?? "";
    update();
    pageController.refresh();
  }
}
