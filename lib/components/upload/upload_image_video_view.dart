import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tuple/tuple.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import 'upload_enum.dart';
import 'upload_model.dart';
import 'upload_utils.dart';

/// 上传图片或者视频组件
class UploadImageVideoView extends StatefulWidget {
  final UploadType type;
  final double width, height, radius; // 宽度、高度、圆角
  final int maxLength; // 最大上传数量
  final double spacing; // 图片间距
  final String defaultAddImage; // 默认添加图片
  final String defaultDeleteImage; // 默认删除图片
  final double deleteImageSize; // 删除图片大小
  final Tuple4<double?, double?, double?, double?>
      deleteImagePositioned; // 删除图片位置
  final BoxFit fit; // 图片填充方式
  final List<String> imageFormat; // 图片格式
  final List<String> videoFormat; // 视频格式
  final bool isUploadImmediately; //是否立即上传
  final Function(UploadType type, List<String> images,
          List<Tuple5<String, String, String, String, String>> video)?
      onSuccessCallback;
  final Function(UploadType type, List<Uint8List> images,
      List<Tuple2<Uint8List, File?>> video)? onCheckCallback;

  const UploadImageVideoView({
    super.key,
    this.type = UploadType.common,
    this.width = 110,
    this.height = 110,
    this.radius = 8,
    this.maxLength = 9,
    this.spacing = 5,
    this.defaultAddImage = AppImagePath.app_default_upload_add,
    this.defaultDeleteImage = AppImagePath.app_default_upload_delete,
    this.deleteImageSize = 20,
    this.deleteImagePositioned = const Tuple4(null, null, null, null),
    this.fit = BoxFit.cover,
    this.imageFormat = const [],
    this.videoFormat = const [],
    this.isUploadImmediately = true,
    this.onSuccessCallback,
    this.onCheckCallback,
  });

  @override
  State<UploadImageVideoView> createState() => _UploadImageVideoViewState();
}

class _UploadImageVideoViewState extends State<UploadImageVideoView> {
  ValueNotifier<List<UploadModel>> uploads = ValueNotifier([]);
  var _uploadType = RequestType.common;
  List<String> successImages = [];
  List<Tuple5<String, String, String, String, String>> successVideos = [];
  List<Uint8List> checkImages = [];
  List<Tuple2<Uint8List, File?>> checkVideos = [];

  @override
  void initState() {
    initUploadType();
    super.initState();
  }

  initUploadType() {
    if (widget.type == UploadType.common) {
      _uploadType = RequestType.common;
    }
    if (widget.type == UploadType.image) {
      _uploadType = RequestType.image;
    }
    if (widget.type == UploadType.video) {
      _uploadType = RequestType.video;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<UploadModel>>(
      valueListenable: uploads,
      builder: (context, list, child) {
        if (widget.maxLength == 1) {
          /// 显示上传的图片
          return list.isNotEmpty
              ? _buildImageItemView(list.first)
              : _buildAddButtonView(); // 显示添加按钮
        }

        // 多张图片时使用 Wrap
        return Wrap(
          spacing: widget.spacing,
          runSpacing: widget.spacing,
          children: [
            ...list.map((image) => _buildImageItemView(image)),
            if (list.length < widget.maxLength) _buildAddButtonView(),
          ],
        );
      },
    );
  }

  /// 构建添加图片按钮
  Widget _buildAddButtonView() {
    return ImageView(
      src: widget.defaultAddImage,
      width: widget.width,
      height: widget.height,
      borderRadius: BorderRadius.circular(widget.radius),
      fit: BoxFit.fill,
    ).onOpaqueTap(_pickImageVideo);
  }

  Widget _buildImageItemView(UploadModel model) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.radius),
                child: Image.memory(
                  model.thumbnailImage,
                  width: widget.width,
                  height: widget.height,
                  fit: widget.fit,
                )),
          ),

          //正在上传，显示进度和进度数值
          if (model.status == UploadStatus.uploading && model.progress < 1)
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: widget.height / 2,
                    height: widget.height / 2,
                    child: CircularProgressIndicator(
                      value: model.progress,
                      strokeWidth: 3,
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                  Text(
                    "${(model.progress * 100).toInt()}%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

          //上传失败，显示重试按钮
          if (model.status == UploadStatus.error)
            Center(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () => _uploadImage(model),
                    icon: Icon(Icons.refresh,
                        color: Colors.white, size: widget.height / 3),
                  ),
                  const Text("点击重试", style: TextStyle(color: Colors.redAccent)),
                ],
              ),
            ),

          // 删除按钮
          Positioned(
            top: widget.deleteImagePositioned.item1 ??
                widget.deleteImageSize / 3,
            left: widget.deleteImagePositioned.item2,
            right: widget.deleteImagePositioned.item3 ??
                widget.deleteImageSize / 3,
            bottom: widget.deleteImagePositioned.item4,
            child: ImageView(
              src: widget.defaultDeleteImage,
              width: widget.deleteImageSize,
              height: widget.deleteImageSize,
            ).onOpaqueTap(() => removeImageOrVideo(model)),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageVideo() async {
    if (await Permission.photos.isDenied) {
      await Permission.photos.request();
    }
    List<AssetEntity>? assets = await AssetPicker.pickAssets(
      Get.context!,
      pickerConfig: AssetPickerConfig(
        maxAssets: widget.maxLength - uploads.value.length,
        requestType: _uploadType,
      ),
    );
    if (assets == null || assets.isEmpty) return;

    for (var asset in assets) {
      Uint8List? originBytes = await asset.originBytes;
      Uint8List? thumbnailImage = await asset.thumbnailData;
      if (originBytes == null) return;
      if (thumbnailImage == null) return;
      final type =
          asset.type == AssetType.image ? UploadType.image : UploadType.video;
      var suffix = await asset.mimeTypeAsync;
      suffix = suffix?.split("/").last;
      UploadModel model = UploadModel(
        type: type,
        path: "",
        status: UploadStatus.queuing,
        progress: 0,
        originBytes: originBytes,
        thumbnailImage: thumbnailImage,
        fileSuffix: suffix ?? '',
      );
      if (asset.type == AssetType.image) {
        if (widget.imageFormat.isNotEmpty) {
          if (!widget.imageFormat.contains(suffix)) {
            showToast("图片格式仅支持：${widget.imageFormat.join('、')}");
            continue;
          }
        }
        _uploadImage(model);
      } else {
        if (widget.videoFormat.isNotEmpty) {
          if (!widget.videoFormat.contains(suffix)) {
            showToast("视频格式仅支持：${widget.videoFormat.join('、')}");
            continue;
          }
        }
        _uploadVideo(model, asset);
      }
    }
  }

  ///上传图片
  void _uploadImage(UploadModel uploadModel) async {
    uploads.value = [...uploads.value, uploadModel];
    checkImages.add(uploadModel.originBytes);
    widget.onCheckCallback?.call(widget.type, checkImages, checkVideos);
    if (!widget.isUploadImmediately) {
      return;
    }
    UploadUtils.uploadImage(uploadModel, (progress) {
      uploadModel.status = UploadStatus.uploading;
      uploadModel.progress = progress;
      setState(() {});
    }).then((result) {
      if (result != null) {
        uploadModel.path = result.path;
        uploadModel.status = UploadStatus.success;
        successImages.add(result.path);
      } else {
        uploadModel.status = UploadStatus.error;
      }
      setState(() {});
      widget.onSuccessCallback?.call(widget.type, successImages, successVideos);
    });
  }

  ///上传视频
  void _uploadVideo(UploadModel uploadModel, AssetEntity asset) async {
    uploads.value = [...uploads.value, uploadModel];
    checkVideos.add(Tuple2(uploadModel.originBytes, await asset.originFile));
    widget.onCheckCallback?.call(widget.type, checkImages, checkVideos);
    if (!widget.isUploadImmediately) {
      return;
    }
    UploadUtils.uploadVideo(
      bytes: uploadModel.originBytes,
      title: asset.title ?? "",
      duration: asset.duration,
      onProgress: (progress) {
        uploadModel.status = UploadStatus.uploading;
        uploadModel.progress = progress;
        setState(() {});
      },
    ).then((result) {
      if (result != null) {
        uploadModel.status = UploadStatus.success;
        successVideos.add(result);
      } else {
        uploadModel.status = UploadStatus.error;
      }
      setState(() {});
      widget.onSuccessCallback?.call(widget.type, successImages, successVideos);
    });
  }

  ///移除图片或者视频
  void removeImageOrVideo(UploadModel model) {
    UploadModel uploadModel = model;

    if (uploadModel.status == UploadStatus.uploading) {
      final taskId = UploadUtils.generateTaskId(uploadModel.originBytes);
      UploadUtils.cancelUpload(taskId);
      uploadModel.status = UploadStatus.error;
    } else if (uploadModel.status == UploadStatus.success) {
      if (uploadModel.type == UploadType.image) {
        successImages.remove(uploadModel.path);
      } else {
        successVideos.removeWhere((video) => video.item1 == uploadModel.path);
      }
    }

    // 从 `checkImages` 或 `checkVideos` 中移除
    if (uploadModel.type == UploadType.image) {
      checkImages.remove(uploadModel.originBytes);
    } else {
      checkVideos.remove(uploadModel.originBytes);
    }

    // 从上传列表中移除
    uploads.value.remove(uploadModel);

    // 触发 UI 更新
    uploads.value = [...uploads.value];

    // 触发 `onCheckCallback` 以通知外部
    widget.onCheckCallback?.call(widget.type, checkImages, checkVideos);

    // 触发 `onSuccessCallback`
    widget.onSuccessCallback?.call(widget.type, successImages, successVideos);
  }

  @override
  dispose() {
    /// 取消所有正在进行的上传任务
    for (var uploadModel in uploads.value) {
      if (uploadModel.status == UploadStatus.uploading) {
        final taskId = UploadUtils.generateTaskId(uploadModel.originBytes);
        UploadUtils.cancelUpload(taskId);
      }
    }

    /// 清空上传列表，释放资源
    uploads.value.clear();
    uploads.dispose();
    super.dispose();
  }
}
