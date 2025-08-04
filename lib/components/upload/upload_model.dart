import 'dart:typed_data';

import 'upload_enum.dart';

class UploadModel {
  UploadType type;
  String path;
  UploadStatus status;
  double progress;
  Uint8List originBytes;
  Uint8List thumbnailImage;
  String fileSuffix;

  UploadModel({
    required this.type,
    required this.path,
    required this.status,
    required this.progress,
    required this.originBytes,
    required this.thumbnailImage,
    required this.fileSuffix,
  });

  forJson(Map<String, dynamic> json) {
    type = json['type'];
    path = json['path'];
    status = json['status'];
    progress = json['progress'];
    originBytes = json['originBytes'];
    thumbnailImage = json['thumbnailImage'];
    fileSuffix = json['fileSuffix'];
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'path': path,
      'status': status,
      'progress': progress,
      'originBytes': originBytes,
      'thumbnailImage': thumbnailImage,
      'fileSuffix': fileSuffix,
    };
  }
}
