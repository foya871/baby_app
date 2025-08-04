import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:baby_app/components/easy_toast.dart';
import 'package:baby_app/components/image_picker/easy_image_picker.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/message/message_model.dart';
import 'package:baby_app/model/message/send_message_model.dart';
import 'package:baby_app/model/user/user_info_model.dart';
import 'package:baby_app/utils/loading_dialog.dart';
import 'package:baby_app/utils/logger.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:http_service/http_service.dart';

class MessageDetailController extends GetxController {
  final messageList = <MessageModel>[].obs;
  late int toUserId;
  final toUserInfo = UserInfo().obs;

  final inputController = TextEditingController();
  final ValueNotifier<bool> showTextSend = ValueNotifier(false);
  final FocusNode textInputFocusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  final EasyRefreshController refreshController = EasyRefreshController();

  final sendMessageModel = SendMessageModel().obs;

  // 分页相关
  int? latestMessageId;
  bool hasMoreData = true;
  bool isLoading = false;

  // 轮询相关
  Timer? _pollingTimer;

  static const pageSize = 20;

  @override
  void onInit() {
    super.onInit();
    toUserId = Get.arguments['toUserId'];
    fetchUserInfo();
    _startPolling();
    fetchMessageList();
  }

  @override
  void onClose() {
    _pollingTimer?.cancel();
    scrollController.dispose();
    refreshController.dispose();
    super.onClose();
  }

  fetchUserInfo() async {
    final resp = await Api.getUserInfo(userId: toUserId);
    toUserInfo.value = resp ?? UserInfo();
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchMessageList();
    });
  }

  void fetchMessageList({bool fetchHistory = false}) async {
    if (isLoading) return;

    isLoading = true;

    final resp = await Api.fetchMessageList(
      toUserId: toUserId,
      lastId: fetchHistory ? latestMessageId ?? 0 : 0,
      pageSize: pageSize,
    );

    if (resp.isNotEmpty) {
      addMessages(resp);
    }

    hasMoreData = resp.length >= pageSize;

    if (!fetchHistory) {
      scrollToBottom();
    }

    isLoading = false;
  }

  addMessages(List<MessageModel> messages) {
    if (messages.isEmpty) return;

    _mergeMessages(messages);
    updateLastMessageId();
  }

  updateLastMessageId() {
    final sortedMessages = List<MessageModel>.from(messageList)
      ..removeWhere((e) => e.msgType == 0)
      ..sort((a, b) {
        final dateA = DateTime.tryParse(a.createdAt ?? '') ?? DateTime(1900);
        final dateB = DateTime.tryParse(b.createdAt ?? '') ?? DateTime(1900);
        return dateA.compareTo(dateB);
      });

    latestMessageId = sortedMessages.first.msgId;
  }

  void loadMoreMessageList() async {
    if (isLoading || !hasMoreData || latestMessageId == null) return;

    fetchMessageList(fetchHistory: true);
  }

  void _mergeMessages(List<MessageModel> newMessages) {
    final existingIds = messageList
        .where((msg) => msg.msgId != null && msg.msgType != 0)
        .map((msg) => msg.msgId!)
        .toSet();

    final filtered = newMessages
        .where((msg) => msg.msgId != null && !existingIds.contains(msg.msgId))
        .toList();

    if (filtered.isEmpty) return;

    final mergedList = [...messageList, ...filtered];

    final processedMessages = _processMessages(mergedList);

    messageList.assignAll(processedMessages);
  }

  List<MessageModel> _processMessages(List<MessageModel> messages) {
    if (messages.isEmpty) return messages;

    final sortedMessages = List<MessageModel>.from(messages)
      ..sort((a, b) {
        final dateA = DateTime.tryParse(a.createdAt ?? '') ?? DateTime(1900);
        final dateB = DateTime.tryParse(b.createdAt ?? '') ?? DateTime(1900);
        return dateA.compareTo(dateB);
      });

    // 处理日期分隔符
    return _processMessageListWithDateSeparators(sortedMessages);
  }

  /// 处理消息列表，按日期分组插入时间分隔符
  List<MessageModel> _processMessageListWithDateSeparators(
      List<MessageModel> messages) {
    if (messages.isEmpty) return messages;

    messages.removeWhere((e) => e.msgType == 0);

    List<MessageModel> processedMessages = [];
    String? lastDate;

    for (int i = 0; i < messages.length; i++) {
      final message = messages[i];
      final messageDate = Utils.dateFmtWith(
          message.createdAt ?? '', ['yyyy', '.', 'mm', '.', 'dd']);

      // 如果是第一条消息或者日期发生变化，插入日期分隔符
      if ((lastDate == null || lastDate != messageDate) &&
          message.msgType != 0) {
        processedMessages.add(MessageModel(
          createdAt: message.createdAt,
          msgType: 0,
          msgId: generateRandomUdidInt(),
        ));
      }
      lastDate = messageDate;

      processedMessages.add(message);
    }

    return processedMessages;
  }

  Future<void> sendMessage() async {
    if (inputController.text.isEmpty) {
      return;
    }

    sendMessageModel.value.toUserId = toUserId;
    sendMessageModel.value.content = inputController.text;

    final result = await Api.sendMessage(
      sendMessageModel: sendMessageModel.value,
    );
    if (result) {
      inputController.clear();
      textInputFocusNode.unfocus();
      fetchMessageList();
    }
  }

  sendPictureMesage() async {
    final url = await uploadImg();
    if (url == null) {
      return;
    }

    sendMessageModel.value.imgs = [url];
    sendMessageModel.value.toUserId = toUserId;
    final resp = await Api.sendMessage(
      sendMessageModel: sendMessageModel.value,
    );
    if (resp) {
      fetchMessageList();
    }
  }

  Future<String?> uploadImg() async {
    final imageFile = await EasyImagePicker.pickSingleImageGrant();
    final bytes = await imageFile?.bytes;
    if (bytes != null) {
      return postUploadImg(bytes);
    }
    return null;
  }

  Future<String?> postUploadImg(Uint8List bytes) async {
    showCustomDialog(Get.context!, "正在上传中,请稍候..");
    try {
      ImageUploadRspModel? resp =
          await httpInstance.uploadImage(bytes, (int count, int total) {
        logger.d("$count/$total");
      });
      closeDialog(Get.context!);
      EasyToast.show('上传成功');
      return resp?.fileName;
    } catch (_) {
      closeDialog(Get.context!);
      EasyToast.show('上传失败');
      return null;
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  int generateRandomUdidInt() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    int randomPart = Random().nextInt(100000);
    return timestamp + randomPart;
  }
}
