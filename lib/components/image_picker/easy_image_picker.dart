/*
 * @Author: wangdazhuang
 * @Date: 2024-09-23 14:09:30
 * @LastEditTime: 2024-10-22 17:13:44
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/src/components/image_picker/easy_image_picker.dart
 */
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import 'easy_image_picker_file.dart';

final _defaultWebAllowedImageExtentsions = [
  'jpg',
  'png',
  'jpeg',
  'gif',
];
final _defaultVideoExtensions = ["mov", 'mp4'];

abstract class EasyImagePicker {
  ///选择视频
  static Future<EasyImagePickerFile?> _pickVideoFromGallery({
    List<String>? webAllowedExtentsions,
  }) async {
    const type = kIsWeb ? FileType.custom : FileType.video;
    // allowedExtensions 只支持 FileType.custom
    final allowedExtensions =
        kIsWeb ? (webAllowedExtentsions ?? _defaultVideoExtensions) : null;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: type,
      allowMultiple: false,
      allowedExtensions: allowedExtensions,
    );
    if (result == null) return null;
    final single = result.files.single;
    XFile? xfile;
    File? file;
    String path;
    if (kIsWeb) {
      xfile = single.xFile;
      path = single.xFile.path;
    } else {
      final p = single.path;
      if (p == null) return null;
      path = p;
      file = File(p);
    }

    return EasyImagePickerFile(
      name: single.name,
      path: path,
      xfile: xfile,
      file: file,
    );
  }

  static Future<EasyImagePickerFile?> _pickSingleImage({
    List<String>? webAllowedExtentsions,
  }) async {
    const type = kIsWeb ? FileType.custom : FileType.image;
    // allowedExtensions 只支持 FileType.custom
    final allowedExtensions = kIsWeb
        ? (webAllowedExtentsions ?? _defaultWebAllowedImageExtentsions)
        : null;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: type,
      allowMultiple: false,
      allowedExtensions: allowedExtensions,
    );
    if (result == null) return null;
    final single = result.files.single;
    XFile? xfile;
    File? file;
    String path;
    if (kIsWeb) {
      xfile = single.xFile;
      path = single.xFile.path;
    } else {
      final p = single.path;
      if (p == null) return null;
      path = p;
      file = File(p);
    }

    return EasyImagePickerFile(
      name: single.name,
      path: path,
      xfile: xfile,
      file: file,
    );
  }

  ///拍照
  static Future<EasyImagePickerFile?> pickSingleImageGrantCamera({
    List<String>? webAllowedExtentsions,
  }) async {
    await Permission.camera.request();
    var status = await Permission.camera.status;
    if (status.isGranted) {
      return pickSingleImageGrant(webAllowedExtentsions: webAllowedExtentsions);
    }
    return null;
  }

  // ///不限制任何格式
  // static Future<File?> pickAll() async {
  //   await Permission.camera.request();
  //   var status = await Permission.camera.status;
  //   if (status.isGranted) {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.any,
  //     );
  //     if (result != null) {
  //       return File(result.files.single.path!);
  //     }
  //   }
  //   return null;
  // }

  ///低系统获取授权
  static Future<EasyImagePickerFile?> pickSingleImageGrant({
    List<String>? webAllowedExtentsions,
  }) async {
    if (kIsWeb) {
      return _pickSingleImage(webAllowedExtentsions: webAllowedExtentsions);
    }
    var status = await Permission.photos.request();
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      return _pickSingleImage(webAllowedExtentsions: webAllowedExtentsions);
    }
    return null;
  }

  ///选取视频
  static Future<EasyImagePickerFile?> pickSingleVideoGrant({
    List<String>? webAllowedExtentsions,
  }) async {
    if (kIsWeb) {
      return _pickVideoFromGallery(
          webAllowedExtentsions: webAllowedExtentsions);
    }
    var status = await Permission.videos.request();
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      return _pickVideoFromGallery(
          webAllowedExtentsions: webAllowedExtentsions);
    }
    return null;
  }
}
