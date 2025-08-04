import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/model/classify/classify_models.dart';
import 'package:baby_app/model/tags_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/enum.dart';

import '../../../http/api/api.dart';
import '../../../model/community/video_label_model.dart';
import '../../../model/video_base_model.dart';
import 'home_baby_state.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:baby_app/components/base_refresh/base_refresh_controller.dart';

class HomeBabyLogic extends BaseRefreshController
    with GetTickerProviderStateMixin {
  ClassifyModel? model;

  HomeBabyLogic({required this.model});

  final HomeBabyState state = HomeBabyState();

  RxList<VideoLabelModel> tags = <VideoLabelModel>[].obs;
  List<TagsModel> tagList = [];
  int selectIndex = -1;
  PagingController<int, VideoBaseModel> pageController =
      PagingController<int, VideoBaseModel>(firstPageKey: 1);
  RxBool isList = false.obs;

  void initTag(ClassifyModel? model) {
    this.model = model;
    _fetchTags();
  }

  ///1-热门推荐 2-最新上架 3-最多观看
  var _sorType = 1;

  @override
  void onInit() {
    super.onInit();
    pageController.addPageRequestListener((page) {
      loadData(page);
    });
  }

  void _fetchTags() async {
    tagList = await Api.fetchVideoTagsList(
          classifyId: model?.classifyId,
          isRecommend: true,
        ) ??
        [];
    update();
  }

  final _pageSize = 30;
  var nextPageKey = 1;

  Future<IndicatorResult> loadData(int pageKey) async {
    final result = await Api.fetchVideoByClassify(
      videoMark: 1,
      page: pageKey,
      pageSize: _pageSize,
      templateType: 2,
      classifyId: model?.classifyId ?? 0,
      sortType: _sorType,
    );
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
    return loadData(nextPageKey);
  }

  @override
  Future<IndicatorResult> onRefresh({bool isRefresh = false}) async {
    pageController.refresh();
    loadData(1);
    return IndicatorResult.success;
  }

  setListIndex(List<String> list, int index) {
    if (list == state.list1) {
      state.index1.value = index;
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
    loadData(1);
  }

  void switchBtn() {
    isList.value= !isList.value;
    update();
  }

  void setSelectIndext(int index) {
    this.selectIndex = index;
    Get.toNamed(Routes.homeDetailListPage, parameters: {
      "title": tagList[index].tagsTitle,
      "classifyId": "${tagList[index].tagsId}"
    });
  }
}
