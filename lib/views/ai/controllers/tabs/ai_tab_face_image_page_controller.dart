import 'package:get/get.dart';

import '../../../../components/base_refresh/base_refresh_data_keeper.dart';
import '../../../../components/base_refresh/base_refresh_tab_controller.dart';
import '../../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../../http/api/api.dart';
import '../../../../http/service/api_code.dart';
import '../../../../model/ai/ai_models.dart';
import '../../../../routes/routes.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/consts.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/extension.dart';
import '../../common/ai_bytes_image.dart';
import '../../common/ai_sort_cell.dart';
import '../../common/popup/ai_cost_gold_confirm_dialog.dart';
import '../../common/popup/ai_no_image_tips_dialog.dart';

const _pageSize = 60;
const _useObs = true;
const _sortTypeTime = 1; // 上架时间
const _sortTypePrice = 2; // 价格排序
const _sortTypeUsedCount = 3; // 使用次数

class _DataKeeper
    extends BaseRefreshDataKeeperWithERController<AiStencilModel> {
  final AiStencilClassModel classify;
  final AiStencilSortArgs Function() sortGetter;

  _DataKeeper({required this.classify, required this.sortGetter});

  int _getSortType(AiStenceilSortType type) => switch (type) {
        AiStenceilSortType.time => _sortTypeTime,
        AiStenceilSortType.price => _sortTypePrice,
        AiStenceilSortType.usedCount => _sortTypeUsedCount,
      };

  @override
  bool get useObs => _useObs;

  @override
  Future<List<AiStencilModel>?> dataFetcher(int page,
      {required bool isRefresh}) {
    final args = sortGetter();
    return Api.fetchAiFaceImageStencil(
      page: page,
      pageSize: _pageSize,
      classId: classify.isAll ? null : classify.classId,
      sortType: _getSortType(args.type),
      sortAsc: args.asc,
    );
  }

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;
}

class AiTabFaceImagePageController extends BaseRefreshDefaultTabController
    with StateMixin<void>, GetSingleTickerProviderStateMixin {
  final classifyList = <AiStencilClassModel>[];
  final sortArgs = <AiStencilSortArgs>[].obs;

  @override
  bool get useObs => _useObs;

  @override
  BaseRefreshDataKeeperWithERController initDataKeeper(
      BaseRefreshTabKey tabKey) {
    final key = tabKey as BaseRefreshTabIndexKey;
    return _DataKeeper(
      classify: classifyList[key.index],
      sortGetter: () => sortArgs[key.index],
    );
  }

  void onTapSort(BaseRefreshTabIndexKey tabKey, AiStenceilSortType sortType) {
    final args = sortArgs[tabKey.index];
    late AiStencilSortArgs newArgs;
    if (args.type == sortType) {
      // 点击同一个排序
      newArgs = AiStencilSortArgs(type: args.type, asc: !args.asc);
    } else {
      // 点击不同排序
      newArgs = AiStencilSortArgs(type: sortType, asc: false);
    }
    sortArgs[tabKey.index] = newArgs;

    FutureLoadingDialog(onRefresh(tabKey)).show();
  }

  void onTapMake(AiStencilModel stencil, AiBytesImage? file) async {
    if (file == null) {
      AiNoImageTipsDialog().show();
      return;
    }

    final userService = Get.find<UserService>();
    final costType = userService.checkAiCost(
      costAiNum: Consts.aiFaceImageCostCount,
      costGold: stencil.amount,
    );
    if (costType == AiCostType.fail) {
      ApiCode.defaultGoldLackHandler();
    } else if (costType == AiCostType.gold) {
      AiCostGoldConfirmDialog.faceImage(
        stencil.amount,
        onConfirm: () => _onMakeConfirm(stencil, file),
      ).show();
    } else {
      _onMakeConfirm(stencil, file);
    }
  }

  void _onMakeConfirm(AiStencilModel stencil, AiBytesImage file) async {
    final future = Api.createAiFaceImageOrder(stencil.stencilId, file.bytes);
    final resp = await FutureLoadingDialog(future, tips: '上传中..').showUnsafe();
    ApiCode.handle(
      resp,
      successToast: '提交成功',
      onSuccess: () => Get.untilNamed(Routes.main),
    );
  }

  Future<void> fetchClassify() async {
    change(null, status: RxStatus.loading());
    final classifyList = await Api.fetchAiFaceImageClassify();
    if (classifyList != null) {
      this.classifyList.assignAll([AiStencilClassModel.all(), ...classifyList]);
      sortArgs.assignAll(
        List.generate(
          this.classifyList.length,
          (i) => AiStencilSortArgs(type: AiStenceilSortType.time, asc: false),
        ),
      );
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchClassify();
  }
}
