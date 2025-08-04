part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiContent on _Api {
  // 关注/取消关注
  Future<bool?> attentionContentActress(int contentId,
      {required bool attention}) async {
    try {
      await httpInstance.post(
        url: '/content/attentionOrNot',
        body: {
          'contentId': contentId,
          'isAttention': attention,
        },
      );
      return true;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> toogleAttentionContentActress(int contentId,
      {required bool? attention}) {
    return attentionContentActress(
      contentId,
      attention: attention == true ? false : true,
    );
  }

  // 获取全部网黄
  Future<List<ContentHotModel>?> fetchContentActressMore({
    required int page,
    required int pageSize,
    required int orderType,
    String? firstSpell,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: '/content/getActressMore',
        queryMap: {
          'firstSpell': firstSpell,
          'orderType': orderType,
          'page': page,
          'pageSize': pageSize,
        },
        complete: ContentHotModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // // 获取热门女优
  // Future<List<ContentHotModel>?> fetchHotContentActressAv() async {
  //   try {
  //     final resp = await httpInstance.get(
  //       url: '/content/getHotActress',
  //       complete: ContentHotModel.fromJson,
  //     );
  //     return resp ?? [];
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // 女优(网黄详情)
  Future<ContentDetailModel?> fetchContentActressDetail(int contentId) async {
    try {
      final resp = await httpInstance.get(
        url: '/content/getActressDetails',
        queryMap: {'contentId': contentId},
        complete: ContentDetailModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  // 女优(网黄)-作品列表
  Future<List<VideoContentModel>?> fetchContentActressVideos({
    required int contentId,
    required int page,
    required int pageSize,
    required int orderType,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: '/content/getActressDetailsVideoList',
        queryMap: {
          'contentId': contentId,
          'orderType': orderType,
          'page': page,
          'pageSize': pageSize,
        },
        complete: VideoContentModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 今日更新女优列表
  Future<List<ContentBaseModel>?> fetchContentUpdatedToday(
      {required int page, required int pageSize}) async {
    try {
      final resp = await httpInstance.get(
        url: '/content/getUpdatedTodayList',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: ContentBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }
}
