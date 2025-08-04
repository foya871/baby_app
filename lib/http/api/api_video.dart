part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiVideo on _Api {
  // 获取标签
  Future<List<TagsModel>?> fetchVideoHotTagsByClassify(int classifyId) =>
      fetchVideoTagsByClassify(classifyId: classifyId, mark: 2);

  Future<List<TagsModel>?> fetchVideoTagsByClassify(
      {required int classifyId, int? mark}) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/tags/getTags',
        queryMap: {'classifyId': classifyId, 'mark': mark},
        complete: TagsModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 榜单视频
  Future<List<VideoBaseModel>?> fetchVideoRankByClassify({
    required int classifyId,
    required int page,
    required int pageSize,
    required int type,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/getRankVideos',
        queryMap: {
          'classifyId': classifyId,
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

  // 查询网黄
  Future<PornographyListResp?> fetchPornography({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'content/getPornographyList',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: PornographyListResp.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  // 短视频-关注
  Future<List<VideoBaseModel>?> fetchShortVideoFocusList({
    required int page,
    required int pageSize,
  }) =>
      _fetchShortVideo(
        page: page,
        pageSize: pageSize,
        recommend: false,
      );

  // 短视频-推荐
  Future<List<VideoBaseModel>?> fetchShortVideoRecommend({
    required int page,
    required int pageSize,
    bool? refresh,
  }) =>
      _fetchShortVideo(
          page: page, pageSize: pageSize, recommend: true, refresh: refresh);

  // 短视频
  Future<List<VideoBaseModel>?> _fetchShortVideo({
    required int page,
    required int pageSize,
    bool? recommend,
    bool? refresh,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/queryBrushVideos',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          //排序：1-关注 2-推荐
          'sortType': recommend == true ? 2 : 1,
          "refresh": refresh,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> fetchSearchKeyWord({
    required int page,
    required int pageSize,
    int? searchType,
    String? searchWord,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'search/keyWord',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'searchType': searchType,
          'searchWord': searchWord,
        },
      );
      return resp ?? {};
    } catch (e) {
      return {};
    }
  }

  Future<List<VideoBaseModel>?> fetchVideoHouse({
    required int page,
    required int pageSize,
    int? sortMark,
    int? videoType,
    String? tagsTitle,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/queryVideoHouse',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'sortMark': sortMark,
          'videoType': videoType,
          'tagsTitle': tagsTitle,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///查询分类视频
  Future<List<VideoBaseModel>?> fetchVideoRecommendVideo({
    String? classifyTitle,
    int? sortType,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/recommendVideo',
        queryMap: {
          'sortType': sortType,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///查询分类视频
  // Future<List<VideoBaseModel>?> fetchVideoByClassify({
  //   required int page,
  //   required int pageSize,
  //   int? templateType,
  //   String? classifyTitle,
  //
  //   ///1-最新 2-本周最热 3-最多观看 4-推荐
  //   int? sortType,
  //   int? classifyId,
  // }) async {
  //   try {
  //     final resp = await httpInstance.get<VideoBaseModel>(
  //       url: 'video/queryVideoByClassify',
  //       queryMap: {
  //         'page': page,
  //         'pageSize': pageSize,
  //         'classifyTitle': classifyTitle,
  //         'sortType': sortType,
  //         'templateType': templateType,
  //         'classifyId': classifyId
  //       },
  //       complete: VideoBaseModel.fromJson,
  //     );
  //     return resp ?? [];
  //   } catch (e) {
  //     return null;
  //   }
  // }
  Future<List<VideoBaseModel>?> fetchVideoByClassify({
    required int page,
    required int pageSize,
    int? templateType,
    String? classifyTitle,
    String? tagsTitle,
    required videoMark,

    ///1-最新 2-本周最热 3-最多观看 4-推荐
    ///：1-最新更新 2-本周最热 3-最多观看 4-十分钟以上
    int? sortType,
    int? classifyId,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/queryVideos',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'classifyTitle': classifyTitle,
          'sortType': sortType,
          'templateType': templateType,
          'classifyId': classifyId,
          'tagsTitle': tagsTitle,
          'videoMark': videoMark
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///筛选条件查询视频
  Future<List<VideoBaseModel>?> fetchVideoByCondition({
    required int page,
    required int pageSize,
    required int classifyId,
    int? sortType,
    List<int>? tagsId,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/getByClassify',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'classifyId': classifyId,
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

  Future<AttentionUserVideosResp?> fetchAttentionUserVideo({
    required int page,
    required int pageSize,
    VideoSortType? sortType,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/attentionUserVideo',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'sortType': sortType,
        },
        complete: AttentionUserVideosResp.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  // // 标签列表
  // Future<List<TagsModel>?> fetchVideoTagsList(
  //     {int? classifyId, bool? underage, int? page, int? pageSize}) async {
  //   try {
  //     final resp = await httpInstance.get(
  //       url: 'video/tags/list',
  //       queryMap: {
  //         'classifyId': classifyId,
  //         'underage': underage,
  //         'page': page,
  //         'pageSize': pageSize,
  //       },
  //       complete: TagsModel.fromJson,
  //     );
  //     return resp ?? [];
  //   } catch (e) {
  //     return null;
  //   }
  // }
  // 标签列表
  Future<List<TagsModel>?> fetchVideoTagsList(
      {int? classifyId,
      bool isRecommend = false,
      int? page,
      int? pageSize}) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/tagsList',
        queryMap: {
          'classifyId': isRecommend ? null : classifyId,
          'isRecommend': isRecommend,
          'page': page,
          'pageSize': pageSize,
        },
        complete: TagsModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 标签列表
  Future<List<TagsModel>?> fetchTagsList({int? parentId}) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/tagsList',
        queryMap: {
          'parentId': parentId,
        },
        complete: TagsModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 我的分类列表
  Future<List<ClassifyModel>?> fetchMyClassifyList() async {
    try {
      final resp = await httpInstance.get(
        url: 'video/userClassifyList',
      );

      if (resp != null &&
          resp is Map &&
          resp["data"] != null &&
          resp["data"] is List) {
        List<String> arr = List<String>.from(resp["data"]);
        final items = arr
            .map((e) => ClassifyModel.fromJson({"classifyTitle": e}))
            .toList();
        return items;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  ///所有分类
  Future<List<ClassifyModel>?> fetchAllClassifyList({
    //@ApiModelProperty("分类类型：1-普通 2-固定")
    // private Integer classifyType = 1;
    required int classifyType,

    //分类类型：1-首页 3-暗网
    required int mark,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/classifyList',
        queryMap: {
          // "classifyType": classifyType,
          "mark": mark,
        },
      );
      if (resp != null &&
          resp is Map &&
          resp["data"] != null &&
          resp["data"] is List) {
        List<ClassifyModel> items = (resp["data"] as List<dynamic>)
            .map((item) => ClassifyModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return items;
      }
      return null;
    } catch (e) {
      logger.d("》》》》》$e");
      return null;
    }
  }

  Future<List<CheckinGiftList>?> getDailyCircles() async {
    try {
      final resp = await httpInstance.get(
        url: 'dailyFitUser/circles',
        queryMap: {},
        complete: CheckinGiftList.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<DailyFitUserCircles?> getBaseUserReward() async {
    try {
      final resp = await httpInstance.post(
        url: 'dailyFitUser/base/UserReward',
        complete: DailyFitUserCircles.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  ///保存分类
  Future<bool> saveCustomClassify(List<ClassifyModel> list) async {
    try {
      final resp = await httpInstance.post(
        url: 'video/add/customizeClassify',
        body: {
          "classifyTitles": list.map((e) => e.classifyTitle).toList(),
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // 推荐视频列表-刷片
  Future<List<int>?> getRecommendVideo({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/getRecommendVideo',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
      );
      if (resp case {'data': List data} when data.every((e) => e is int)) {
        return List<int>.from(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<CommentModel>?> getVideoComment({
    required int videoId,
    required int page,
    required int pageSize,
    int? parentId,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/commentList',
        queryMap: {
          'videoId': videoId,
          'parentId': parentId,
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommentModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveVideoComment({
    required String content,
    required int videoId,
    int? parentId,
    int? childId,
  }) async {
    try {
      await httpInstance.post(
        url: 'video/saveComment',
        body: {
          'videoId': videoId,
          'content': content,
          'topId': parentId,
          'parentId': childId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
