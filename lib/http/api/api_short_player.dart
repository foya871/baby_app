/*
 * @Author: wangdazhuang
 * @Date: 2024-09-23 14:09:31
 * @LastEditTime: 2025-02-20 18:49:00
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/http/api/api_short_player.dart
 */
part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiShortPlayer on _Api {
  /// 上传观影记录
  Future uploadWatchRc(
      {required int duration,
      ////观看方式 1:免费次数 2：vip观看 3： 金币观看 4：试看
      required int lookType,
      required int videoId,

      ///进度(视频看到多少秒)
      required int progress}) async {
    try {
      await httpInstance.post(
        url: 'video/addStatisticsTimes',
        body: {
          'videoId': videoId,
          'duration': duration,
          "lookType": lookType,
          "progress": progress
        },
      );
    } catch (_) {}
  }

  /// 获取classify下的视频
  Future<List<VideoBaseModel>?> fetchShortVideoListByClassifyId(
      {required int page,
      required int pageSize,
      required String classifyId}) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/queryShortVideo',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'classifyId': classifyId
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<VideoBaseModel>?> fetchRcommendVideoList() async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/recommendVideo',
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///购买视频
  Future<bool?> buyVideoAction({required int videoId}) async {
    try {
      await httpInstance
          .post(url: 'tran/pur/video', body: {"videoId": videoId});
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 购买视频
  ///payType*	integer($int32)支付类型 1:金币 2:萝莉币
  Future<bool> purVideo({int payType = 1, required int videoId}) async {
    try {
      await httpInstance.post(
        url: "tran/pur/video",
        body: {
          "videoId": videoId,
          "payType": payType,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 获取猜你喜欢
  Future<List<VideoBaseModel>?> fetchGuessLikeVideoList({
    required int videoId,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/guessLike',
        queryMap: {"videoId": videoId},
        complete: VideoBaseModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  ///线路CDN列表
  Future<List<CdnRsp>> fetchCdnLines() async {
    try {
      final resp = await httpInstance.get<CdnRsp>(
        url: 'video/cdn/cdnList',
        complete: CdnRsp.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  ///点赞视频评论
  Future<bool> likeVideoComment(
      {required bool toLike, required int commentId}) async {
    try {
      await httpInstance.post(
        url: toLike ? 'video/comment/saveLike' : 'video/comment/unLike',
        body: {"commentId": commentId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///视频反馈
  Future<bool> feedVideo({required int videoId, required String title}) async {
    try {
      await httpInstance.post(
        url: "video/addVideoFeedBack",
        body: {
          "title": videoId,
          "videoId": videoId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 获取收藏或者购买的视频
  Future<List<VideoBaseModel>?> fetchBuyedOrLikeShortVideoList(
      {required int page,
      required int pageSize,
      required int userId,
      required bool isBuy}) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: isBuy ? 'video/userPurVideo' : 'video/userFavorites',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'userId': userId,
          "videoMark": 2
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///详情
  Future<VideoDetail?> fetchVideoDetailByVideoId({
    required int videoId,
    CancelToken? cancelToken,
    bool? isFree,
  }) async {
    try {
      final resp = await httpInstance.get<VideoDetail>(
        url: "video/getVideoById",
        complete: VideoDetail.fromJson,
        queryMap: {
          "videoId": videoId,
          "isFree": isFree,
        },
        token: cancelToken,
      );
      return resp;
    } catch (_) {
      return null;
    }
  }

  ///收藏合集
  Future<bool> favoriteUserCollect(
      {required bool isCollect, required int collectionId}) async {
    try {
      await httpInstance.post(
        url: isCollect
            ? 'bloggerCollection/cancelFavorite'
            : 'bloggerCollection/favorite',
        body: {"collectionId": collectionId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///视频点赞
  Future<bool> toggleVideoLike(int videoId, {required bool? like}) async {
    try {
      await httpInstance.post(
        url: like == true ? 'video/cancelVideoLike' : 'video/likeVideo',
        body: {"videoId": videoId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///视频收藏
  Future<bool> toggleVideoFav(int videoId, {required bool? fav}) async {
    try {
      await httpInstance.post(
        url:
            fav == true ? 'video/cancelVideoFavorite' : 'video/favoriteVideo',
        body: {"videoId": videoId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
