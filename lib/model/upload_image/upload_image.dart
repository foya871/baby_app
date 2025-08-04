/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-10-15 10:02:58
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-10-15 10:04:39
 * @FilePath: /baby_app/lib/src/model/upload_image/upload_image.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:json2dart_safe/json2dart.dart';

class UploadImageModel {
  String? path;
  String? status;

  UploadImageModel({
    this.path,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('path', this.path)
      ..put('status', this.status);
  }

  UploadImageModel.fromJson(Map<String, dynamic> json) {
    this.path = json.asString('path');
    this.status = json.asString('status');
  }

  static UploadImageModel toBean(Map<String, dynamic> json) =>
      UploadImageModel.fromJson(json);
}
