import 'dart:async';

import 'package:baby_app/components/ad/ad_enum.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:baby_app/components/ad/ad_utils.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../components/base_refresh/base_refresh_controller.dart';
import '../../http/api/api.dart';
import '../../model/classify/classify_hot_model.dart';
import '../../model/search/search_hot_spot_model.dart';
import '../../model/video_base_model.dart' show VideoBaseModel;
import '../../services/storage_service.dart';
import '../../utils/enum.dart';

class SearchPageController extends BaseRefreshController {
  final service = Get.find<StorageService>();

  TextEditingController searchTextController = TextEditingController();
  RxList<String> history = <String>[].obs;
  var keyWord = ''.obs;
  var showTextField = false.obs;
  RxList<ClassifyHotModel> tags = <ClassifyHotModel>[].obs;
  RxList<SearchHotSpotModel> hotSpots = <SearchHotSpotModel>[].obs;
  int classifyId = 1;
  FocusNode inputFocus = FocusNode();
  StreamSubscription? keyboardVisibilityStream;
  List<VideoBaseModel> list1 = [];
  bool request = false;
  // List<String> listTag1 = ["本周最热", "本月最热", "上月最热"];
  List<String> listTag1 = ["最近热播", "本月最热", "上月最热"];
  int index1 = 0;
  var ads = <AdInfoModel>[];

  @override
  void onInit() {
    classifyId = Get.arguments['classifyId'];
    ads.addAll(AdUtils().getAdLoadInOrder(AdApiType.INSERT_ICON));
    keyboardVisibilityStream =
        KeyboardVisibilityController().onChange.listen((isShow) {
      if (searchTextController.text.isNotEmpty) {
        showTextField.value = true;
      } else {
        showTextField.value = isShow;
      }
    });
    _loadData();

    super.onInit();
  }

  void deleteHistoryKey(String key) async {
    debugPrint("deleteHistoryKey key = $key");
    await service.deleteHistoryKey(key);
    history.value = service.history;
    history.refresh();
  }

  @override
  onReady() {
    super.onReady();
    history.value = service.history;
    requestHotkey();
    // requestHotSpot();
  }

  @override
  void onClose() {
    keyboardVisibilityStream?.cancel();
    super.onClose();
  }

  String getSearchKey() {
    return searchTextController.text;
  }

  startToSearch(String key, int videoMark) {
    if (key.isEmpty) {
      return;
    }
    keyWord.value = key;
    addHistory(key);
    history.value = service.history;
    searchTextController.text = key;
    showTextField.value = true;
    Get.toNamed(
      Routes.searchResult,
      arguments: {
        'keyWord': key,
        'videoType': videoMark,
      },
    );
  }

  void addHistory(String v) async {
    if (!history.contains(v)) {
      history.insert(0, v);
      await service.setHistory(v);
    }
    history.value = service.history;
    history.refresh();
  }

  void clearHistory() {
    history.value = [];
    history.refresh();
    service.deleteHistory();
  }

  requestHotkey() async {
    var searchKey = await Api.getHotSearchKey();
    tags.addAll(searchKey);
    tags.refresh();
  }

  // requestHotSpot() async {
  //   var hotSpot = await Api.getHorSpot();
  //   hotSpots.addAll(hotSpot);
  //   hotSpots.refresh();
  // }

  toVideo(int videoId) {
    Get.toPlayVideo(videoId: videoId);
  }

  void _loadData({int sortType = 1}) async {
    if (request) return;
    request = true;
    list1.clear();
    final result = await Api.fetchVideoRecommendVideo(sortType: sortType);
    request = false;
    list1.addAll(result ?? []);
    update();
  }

  @override
  Future<IndicatorResult> onRefresh({bool isRefresh = false}) async {
    return IndicatorResult.success;
  }

  void setListIndex(List<String> list, int indexOf) {
    this.index1 = indexOf;
    _loadData(sortType: indexOf + 1);
    update();
  }
}
