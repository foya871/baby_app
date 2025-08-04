import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:baby_app/components/customize_alert.dart';
import 'package:baby_app/components/easy_toast.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:http_service/http_service.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/utils/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageComm extends StatefulWidget {
  final int limit;
  final Function(List<String>) success;

  const ImageComm({super.key, required this.limit, required this.success});

  @override
  State createState() => _ImageComm();
}

class _ImageComm extends State<ImageComm> {
  ValueNotifier<bool> hasImg = ValueNotifier(false);

  Future<ImageUploadRspModel?> imageBack(Uint8List bytes) async {
    ImageUploadRspModel? resp =
        await httpInstance.uploadImage(bytes, (int count, int total) {
      logger.d("$count/$total");
    });
    return resp;
  }

  void getPermission(int limit) async {
    if (!kIsWeb) {
      var status = await Permission.photos.request();
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      if (!status.isGranted && !status.isLimited) {
        // ignore: use_build_context_synchronously
        CustomizeAlert(context, title: '去设置授权', submit: '去设置',
            okAction: () async {
          await openAppSettings();
        });
      }
      if (status.isGranted) {
        imageSupBack(limit);
      }
    } else {
      imageSupBack(limit);
    }
  }

  void imageSupBack(int limit) async {
    List<String> images = [];

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    SmartDialog.showLoading(msg: '上传中');
    if (result != null) {
      hasImg.value = true;
      if (kIsWeb) {
        var list = result.files.take(limit).toList();

        for (var i = 0; i < list.length; i++) {
          var bytes = list[i].bytes;
          try {
            var resp = await imageBack(bytes!);
            images.add(resp!.fileName!);
          } catch (e) {
            var resp = await imageBack(bytes!);
            images.add(resp!.fileName!);
          }
        }
      } else {
        var list = result.paths.take(limit).toList();

        for (var i = 0; i < list.length; i++) {
          Uint8List lll = await File(list[i]!).readAsBytes();
          try {
            var resp = await imageBack(lll);
            images.add(resp!.fileName!);
          } catch (e) {
            var resp = await imageBack(lll);
            images.add(resp!.fileName!);
          }
        }
      }
    }
    SmartDialog.dismiss();
    if (images.isNotEmpty) {
      EasyToast.show('上传成功');
    }
    hasImg.value = false;
    widget.success(images);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: hasImg,
        builder: (context, value, child) {
          return !value
              ? Image.asset(
                  AppImagePath.app_default_placeholder,
                  width: 24.w,
                  height: 24.w,
                ).onOpaqueTap(() {
                  getPermission(widget.limit);
                })
              : SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                );
        });
  }
}
