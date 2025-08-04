import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../../components/base_refresh/base_refresh_data_keeper.dart';
import '../../../../components/base_refresh/base_refresh_tab_controller.dart';
import '../../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../../http/api/api.dart';
import '../../../../model/content_model.dart';
import '../../../../model/video_actress_model.dart';

const _orderTypeMostPlayed = 1;
const _orderTypeLatestAdd = 2;
const _pageSize = 20;
const _useObs = true;

class _DataKeeper
    extends BaseRefreshDataKeeperWithERController<VideoContentModel> {
  final BaseRefreshTabIndexKey tabKey;
  final int? contentId;
  _DataKeeper({required this.tabKey, required this.contentId});

  @override
  bool get useObs => _useObs;

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;

  @override
  Future<List<VideoContentModel>?> dataFetcher(int page,
      {required bool isRefresh}) async {
    if (contentId == null) return null;
    final orderType =
        ContentActressDetailPageController.getOrderType(tabKey.index);
    return Api.fetchContentActressVideos(
      contentId: contentId!,
      page: page,
      pageSize: _pageSize,
      orderType: orderType,
    );
  }
}

class ContentActressDetailPageController
    extends BaseRefreshDefaultTabController {
  static const sortTypeTabs = [
    Tuple2('最多播放', _orderTypeMostPlayed),
    Tuple2('最近添加', _orderTypeLatestAdd),
  ];
  static const mostPlayedIndex = 1;
  static const latestAddIndex = 2;
  static const defaultIndex = mostPlayedIndex;
  static int getOrderType(int index) => sortTypeTabs[index].item2;

  int? _contentId;
  final detail = ContentDetailModel.empty().obs;

  @override
  bool get useObs => _useObs;

  @override
  BaseRefreshDataKeeperWithERController initDataKeeper(
      BaseRefreshTabKey tabKey) {
    return _DataKeeper(
      tabKey: tabKey as BaseRefreshTabIndexKey,
      contentId: _contentId,
    );
  }

  Future<void> _fetchContentActressDetail() async {
    if (_contentId == null) return;
    final detail = await Api.fetchContentActressDetail(_contentId!);
    if (detail != null) {
      this.detail.value = detail;
    }
  }

  Future<void> toogleAttention() async {
    // if (detail.value.isEmpty) return Future.value(null);
    final future = Api.toogleAttentionContentActress(detail.value.contentId,
        attention: detail.value.isAttention);
    final ok = await FutureLoadingDialog(future).show();
    if (ok == true) {
      detail.update((v) {
        if (v == null) return;
        v.isAttention = !v.isAttention;
      });
    }
  }

  @override
  void onInit() {
    _contentId = int.tryParse(Get.parameters['id'] ?? '');
    _fetchContentActressDetail();
    super.onInit();
  }
}
