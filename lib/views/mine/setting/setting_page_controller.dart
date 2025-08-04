import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/announcement/announcement.dart';
import 'package:baby_app/components/announcement/version_update_box.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/permissions_utils.dart';
import 'package:tuple/tuple.dart';

import '../../../components/diolog/loading/loading_view.dart';
import '../../../components/upload/upload_enum.dart';
import '../../../components/upload/upload_model.dart';
import '../../../components/upload/upload_utils.dart';
import '../../../http/api/api.dart';
import '../../../services/user_service.dart';

class SettingPageController extends GetxController {
  final userService = Get.find<UserService>();
  TextEditingController nickNameController = TextEditingController();

  var avatar = ''.obs;
  var imageCacheSize = "0 M".obs;
  bool isHaveAccount = false;

  RxList<Tuple2<String, String>> list = const [
    Tuple2("用户昵称", ""),
    Tuple2("用户ID", ""),
    Tuple2("登录注册", ""),
    Tuple2("清除缓存", "0M"),
    if (!kIsWeb) Tuple2("检查更新", "已是最新版本"),
  ].obs;

  @override
  void onInit() {
    avatar.value = userService.user.logo ?? AppImagePath.app_default_avatar;
    list[0] = Tuple2("用户昵称", userService.user.nickName ?? "");
    list[1] = Tuple2("用户ID", "${userService.user.userId ?? 0}");
    isHaveAccount = userService.user.account != null &&
        userService.user.account!.isNotEmpty;
    if (isHaveAccount) {
      list[2] = Tuple2("切换账号", userService.user.account ?? "");
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getImageCacheSize();
    checkVersion().then((response) async {
      if (response != null && response.hasNewVersion == true) {
        list[4] = Tuple2("检查更新", "新版本v${response.versionNum ?? ''}");
      }
    });
  }

  onClick(String title) async {
    switch (title) {
      case '头像':
        uploadAvatar();
        break;
      case '登录注册':
      case '切换账号':
        await Get.toNamed(Routes.mineLoginRegister, arguments: isHaveAccount);
        isHaveAccount = userService.isBindAccount;
        if (isHaveAccount) {
          list[2] = Tuple2("切换账号", userService.user.account ?? "");
          list.refresh();
        }
        break;
      case '清除缓存':
        clearImageCacheSize();
        break;
      case '检查更新':
        startCheckVersion();
        break;
      case '保存':
        startSave();
        break;
      default:
        break;
    }
  }

  /// 上传头像
  uploadAvatar() async {
    final status = await PermissionsUtils.requestPhotosPermission();
    if (!status) {
      showToast("请前往设置打开相册权限");
      return;
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      Uint8List bytes = kIsWeb
          ? result.files[0].bytes!
          : await File(result.paths[0]!).readAsBytes();
      final suffix = (result.files[0].name).split('.').last;
      UploadModel model = UploadModel(
        type: UploadType.image,
        path: "",
        status: UploadStatus.queuing,
        progress: 0,
        originBytes: bytes,
        thumbnailImage: bytes,
        fileSuffix: suffix,
      );

      LoadingView.singleton.wrapWidget(
          context: Get.context!,
          asyncFunction: () async {
            final result = await UploadUtils.uploadImage(model, (progress) {});
            if (result != null) {
              avatar.value = result.path;
              model.status = UploadStatus.success;
            }
          });
    }
  }

  /// 获取图片缓存大小
  getImageCacheSize() async {
    ImageCache? imageCache = PaintingBinding.instance.imageCache;
    int byte = imageCache.currentSizeBytes;
    if (byte >= 0 && byte < 1024) {
      imageCacheSize.value = '$byte B';
    }
    if (byte >= 1024 && byte < 1024 * 1024) {
      double size = (byte * 1.0 / 1024);
      String sizeStr = size.toStringAsFixed(2);
      imageCacheSize.value = '$sizeStr KB';
    } else {
      double size = (byte * 1.0 / 1024) / 1024;
      String sizeStr = size.toStringAsFixed(2);
      imageCacheSize.value = '$sizeStr MB';
    }
    list[3] = Tuple2("清除缓存", imageCacheSize.value);
  }

  /// 清除图片缓存
  clearImageCacheSize() {
    ImageCache? imageCache = PaintingBinding.instance.imageCache;
    imageCache.clear();
    getImageCacheSize();
  }

  startCheckVersion() async {
    final response = await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          return await checkVersion();
        });
    if (response != null && response.hasNewVersion == true) {
      String? androidApkURL = await fetchLandMarkURL();
      SmartDialog.show(builder: (_) {
        // return _buildVersionDialogView(response,
        //     androidApkURL: androidApkURL);
        return VersionUpdateBox(model: response, androidApkURL: androidApkURL);
      });
    } else {
      showToast('您目前是最新版本！');
    }
  }

  startSave() {
    final nickName = nickNameController.text.trim();
    LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          Api.modifyInfo(
            logo: avatar.value,
            nickName: nickName,
          ).then((response) {
            if (response) {
              userService.updateAPIUserInfo();
              Get.back();
            }
          });
        });
  }
}
