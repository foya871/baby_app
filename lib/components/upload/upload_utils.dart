import 'dart:developer';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http_service/http_service.dart';
import 'package:tuple/tuple.dart';
import 'package:baby_app/components/diolog/loading/loading_view.dart';

import 'upload_enum.dart';
import 'upload_model.dart';

class UploadUtils {
  UploadUtils._();

  /// 维护任务取消的 `CancelToken`
  static final Map<String, CancelToken> _uploadTasks = {};

  /// 生成唯一任务ID
  static String generateTaskId(Uint8List bytes) {
    return md5.convert(bytes).toString();
  }

  /// 取消上传任务
  static void cancelUpload(String taskId) {
    if (_uploadTasks.containsKey(taskId) &&
        !_uploadTasks[taskId]!.isCancelled) {
      _uploadTasks[taskId]?.cancel("Upload canceled");
    }
    _uploadTasks.remove(taskId);
  }

  /// 上传图片
  static Future<UploadModel?> uploadImage(
      UploadModel model, Function(double) onProgress) async {
    UploadModel uploadModel = model;

    String taskId = generateTaskId(model.originBytes);
    CancelToken cancelToken = CancelToken();
    _uploadTasks[taskId] = cancelToken;

    try {
      uploadModel.status = UploadStatus.uploading;
      final response = await httpInstance.uploadImageNew(
        bytes: model.originBytes,
        fileSuffix: model.fileSuffix,
        progress: (int count, int total) {
          onProgress(count / total);
        },
        token: cancelToken,
      );

      if (response != null) {
        uploadModel.path = response.fileName!;
        uploadModel.status = UploadStatus.success;
      } else {
        uploadModel.status = UploadStatus.error;
      }
    } catch (e, stacktrace) {
      uploadModel.status = UploadStatus.error;
      log("Image upload error: $e", stackTrace: stacktrace);
    } finally {
      _uploadTasks.remove(taskId);
    }

    return uploadModel;
  }

  /// 上传视频
  /// 返回视频ID、视频URL、视频标题、视频时长、任务ID
  static Future<Tuple5<String, String, String, String, String>?> uploadVideo({
    required Uint8List bytes,
    required String title,
    required int duration,
    int maxConcurrentUploads = 3,
    Function(double)? onProgress,
  }) async {
    String taskId = generateTaskId(bytes);
    int chunkSize = 1 * 1024 * 1024;
    int chunkNum = (bytes.length / chunkSize).ceil();
    int count = 0;
    int finished = 0;
    String videoId = "";
    String url = "";

    double totalProgress = 0.0;
    double perChunkProgress = 1.0 / chunkNum;

    List<int> chunks = List.generate(chunkNum, (idx) => idx);
    CancelToken token = CancelToken();
    _uploadTasks[taskId] = token;

    try {
      for (var pos in chunks) {
        while (count >= maxConcurrentUploads) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
        count++;

        Uint8List fileChunk = (pos == chunks.length - 1)
            ? bytes.sublist(pos * chunkSize)
            : bytes.sublist(pos * chunkSize, (pos + 1) * chunkSize);

        _startUploadVideo(taskId, fileChunk, pos, token, (progress) {
          totalProgress =
              finished * perChunkProgress + (progress * perChunkProgress);
          onProgress?.call(totalProgress);
        }).then((resp) {
          if (resp != null) {
            videoId = resp['id'];
            url = resp['videoUri'];
          }
          finished++;
          onProgress?.call(finished / chunkNum);
        }).catchError((e) {
          log("Chunk upload error: $e");
        }).whenComplete(() => count--);
      }

      if (finished == chunkNum) {
        await httpInstance.post(url: "upload/videoOk", isFile: true, body: {
          "checkSum": taskId,
          "id": videoId,
          "title": title,
          "type": 1,
        });
      } else {
        log("Upload failed: Not all chunks uploaded.");
      }
    } catch (e, stacktrace) {
      log("Video upload error: $e", stackTrace: stacktrace);
    } finally {
      _uploadTasks.remove(taskId);
    }

    return Tuple5(videoId, url, title, '$duration', taskId);
  }

  /// 分片上传视频
  static Future<Map<String, dynamic>?> _startUploadVideo(
      String taskId,
      Uint8List bytes,
      int pos,
      CancelToken token,
      Function(double) onProgress) async {
    try {
      return await httpInstance.multiPartFormPost(
        url: "upload/video",
        isVideo: true,
        file: bytes,
        token: token,
        body: {
          "pos": pos,
          "taskId": taskId,
        },
        progress: (count, total) {
          onProgress(count / total);
        },
      );
    } catch (e) {
      log("Video chunk upload error: $e");
      return null;
    }
  }
}
