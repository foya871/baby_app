part of 'api.dart';

extension ApiBusinessMsg on _Api {
  /// 聊天列表
  Future<List<ChatListModel>> fetchChatList({
    int? page,
    int? pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<ChatListModel>(
        url: 'privateChat/chatList',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: ChatListModel.fromMap,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  /// 聊天列表
  Future<List<MessageModel>> fetchMessageList({
    required int toUserId,
    required int lastId,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<MessageModel>(
        url: 'privateChat/messageList',
        queryMap: {
          'toUserId': toUserId,
          'lastId': lastId,
          'pageSize': pageSize,
        },
        complete: MessageModel.fromMap,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  /// 发送消息
  Future<bool> sendMessage({
    required SendMessageModel sendMessageModel,
  }) async {
    try {
      await httpInstance.post(
        url: 'privateChat/send',
        body: sendMessageModel.toMap(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 获取用户消息/全部(不含系统)
  /// informationType: 消息类型 4-评论 5-粉丝 6-点赞 11-催更 /不传 获取全部
  Future<List<MessageNoticeModel>> fetchUserNoticeList({
    int? informationType,
    int? page,
    int? pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<MessageNoticeModel>(
        url: 'information/user/notice',
        queryMap: {
          'informationType': informationType,
          'page': page,
          'pageSize': pageSize,
        },
        complete: MessageNoticeModel.fromMap,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  /// 获取通知数量
  Future<NoticeNumModel?> getNoticeNum() async {
    try {
      final resp = await httpInstance.get<NoticeNumModel>(
        url: 'information/msgNoticeNum',
        complete: NoticeNumModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }
}
