import 'dart:math';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http_service/http_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:json2dart_safe/json2dart.dart';

import '../../../components/diolog/loading/loading_view.dart';
import '../../../model/search/search_result_model.dart';
import '../../../model/video_base_model.dart';
import '../../../services/storage_service.dart';
import '../../../utils/enum.dart';

class SearchResultPageController extends GetxController
    with GetTickerProviderStateMixin {
  final service = Get.find<StorageService>();
  List<String> tabs = RxList<String>.empty(growable: true);
  RxList<String> history = <String>[].obs;
  String keyWord = "";
  late SearchType searchType;

  SearchResultPageController(this.searchType);

  @override
  void onInit() {
    keyWord = Get.arguments['keyWord'];

    super.onInit();
  }

  @override
  onReady() {
    super.onReady();
    startToSearch(keyWord);
  }

  startToSearch(String key) {
    if (key.isEmpty) {
      return;
    }
    getSearchResult();
  }

  Future<void> getSearchResult({
    bool isRefresh = true,
  }) async {
    Map<String, dynamic> map = {
      'searchWord': keyWord,
      'searchType': searchType.type,
      'pageSize': 20
    };

    final result = await LoadingView.singleton.wrap(
      context: Get.context!,
      asyncFunction: () => httpInstance.get(
        url: 'search/keyWord',
        queryMap: map,
        complete: SearchResultModel.fromJson,
      ),
    );

    List<VideoBaseModel> videoList = result?.videoList ?? [];
  }
}
