import 'package:collection/collection.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:baby_app/model/classify/classify_models.dart';
import '../../../http/api/api.dart';
import '../../../model/community/video_label_model.dart';
import '../../../model/tags_model.dart';
import '../../../model/video_base_model.dart';
import '../../../routes/routes.dart';
import 'package:baby_app/components/base_refresh/base_refresh_controller.dart';

import '../../../utils/enum.dart';
import 'home_common_state.dart';

class HomeCommonLogic extends BaseRefreshController
    with GetTickerProviderStateMixin {
  final HomeCommonState state = HomeCommonState();
  final refreshController = EasyRefreshController();
  bool isList = false;
  int selectIndex = -1;
  PagingController<int, VideoBaseModel> pageController =
      PagingController<int, VideoBaseModel>(firstPageKey: 1);
  Map<String, dynamic> bodyParmas = {};
  RxList<VideoLabelModel> tags = <VideoLabelModel>[].obs;
  List<TagsModel> tagList = [];
  List<AdInfoModel> advertisementList = [];
  final ClassifyModel model;

  HomeCommonLogic({required this.model});

  ///1-热门推荐 2-最新上架 3-最多观看
  var _sorType = 1;

  @override
  void onInit() {
    super.onInit();
    pageController.addPageRequestListener((page) {
      _loadData(page);
    });
    _fetchTags();
  }

  final _pageSize = 30;
  var nextPageKey = 1;
  bool request = true;

  void setSelectIndext(int index) {
    this.selectIndex = index;
    Get.toNamed(Routes.homeDetailListPage, parameters: {
      "title": tagList[index].tagsTitle,
      "classifyId": "${tagList[index].tagsId}"
    });
    _fetchTags();
  }

  Future<IndicatorResult> _loadData(int pageKey) async {
    request = true;
    final result = await Api.fetchVideoByClassify(
      page: nextPageKey,
      pageSize: _pageSize,
      classifyId: model?.classifyId ?? 0,
      sortType: _sorType,
      videoMark: 1
    );
    if (result != null) {
      final isLastPage = result.length < _pageSize;
      nextPageKey = pageKey + 1;
      if (isLastPage) {
        pageController.appendLastPage(result);
        update();
        return IndicatorResult.noMore;
      } else {
        pageController.appendPage(result, nextPageKey as int?);
        update();
        return IndicatorResult.success;
      }
    } else {
      pageController.appendLastPage([]);
      update();
      return IndicatorResult.noMore;
    }
  }

  void _fetchTags() async {
    if (model == null) return;
    tagList = (await Api.fetchVideoTagsList(
            classifyId: model.classifyId, page: null, pageSize: null)) ??
        [];
    update();
  }

//排序：1-最新更新 2-本周最热 3-最多观看 4-十分钟以上
  setListIndex(List<String> list, int index) {
    request = true;
    update();
    if (list == state.list1) {
      state.index1 = index;
      state.index2 = 0;
    } else if (list == state.list2) {
      state.index2 = index;
    }
    pageController.refresh();
    if (index == 0) {
      _sorType = 1;
    } else if (index == 1) {
      _sorType = 2;
    } else if (index == 2) {
      _sorType = 3;
    } else if (index == 3) {
      _sorType = 4;
    } else {
      _sorType = 1;
    }
    _loadData(1);
    update(["buildSelectBtn"]);
  }

  @override
  Future<IndicatorResult> onLoad() {
    return _loadData(nextPageKey);
  }

  @override
  Future<IndicatorResult> onRefresh({bool isRefresh = false}) async {
    pageController.refresh();
    _loadData(1);
    return IndicatorResult.success;
  }

  void switchBtn() {
    isList = !isList;
    update();
  }
}
