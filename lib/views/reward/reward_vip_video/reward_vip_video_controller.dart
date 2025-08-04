import 'package:baby_app/model/video_base_model.dart';
import 'package:get/get.dart';

import '../../../components/base_refresh/base_refresh_simple_controller.dart';
import '../../../components/diolog/loading/loading_view.dart';
import '../../../http/api/api.dart';
import '../../../utils/enum.dart';

class RewardVipVideoController
    extends BaseRefreshSimpleController<VideoBaseModel> {
  final _pageSize = 20;
  bool isLoading = false;

  final type = RewardVideoRuleType.news.obs;

  @override
  bool get useObs => true;

  Future<List<VideoBaseModel>?> getRequestResult({
    required int page,
  }) async {
    return LoadingView.singleton.wrap(
        context: Get.context!,
        showing: isLoading,
        asyncFunction: () async {
          var result = await Api.getFreeVideoList(
              type: type.value, page: page, pageSize: _pageSize);
          isLoading = false;
          return result;
        });
  }

  switchType(RewardVideoRuleType switchType) {
    isLoading = true;
    type.value = switchType;
    onRefresh();
  }

  @override
  void onReady() {
    super.onReady();
    onRefresh();
  }

  @override
  Future<List<VideoBaseModel>?> dataFetcher(int page,
      {required bool isRefresh}) async {
    return getRequestResult(page: page);
  }

  @override
  bool noMoreChecker(List<VideoBaseModel> resp) {
    return resp.length < _pageSize;
  }
}
