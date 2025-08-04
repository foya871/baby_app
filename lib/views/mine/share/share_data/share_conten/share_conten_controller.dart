import 'package:get/get.dart';
import 'package:http_service/http_service.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../model/mine/share_link_model.dart';
import '../../../../../services/user_service.dart';

class ShareContenController extends GetxController {
  final userService = Get.find<UserService>();

  late final ScreenshotController screenController;
  var url = ''.obs;
  var inviteCode = ''.obs;
  var domainFromUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    screenController = ScreenshotController();
    inviteCode.value = userService.user.inviteCode ?? "";
  }

  @override
  void onReady() {
    super.onReady();
    _getSharedLink();
  }

  _getSharedLink() async {
    try {
      final result = await httpInstance.get(
        url: 'user/shared/link',
        requestEntireModel: false,
        complete: ShareRespModel.fromJson,
      );
      url.value = result.url ?? '';
      update();
    } catch (e) {
      return null;
    }
  }
}
