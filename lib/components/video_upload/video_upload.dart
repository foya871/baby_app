import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:http_service/http_service.dart';

import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/utils/utils.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class VideoUpload extends StatefulWidget {
  const VideoUpload({
    super.key,
    required this.success,
    this.title,
    this.isVertical = false,
  });

  final String? title;
  final Function success;
  final bool? isVertical;

  @override
  State<StatefulWidget> createState() => _VideoUpload();
}

class _VideoUpload extends State<VideoUpload> {
  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<String> progress = ValueNotifier('0');
  int finished = 0;
  CancelToken token = CancelToken();
  List<CancelToken> tokenList = List<CancelToken>.of([]);
  final chunkSize = 1 * 1024 * 1024;

  Future upBack(Uint8List file, int pos, String taskId) async {
    tokenList.add(token);
    final resp = await httpInstance.multiPartFormPost(
        url: "upload/video",
        isVideo: true,
        token: token,
        file: file,
        body: {
          "pos": pos,
          "taskId": taskId,
        });
    if (resp == null) {
      upBack(file, pos, taskId);
    } else {
      finished++;
    }
  }

  void videoSlice(Uint8List bytes, String title) async {
    loading.value = true;
    var chunkNum = (bytes.length / chunkSize).ceil();
    int limit = 3;

    String taskId = Utils.md5String(title.split('.').first);
    List<int> list = List.generate(chunkNum, (idx) => idx);

    var count = 0;
    await Future.wait(list.map((item) async {
      while (count >= limit) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
      count++;

      var file = (item == list.length - 1)
          ? bytes.sublist(item * chunkSize)
          : bytes.sublist(item * chunkSize, (item + 1) * chunkSize);
      try {
        // ignore: prefer_typing_uninitialized_variables
        var resp;
        tokenList.add(token);

        /// 分片上传
        resp = await httpInstance.multiPartFormPost(
            url: "upload/video",
            isVideo: true,
            file: file,
            token: token,
            body: {
              "pos": item,
              "taskId": taskId,
            });

        finished++;

        progress.value = (((finished) / chunkNum) * 100).toStringAsFixed(1);
        if (finished == chunkNum) {
          await httpInstance.post(url: "upload/videoOk", isFile: true, body: {
            "checkSum": taskId,
            "id": resp['id'],
            "title": widget.title ?? title,
            "type": 1,
          });
          progress.value = '上传完成';
          widget.success({
            "checkSum": taskId,
            "id": resp['id'],
            "playTime": 0,
            "uri": resp['videoUri'],
            'title': widget.title ?? title
          });
        }
      } catch (e) {
        upBack(file, item, taskId);
      } finally {
        count--;
      }
    }));
  }

  void getPermission() async {
    if (!kIsWeb) {
      await Permission.storage.request();
      var status = await Permission.photos.request();
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        selectImages();
      }
    } else {
      selectImages();
    }
  }

  void selectImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      if (kIsWeb) {
        videoSlice(result.files[0].bytes!, result.files[0].name);
      } else {
        Uint8List lll = await File(result.paths[0]!).readAsBytes();
        videoSlice(lll, result.files[0].name);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (tokenList.isNotEmpty) {
      for (var i = 0; i < tokenList.length; i++) {
        final token = tokenList[i];
        token.cancel("exit page and cancel the request");
      }
    }
    super.dispose();
  }

  Widget _buildBtn() {
    return Container(
      width: widget.isVertical == true ? 114.w : 106.w,
      height: widget.isVertical == true ? 131.w : 106.w,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImagePath.community_add_image),
        ),
      ),
    ).onOpaqueTap(() {
      getPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: loading,
        builder: (context, value, child) {
          return Stack(
            children: [
              _buildBtn(),
              Positioned(
                  child: value
                      ? Container(
                          width: widget.isVertical == true ? 114.w : 106.w,
                          height: widget.isVertical == true ? 131.w : 106.w,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            borderRadius: Styles.borderRadius.m,
                          ),
                          child: Stack(
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: progress,
                                  builder: (context, value, child) {
                                    return value == '上传完成'
                                        ? const SizedBox.shrink()
                                        : Container(
                                            width: 85.w,
                                            height: 85.w,
                                            margin: EdgeInsets.all(15.w),
                                            child:
                                                const CircularProgressIndicator(
                                              strokeWidth: 3,
                                              backgroundColor: Colors.white,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.green),
                                            ),
                                          );
                                  }),
                              Center(
                                  child: ValueListenableBuilder(
                                      valueListenable: progress,
                                      builder: (context, value, child) {
                                        return Text(
                                          value == '上传完成' ? value : '$value%',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14.w,
                                              fontWeight: FontWeight.w600),
                                        );
                                      }))
                            ],
                          ),
                        )
                      : const SizedBox.shrink()),
            ],
          );
        });
  }
}
