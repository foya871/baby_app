import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/components/popup/dialog/future_loading_dialog.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/ai/ai_models.dart';
import 'package:baby_app/utils/file_downloader.dart';
import 'package:baby_app/utils/logger.dart';
import 'package:tuple/tuple.dart';

class TabChildRecordPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // 刷新控制器
  final EasyRefreshController refreshController = EasyRefreshController();
  late TabController tabController;

  // Tab 选项
  List<Tuple2<String, String>> tabs = const [
    Tuple2("生成成功", "success"),
    Tuple2("处理中", "received"),
    Tuple2("生成失败", "error"),
  ];

  // 当前选中的状态
  final RxInt checkedStatus = 0.obs;

  /// 分页控制器: tabIndex -> checkedStatus -> PagingController
  final Map<int, Map<String, PagingController<int, AiRcRecordV2Model>>>
      pagingControllers = {};

  // 记录当前分页信息
  Map<int, Map<String, int>> pageIndices = {};

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
    for (var i = 1; i <= 6; i++) {
      pageIndices[i] = {};
      for (int tab = 0; tab < tabs.length; tab++) {
        getPagingController(i, tabs[tab].item2);
      }
    }
  }

  /// 获取 PagingController
  PagingController<int, AiRcRecordV2Model> getPagingController(
      int tabIndex, String tabStatus) {
    pagingControllers.putIfAbsent(tabIndex, () => {});
    return pagingControllers[tabIndex]!.putIfAbsent(
      tabStatus,
      () => PagingController<int, AiRcRecordV2Model>(firstPageKey: 1),
    );
  }

  /// 获取数据
  Future<void> getHttpDatas({
    required int tabIndex,
    required String tabStatus,
    required bool isRefresh,
  }) async {
    final controller = getPagingController(tabIndex, tabStatus);
    if (isRefresh) {
      pageIndices[tabIndex]![tabStatus] = 1;
      controller.refresh();
    }
    if (tabIndex == 2 || tabIndex == 3) {
      Api.fetchAiFaceRecord(
        type: tabIndex,
        status: tabStatus,
        page: pageIndices[tabIndex]![tabStatus]!,
        pageSize: 20,
      ).then((response) {});
    } else {
      if (tabIndex == 1) {
        Api.fetchAiClothRecordV2(
          type: tabIndex,
          status: tabStatus,
          page: pageIndices[tabIndex]![tabStatus]!,
          pageSize: 20,
        ).then((response) {});
      } else {}
    }
  }

  ///保存
  saveAiRecord(List<String> fileNames) async {
    if (fileNames.isEmpty) {
      return;
    }
    for (final fileName in fileNames) {
      final result = await FutureLoadingDialog.progress(
        (_) => filedownloader.downloadMediaToGallery(
          fileName,
          onProgress: _.updateProgress,
        ),
        tips: '下载中...',
      ).show();
      if (result == null || result == FileDownloaderResult.fail) {
        showToast('保存失败');
        return;
      } else {
        logger.d('broswer downloading...');
      }
    }
    if (fileNames.isNotEmpty) {
      showToast('保存成功');
    }
  }

  ///申诉
  appealAiRecord(String tradeNo) {
    if (tradeNo.isEmpty) {
      return;
    }
  }

  /// 删除记录
  deleteAiRecord(int type, String tabStatus) {
    Api.delAiRecord(type: type, status: tabStatus).then((value) {
      if (value) {
        getHttpDatas(tabIndex: type, tabStatus: tabStatus, isRefresh: true);
      }
    });
  }

  /// 删除单个记录
  delOneAiRecord(int type, String tabStatus, String tradeNo) {
    if (tradeNo.isEmpty) {
      return;
    }
    Api.delOneAiRecord(tradeNo).then((value) {});
  }

  @override
  void onClose() {
    tabController.dispose();
    for (var controllers in pagingControllers.values) {
      for (var controller in controllers.values) {
        controller.dispose();
      }
    }
    super.onClose();
  }
}
