/*
 * @Author: momomo1123
 * @Date: 2025-04-17 15:09:31
 * @Description: 
 * @FilePath: /baby_app/lib/http/api/api_activity.dart
 */
part of 'api.dart';

extension SearchApi on _Api {
  /// 热门搜索
  Future<List<ClassifyHotModel>> getHotSearchKey() async {
    try {
      final resp = await httpInstance.get<ClassifyHotModel>(
        url: 'video/hot/list',
        complete: ClassifyHotModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  /// 滚动标题
  Future<List<SearchTitleModel>> getScrollTitleList() async {
    try {
      final resp = await httpInstance.get<SearchTitleModel>(
        url: 'search/getScrollTitleList',
        complete: SearchTitleModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  /// 热点
  Future<List<SearchHotSpotModel>> getHorSpot() async {
    try {
      final resp = await httpInstance.get<SearchHotSpotModel>(
        url: 'search/hotspot',
        complete: SearchHotSpotModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  /// 关键词搜索
  Future<SearchResultModel?> searchKey({
    required SearchType searchType,
    required String searchWord,
    required int page,
    required int pageSize,
    String classifyTitle = "",
    int sortMark = -1,
    int startPlayTime = -1,
    int endPlayTime = -1,
  }) async {
    Map<String, dynamic> map = {
      'searchWord': searchWord,
      'searchType': searchType.type,
      'pageSize': pageSize,
      'page': page
    };
    if (classifyTitle.isNotEmpty) {
      map["classifyTitle"] = classifyTitle;
    }
    if (sortMark != -1) {
      map["sortMark"] = sortMark;
    }

    if (startPlayTime != -1) {
      map["startPlayTime"] = startPlayTime;
    }

    if (endPlayTime != -1) {
      map["endPlayTime"] = endPlayTime;
    }

    try {
      final resp = await httpInstance.get<SearchResultModel>(
        url: 'search/keyWord',
        queryMap: map,
        complete: SearchResultModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }
}
