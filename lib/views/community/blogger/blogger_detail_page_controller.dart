import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/user/user_info_model.dart';
import 'package:get/get.dart';

class BloggerDetailPageController extends GetxController {
  var userId = 0.obs;
  var userInfo = UserInfo.fromJson({}).obs;
  var personSign = ''.obs;

  @override
  void onInit() {
    if (Get.parameters.isNotEmpty) {
      userId.value = int.tryParse(Get.parameters['userId'] ?? '') ?? 0;
      getUserInfo(userId.value);
    }
    super.onInit();
  }

  Future getUserInfo(int userId) async {
    final result = await Api.getUserInfo(
      userId: userId,
    );

    if (result != null) {
      userInfo.value = result;
      var personSignStr = userInfo.value.personSign ?? '';
      if (personSignStr.isEmpty) {
        personSignStr = '空空如也～';
      }
      personSign.value = personSignStr;
    }
  }

  Future bloggerAttention(int toUserId, bool isAttention) async {
    final result = await Api.bloggerAttention(
      toUserId: toUserId,
      isAttention: isAttention,
    );

    if (result) {
      userInfo.update((data) {
        data?.attention = !isAttention;
      });
      userInfo.refresh();
    }
  }
}
