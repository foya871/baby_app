import 'package:baby_app/views/mine/mine_page_controller.dart';
import 'package:get/get.dart';
import 'package:http_service/http_service.dart';
import '../../../../model/mine/share_link_model.dart';
import '../../../http/api/api.dart';
import '../../../services/storage_service.dart';
import '../../../services/user_service.dart';

class AccountCredentialsController extends GetxController {
  final us = Get.find<UserService>();
  var share = ShareRespModel();

  get userInfo => us.user;
  var permanentAddress = ''.obs;

  final storageService = Get.find<StorageService>();

  Future getShareInfo() async {
    share = await httpInstance.get(
        url: "user/shared/link", complete: ShareRespModel.fromJson);
    if (share == null) return;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getShareInfo();
    MinePageController minePageController = Get.find<MinePageController>();
    permanentAddress.value = minePageController.permanentAddress.value;
  }
}
