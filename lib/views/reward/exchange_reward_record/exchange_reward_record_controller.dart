import 'package:get/get.dart';

import '../../../components/base_refresh/base_refresh_simple_controller.dart';
import '../../../http/api/api.dart';

class ExchangeRewardRecordController
    extends BaseRefreshSimpleController<dynamic> {
  final _pageSize = 20;

  @override
  bool get useObs => true;

  @override
  Future<List<dynamic>?> dataFetcher(int page, {required bool isRefresh}) {
    return getRequestResult(page: page);
  }

  @override
  void onReady() {
    super.onReady();
    onRefresh();
  }

  @override
  bool noMoreChecker(List<dynamic> resp) {
    return resp.length < _pageSize;
  }

  Future<List<dynamic>?> getRequestResult({
    required int page,
  }) async {
    return Api.getRewardRecord(
      page: page,
      pageSize: _pageSize,
    );
  }
}
