/*
 * @description: 
 * @FilePath: /baby_app/lib/views/mine/mine_withdrawal/mine_withdrawal_record_page_controller.dart
 * @author: david
 * @文件版本: V1.0.0
 * @Date: 2025-06-28 15:45:44
 * 版权信息: 2025 by david, All Rights Reserved.
 */
import 'package:baby_app/components/base_refresh/base_refresh_simple_controller.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/mine/withdrawal_record_model.dart';

const int pageSize = 10;
const bool _useObs = true;

class MineWithdrawalRecordPageController
    extends BaseRefreshSimpleController<WithdrawalRecordModel> {
  @override
  Future<List<WithdrawalRecordModel>?> dataFetcher(int page,
      {required bool isRefresh}) {
    return Api.getWithdrawalRecord(page: page, pageSize: pageSize);
  }

  @override
  bool noMoreChecker(List resp) {
    if (resp.length < pageSize) {
      return true;
    }
    return false;
  }

  @override
  bool get useObs => _useObs;
}
