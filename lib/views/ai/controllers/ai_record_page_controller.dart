import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/base_refresh/base_refresh_data_keeper.dart';
import '../../../components/base_refresh/base_refresh_tab_controller.dart';
import '../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../http/api/api.dart';
import '../../../utils/enum.dart';
import '../../../utils/extension.dart';
import '../common/ai_record_cell.dart';
import '../common/popup/ai_delete_dialog.dart';

const _fetchRecrodPageSize = 60;
// 类型
const _fetchRecrodTypeClothOff = 1;
const _fetchRecrodTypeFaceImage = 2;
const _fetchRecrodTypeFaceVideo = 3;
// const _fetchRecrodTypeFaceCustom = 4;
//
const _useObs = true;

class AiRecordTabKey extends BaseRefreshTabKey {
  final int typeIndex;
  final int statusIndex;
  AiRecordTabKey(this.typeIndex, this.statusIndex);
  @override
  String toKey() => '$typeIndex-$statusIndex';
}

int? _getFetchType(int typeIndex) {
  return switch (typeIndex) {
    AiRecordPageController.typeTabClothOffIndex => _fetchRecrodTypeClothOff,
    AiRecordPageController.typeTabFaceImageIndex => _fetchRecrodTypeFaceImage,
    AiRecordPageController.typeTabFaceVideoIndex => _fetchRecrodTypeFaceVideo,
    // AiRecordPageController.typeTabFaceCustomIndex => _fetchRecrodTypeFaceCustom,
    _ => null,
  };
}

AiRecordStatus? _getFetchStatus(int statusIndex) {
  return switch (statusIndex) {
    AiRecordPageController.statusTabSuccessIndex => AiRecordStatusEnum.success,
    AiRecordPageController.statusTabMakingIndex => AiRecordStatusEnum.received,
    AiRecordPageController.statusTabFailureIndex => AiRecordStatusEnum.error,
    _ => null,
  };
}

class _DataKeeper
    extends BaseRefreshDataKeeperWithERController<AiRecordCellOption> {
  final AiRecordTabKey tabKey;
  final VoidCallback? onDelSuccess;
  _DataKeeper(this.tabKey, {this.onDelSuccess});

  @override
  bool get useObs => _useObs;

  @override
  bool noMoreChecker(List<AiRecordCellOption> resp) =>
      resp.length < _fetchRecrodPageSize;

  @override
  Future<List<AiRecordCellOption>?> dataFetcher(int page,
      {required bool isRefresh}) async {
    final fetchType = _getFetchType(tabKey.typeIndex);
    final fetchStatus = _getFetchStatus(tabKey.statusIndex);
    if (fetchType == null || fetchStatus == null) {
      return null;
    }
    List<AiRecordCellOption>? options;
    if (tabKey.typeIndex == AiRecordPageController.typeTabClothOffIndex) {
      final resp = await Api.fetchAiClothRecordV2(
        type: fetchType,
        status: fetchStatus,
        page: page,
        pageSize: _fetchRecrodPageSize,
      );
      options = resp
          ?.map(
            (e) => AiRecordCellOption(
              type: AiRecordCellType.image,
              cover: e.fileName,
              fileNames: [e.fileName],
              status: AiRecordStatusEnum.to(e.status),
              title: null,
              tradeNo: e.tradeNo,
              onDelSuccess: onDelSuccess,
            ),
          )
          .toList();
    } else {
      final resp = await Api.fetchAiFaceRecord(
        type: fetchType,
        status: fetchStatus,
        page: page,
        pageSize: _fetchRecrodPageSize,
      );
      final cellType =
          tabKey.typeIndex == AiRecordPageController.typeTabFaceVideoIndex
              ? AiRecordCellType.video
              : AiRecordCellType.image;
      options = resp?.data
          .map(
            (e) => AiRecordCellOption(
              type: cellType,
              cover: e.originalImg,
              title: e.stencilName,
              fileNames: cellType == AiRecordCellType.image
                  ? e.fileNames
                  : e.fileNames.map((e) => '${resp.domain}/$e').toList(),
              status: AiRecordStatusEnum.to(e.status),
              tradeNo: e.tradeNo,
              onDelSuccess: onDelSuccess,
            ),
          )
          .toList();
    }
    return options;
  }
}

class AiRecordPageController extends BaseRefreshDefaultTabController
    with GetTickerProviderStateMixin {
  // !!和下面index要配对改啊
  static final List<String> typeTabs = ['AI去衣', 'AI图片换脸', 'AI视频换脸'];
  static const int typeTabClothOffIndex = 0;
  static const int typeTabFaceImageIndex = 1;
  static const int typeTabFaceVideoIndex = 2;
  // !!和下面index要配对改啊
  static final List<String> statusTabs = ['生成成功', '处理中', '失败'];
  static const int statusTabSuccessIndex = 0;
  static const int statusTabMakingIndex = 1;
  static const int statusTabFailureIndex = 2;

  @override
  bool get useObs => _useObs;

  // <typeIndex, statusTabIndex>
  final statusTabControllerIndexes = <int, int>{}.obs;
  // <typeIndex, statusTabController>
  final statusTabControllers = <int, TabController>{};

  TabController getStatusTabController(int typeIndex) =>
      statusTabControllers.putIfAbsent(
        typeIndex,
        () => TabController(length: statusTabs.length, vsync: this)
          ..addFastListener((i) {
            statusTabControllerIndexes[typeIndex] = i;
          }),
      );

  void onTapDeleteStatus(int typeIndex) async {
    final type = _getFetchType(typeIndex);
    const statusIndex = statusTabFailureIndex; // 只有失败有删除
    final status = _getFetchStatus(statusIndex);
    if (type == null || status == null) return;

    AiDeleteStatusDialog(
      onConfirm: () async {
        final future = Api.delAiRecord(type: type, status: status);
        final result =
            await FutureLoadingDialog(future, tips: '正在删除..').showUnsafe();
        if (result) {
          final tabKey = AiRecordTabKey(typeIndex, statusIndex);
          await FutureLoadingDialog(onRefresh(tabKey), tips: '正在刷新数据..').show();
        }
      },
    ).show();
  }

  @override
  BaseRefreshDataKeeperWithERController initDataKeeper(
      BaseRefreshTabKey tabKey) {
    final key = tabKey as AiRecordTabKey;
    return _DataKeeper(
      key,
      onDelSuccess: () => FutureLoadingDialog(onRefresh(tabKey)).show(),
    );
  }

  @override
  void onClose() {
    statusTabControllers.forEach((_, controller) => controller.dispose());
    super.onClose();
  }
}
