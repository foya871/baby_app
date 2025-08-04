/*
 * @Author: wangdazhuang
 * @Date: 2024-09-23 14:09:31
 * @LastEditTime: 2025-02-18 15:15:02
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/http/api/api_classify.dart
 */
part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiClassify on _Api {
  /// classify的列表
  Future<List<ClassifyModel>?> fetchShiPinClasifyList() => _fetchClassifyList();
  Future<List<ClassifyModel>?> _fetchClassifyList() async {
    try {
      final resp = await httpInstance.get<ClassifyModel>(
        url: 'video/classifyList',
        complete: ClassifyModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  /// 获取classify下的频道
  Future<List<StationModel>?> fetchStationsByClassifyId({
    required int classifyId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<StationModel>(
        url: 'video/list',
        queryMap: {
          'classifyId': classifyId,
          'page': page,
          'pageSize': pageSize,
        },
        complete: StationModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  /// 查询视频分类
  Future<List<VideoBaseModel>?> fetchVideosByClassify({
    int? classifyId,
    required int page,
    required int pageSize,
    VideoSortType? sortType,
    List<int>? tagsId,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/getByClassify',
        queryMap: {
          'classifyId': classifyId,
          'page': page,
          'pageSize': pageSize,
          'sortType': sortType,
          'tagsId': tagsId,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  /// 查询标签视频列表
  Future<List<VideoBaseModel>?> fetchVideosByTag({
    required String tagTitle,
    required int type,
    required int sortType,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/getVideoByTag',
        queryMap: {
          'tagsTitle': tagTitle,
          'type': type,
          'sortType': sortType,
          'page': page,
          'pageSize': pageSize,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  //  查询频道排行视频(更多)
  Future<List<VideoBaseModel>?> fetchVideosByRanking({
    required int page,
    required int pageSize,
    required int type,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/getVideoByRanking',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'type': type,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }
}
