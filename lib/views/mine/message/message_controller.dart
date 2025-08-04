import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/message/message_notice_model.dart';
import 'package:flutter/material.dart';
import 'package:baby_app/model/message/chat_list_model.dart';
import 'package:get/get.dart';

class MessageController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  final List<MessageSegment> tabList = [
    MessageSegment.message,
    MessageSegment.comment,
    MessageSegment.service
  ];

  final chatList = <ChatListModel>[].obs;

  final userNoticeList = <MessageNoticeModel>[].obs;

  int page = 1;
  int pageSize = 50;

  int userNoticePage = 1;
  int userNoticePageSize = 30;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabList.length, vsync: this);
    fetchChatList();
    fetchUserNoticeList();
  }

  void fetchChatList({bool isRefresh = false}) async {
    if (isRefresh) {
      page = 1;
    }
    final resp = await Api.fetchChatList(
      page: page,
      pageSize: pageSize,
    );
    if (isRefresh) {
      chatList.value = resp;
    } else {
      chatList.addAll(resp);
    }
    page++;
  }

  void fetchUserNoticeList({
    bool isRefresh = false,
    int? informationType,
  }) async {
    if (isRefresh) {
      userNoticePage = 1;
    }
    final resp = await Api.fetchUserNoticeList(
      informationType: informationType,
      page: userNoticePage,
      pageSize: userNoticePageSize,
    );
    if (isRefresh) {
      userNoticeList.value = resp;
    } else {
      userNoticeList.addAll(resp);
    }
    userNoticePage++;
  }
}

enum MessageSegment {
  message('私信'),
  comment('评论'),
  service('客服'),
  ;

  final String title;

  const MessageSegment(this.title);
}
