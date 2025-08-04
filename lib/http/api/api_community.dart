part of 'api.dart';

extension ApiCommunity on _Api {
  ///获取社区列表
  ///[type] 1-精选 2-最新 3-最热
  Future<List<CommunityModel>> getCommunityDynamicLists({
    required String id,
    required int page,
    int pageSize = 20,
    int type = 1,
  }) async {
    Map<String, dynamic> request = {
      'page': page,
      'pageSize': pageSize,
      'type': type
    };
    if (id.isNotEmpty) {
      if (id != '00000') {
        request['id'] = id;
      }
    }
    try {
      final response = await httpInstance.get(
        url: 'community/dynamic/list',
        queryMap: request,
        complete: CommunityModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///获取动态详情
  Future<CommunityModel?> getCommunityDynamicDetails({
    required int dynamicId,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'community/dynamic/dynamicInfo',
        queryMap: {'dynamicId': dynamicId},
        complete: CommunityModel.fromJson,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  ///点赞或者取消点赞
  likeOrCancelLike({required bool isLike, required int dynamicId}) async {
    try {
      await httpInstance.post(
        url: isLike ? 'community/dynamic/like' : 'community/dynamic/unLike',
        body: {'dynamicId': dynamicId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///评论列表
  Future<List<CommentModel>> getCommunityCommentList({
    required int dynamicId,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'community/dynamic/commentList',
        queryMap: {
          'dynamicId': dynamicId,
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommentModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///发送评论
  Future<bool> sendCommunityComment({
    required int dynamicId,
    required String content,
    required int topId,
    int? parentId,
  }) async {
    try {
      final response = await httpInstance.post(
          url: 'community/dynamic/saveComment',
          body: {
            'dynamicId': dynamicId,
            "content": content,
            "topId": topId,
            if (parentId != null) 'parentId': parentId,
          },
          complete: CommentModel.fromJson);
      return true;
    } catch (e) {
      return false;
    }
  }

  // 评论点赞
  Future<bool> dynamicCommentLike(int commentId) async {
    try {
      await httpInstance.post(url: 'community/dynamic/comment/saveLike', body: {
        'commentId': commentId,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // 取消评论点赞
  Future<bool> dynamicCommentUnLike(int commentId) async {
    try {
      await httpInstance.post(
        url: 'community/dynamic/comment/unLike',
        body: {'commentId': commentId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // toogle 点赞
  Future<bool> toogleDynamicCommentLike(int commentId, {required bool? like}) {
    if (like == true) {
      return dynamicCommentUnLike(commentId);
    } else {
      return dynamicCommentLike(commentId);
    }
  }

  ///获取圈子列表
  Future<dynamic> getPublishTags() async {
    try {
      final response = await httpInstance.get(
        url: '/coterie/list',
        queryMap: {'isAll': true},
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  ///发布帖子
  Future<bool> publishRelease(Map<String, dynamic>? body) async {
    try {
      await httpInstance.post(
        url: '/community/dynamic/release',
        body: body,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////
  Future<List<CommunityClassifyModel>?> getCommunityClassify() async {
    try {
      final response = await httpInstance.get(
        url: 'community/dynamicClassify/allNames',
        complete: CommunityClassifyModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<List<CommunityTopicModel>?> getHotTopic() async {
    try {
      final resp = await httpInstance.get<CommunityTopicModel>(
        url: 'topic/list',
        queryMap: {
          'hot': true,
        },
        complete: CommunityTopicModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityModel>?> getDynamicList({
    required String classify,
    required int loadType,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: 'community/dynamic/list',
        queryMap: {
          'classify': classify,
          'loadType': loadType,
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommunityModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityModel>?> getTopicDynamicList({
    required String topicId,
    required int loadType,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: 'community/dynamic/list',
        queryMap: {
          'topicId': topicId,
          'loadType': loadType,
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommunityModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityModel>?> getUserDynamicList({
    required int userId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: 'community/dynamic/person/list',
        queryMap: {
          'userId': userId,
          'status': 2,
          'userListBold': true,
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommunityModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<bool> communityPraise({
    required int dynamicId,
    required bool isLike,
  }) async {
    try {
      String apiUrl = '';
      if (isLike == true) {
        apiUrl = 'community/dynamic/unLike';
      } else {
        apiUrl = 'community/dynamic/like';
      }
      final _ = await httpInstance.post(
        url: apiUrl,
        body: {
          'dynamicId': dynamicId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> bloggerAttention({
    required int toUserId,
    required bool isAttention,
  }) async {
    try {
      String apiUrl = '';
      if (isAttention == true) {
        apiUrl = 'user/attention/cancel';
      } else {
        apiUrl = 'user/attention';
      }
      final _ = await httpInstance.post(
        url: apiUrl,
        body: {
          'toUserId': toUserId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> communityAttention({
    required int toUserId,
    required bool isAttention,
  }) async {
    try {
      String apiUrl = '';
      if (isAttention == true) {
        apiUrl = 'user/attention/cancel';
      } else {
        apiUrl = 'user/attention';
      }
      final _ = await httpInstance.post(
        url: apiUrl,
        body: {
          'toUserId': toUserId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> communityFavorite({
    required int dynamicId,
    required bool isFavorite,
  }) async {
    try {
      String apiUrl = '';
      if (isFavorite == true) {
        apiUrl = 'community/dynamic/unFavorite';
      } else {
        apiUrl = 'community/dynamic/favorite';
      }
      final _ = await httpInstance.post(
        url: apiUrl,
        body: {
          'dynamicId': dynamicId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> commentPraise({
    required int commentId,
    required bool isLike,
  }) async {
    try {
      String apiUrl = '';
      if (isLike == true) {
        apiUrl = 'community/dynamic/comment/unLike';
      } else {
        apiUrl = 'community/dynamic/comment/saveLike';
      }
      final _ = await httpInstance.post(
        url: apiUrl,
        body: {
          'commentId': commentId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> subscribe({
    required String id,
    required bool isSubscribe,
  }) async {
    try {
      String apiUrl = '';
      if (isSubscribe == true) {
        apiUrl = 'topic/cancel/subscribe';
      } else {
        apiUrl = 'topic/subscribe';
      }
      final _ = await httpInstance.post(
        url: apiUrl,
        body: {
          'id': id,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<CommunityModel?> getDynamicInfo({
    required int dynamicId,
    CancelToken? cancelToken,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: 'community/dynamic/dynamicInfo',
        queryMap: {
          'dynamicId': dynamicId,
        },
        token: cancelToken,
        complete: CommunityModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  Future<bool> buyCommunity({
    required int dynamicId,
  }) async {
    try {
      final _ = await httpInstance.post(
        url: "community/dynamic/pur",
        body: {
          'dynamicId': dynamicId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ClassifyHotModel>?> getHotTitleList() async {
    try {
      final resp = await httpInstance.get<ClassifyHotModel>(
        url: 'search/getScrollTitleList',
        complete: ClassifyHotModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<UserInfo?> getUserInfo({
    required int userId,
  }) async {
    try {
      final resp = await httpInstance.post<UserInfo>(
        url: 'user/base/info',
        body: {"userId": userId},
        complete: UserInfo.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  Future<CommunityTopicModel?> getTopicInfo({
    required String topic,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityTopicModel>(
        url: 'topic/info',
        queryMap: {
          'name': topic,
        },
        complete: CommunityTopicModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityTopicModel>?> getTopic({
    required int page,
    required int pageSize,
    required int classifyId,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityTopicModel>(
        url: 'topic/list',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'classifyId': classifyId,
        },
        complete: CommunityTopicModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityTopicModel>?> getCommunityTopic() async {
    try {
      final resp = await httpInstance.get<CommunityTopicModel>(
        url: 'topic/postGetTopic',
        complete: CommunityTopicModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<bool> communityRelease({
    required CommunityReleaseModel model,
  }) async {
    try {
      final _ = await httpInstance.post(
        url: 'community/dynamic/release',
        body: model.toJson(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> communitySaveComment({
    required CommentSendModel model,
  }) async {
    try {
      final _ = await httpInstance.post(
        url: 'community/dynamic/saveComment',
        body: model.toJson(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ArchiveModel>?> getArchiveRecord({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<ArchiveModel>(
        url: 'user/archive/queryUserRecords',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: ArchiveModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<ActivityModel>?> getActivityList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<ActivityModel>(
        url: 'activity/getActivityList',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: ActivityModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<CommentDynamicModel>?> getCommentList({
    required int dynamicId,
    required int parentId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<CommentDynamicModel>(
        url: 'community/dynamic/commentList',
        queryMap: {
          'dynamicId': dynamicId,
          'parentId': parentId,
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommentDynamicModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<BloggerBaseModel>?> getHotBloggerList() async {
    try {
      final resp = await httpInstance.get<BloggerBaseModel>(
        url: 'blogger/queryList',
        queryMap: {
          'page': 1,
          'pageSize': 5,
          'type': 4,
        },
        complete: BloggerBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<BloggerBaseModel>?> getBloggerList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<BloggerBaseModel>(
        url: 'blogger/queryList',
        queryMap: {
          'type': 4,
          'page': page,
          'pageSize': pageSize,
        },
        complete: BloggerBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }
}
