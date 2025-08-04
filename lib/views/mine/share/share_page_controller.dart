import 'package:get/get.dart';
import 'package:http_service/http_service.dart';
import 'package:screenshot/screenshot.dart';
import '../../../model/mine/share_link_model.dart';
import '../../../services/user_service.dart';

class SharePageController extends GetxController {
  final userService = Get.find<UserService>();

  var screenController = ScreenshotController();
  var url = ''.obs;
  var inviteCode = ''.obs;
  var domainFromUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
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
      // final result = await Api.getShareLink();
      // if (result.isEmpty) return;
      url.value = result.url ?? '';
      // domainFromUrl.value = (result.url ?? '').split('?').first;
    } catch (e) {
      return null;
    }
  }

  @override
  void onClose() {
    // 确保在控制器销毁时清理资源
    super.onClose();
  }
}
