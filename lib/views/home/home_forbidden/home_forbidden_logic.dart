import 'package:collection/collection.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:baby_app/model/classify/classify_models.dart';
import 'package:baby_app/views/home/home_forbidden/home_forbidden_state.dart';
import '../../../http/api/api.dart';
import '../../../model/community/video_label_model.dart';
import '../../../model/tags_model.dart';
import '../../../model/video_base_model.dart';
import '../../../routes/routes.dart';
import 'package:baby_app/components/base_refresh/base_refresh_controller.dart';


//
class HomeForbiddenLogic extends BaseRefreshController
    with GetTickerProviderStateMixin {
  final HomeForbiddenState state = HomeForbiddenState();
  final ClassifyModel model;
  HomeForbiddenLogic({required this.model});

  bool isList = false;
  int selectIndex = -1;
  late var tabController =
      TabController(length: state.tabs.length, vsync: this);
  PagingController<int, VideoBaseModel> pageController =
      PagingController<int, VideoBaseModel>(firstPageKey: 1);
  Map<String, dynamic> bodyParmas = {};
  RxList<VideoLabelModel> tags = <VideoLabelModel>[].obs;
  List<TagsModel> tagList = [];
  List<AdInfoModel> advertisementList = [];

  ///1-热门推荐 2-最新上架 3-最多观看
  var _sorType = 1;

  @override
  void onInit() {
    super.onInit();
    _fetchTags(model);
    pageController.addPageRequestListener((page) {
      pageController.refresh();
      _loadData(page);
    });
  }

  final _pageSize = 30;
  var nextPageKey = 1;

  void setSelectIndext(int index) {
    this.selectIndex = index;
    Get.toNamed(Routes.homeDetailListPage, parameters: {
      "title": tagList[index].tagsTitle,
      "classifyId": "${tagList[index].tagsId}"
    });
  }

  Future<IndicatorResult> _loadData(int pageKey,
      {bool isRefresh = false}) async {
    bodyParmas = getBodyMap();
    final result = await Api.fetchVideoByClassify(
        page: pageKey,
        classifyId: model?.classifyId,
        pageSize: _pageSize,
        videoMark: 3,
        sortType: _sorType);
    if (result != null) {
      final isLastPage = result.length < _pageSize;
      List<VideoBaseModel> arr = result;
      nextPageKey = pageKey + 1;

      // final gap = initRuleIntervalNum(AdApiType.HOME_LIST_INSERT);
      // if (gap > 0) {
      //   arr.forEachIndexed((index, e) {
      //     if (index != 0 && (index + 1) % gap == 0) {
      //       ///插入广告
      //       arr.insert(index + 1, VideoBaseModel.ad());
      //     }
      //   });
      // }

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
  Future<IndicatorResult> onLoad() {
    return _loadData(nextPageKey);
  }

  @override
  Future<IndicatorResult> onRefresh({bool isRefresh = false}) async {
    pageController.refresh();
    _loadData(1);
    return IndicatorResult.success;
  }

  void _fetchTags(ClassifyModel? model) async {
    tagList = (await Api.fetchVideoTagsList(
            classifyId: model?.classifyId, page: null, pageSize: null,isRecommend: false)) ??
        [];
  }

  setListIndex(List<String> list, int index) {
    update();
    if (list == state.list1) {
      state.index1 = index;
      state.index2 = 0;
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
}
