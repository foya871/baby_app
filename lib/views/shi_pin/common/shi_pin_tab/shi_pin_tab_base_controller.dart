import 'package:get/get.dart';
import 'package:baby_app/components/base_refresh/base_refresh_tab_controller.dart';

import '../../../../components/base_refresh/base_refresh_share_tab_controller.dart';
import '../../../../components/base_refresh/base_refresh_simple_controller.dart';
import '../../../../model/classify/classify_models.dart';

abstract class ShiPinTabBaseController<E>
    extends BaseRefreshSimpleController<E> {
  final ClassifyModel classify;

  ShiPinTabBaseController(this.classify);
}

abstract class ShiPinTabBaseShareTabContorller
    extends BaseRefreshShareTabController {
  final ClassifyModel classify;

  ShiPinTabBaseShareTabContorller(this.classify, {required super.enableJump});
}

abstract class ShiPinTabBaseDefaultTabController
    extends BaseRefreshDefaultTabController {
  final ClassifyModel classify;
  ShiPinTabBaseDefaultTabController(this.classify);
}

abstract class ShiPinTabBaseCustomController extends GetxController {
  final ClassifyModel classify;

  ShiPinTabBaseCustomController(this.classify);
}
