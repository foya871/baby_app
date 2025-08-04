import 'package:get/get.dart';

import '../../../../http/api/api.dart';
import '../../../../model/user/Proxy_model.dart';

class ShareDataController extends GetxController {
  final proxyData = ProxyModel.fromJson({}).obs;

  @override
  void onInit() {
    super.onInit();
    print('onInit');
    _getProxyData();
  }

  _getProxyData() async {
    final resp = await Api.proxyData();
    if (resp != null) {
      proxyData.value = resp;
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }
}
