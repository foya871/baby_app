import 'package:get/get.dart';

import '../../../components/base_refresh/base_refresh_simple_controller.dart';
import '../../../components/diolog/loading/loading_view.dart';
import '../../../http/api/api.dart';
import '../../../model/announcement/activity_model.dart';

class ActivityCenterController
    extends BaseRefreshSimpleController<ActivityModel> {
  final _pageSize = 20;

  @override
  bool get useObs => true;

  Future<List<ActivityModel>?> getRequestResult({
    required int page,
  }) async {
    return await Api.getActivityList(page: page, pageSize: _pageSize);
  }

  @override
  void onReady() {
    super.onReady();
    onRefresh();
  }

  @override
  Future<List<ActivityModel>?> dataFetcher(int page,
      {required bool isRefresh}) async {
    return getRequestResult(page: page);
  }

  @override
  bool noMoreChecker(List<ActivityModel> resp) {
    return resp.length < _pageSize;
  }
}
