import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'base_refresh_widget.dart';

/// see: [BaseRefreshWidget]

@Deprecated('使用BaseRefreshSimpleWidget+BaseRefreshSimpleController')
abstract class BaseRefreshController extends GetxController {
  final refreshController = EasyRefreshController();

  Future<IndicatorResult> onRefresh();
  // 可以不启用上滑
  Future<IndicatorResult> onLoad() => Future.value(IndicatorResult.none);

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
