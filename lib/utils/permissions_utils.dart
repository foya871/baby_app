import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PermissionsUtils {
  /// 请求相机权限
  static Future<bool> requestCameraPermission() async {
    if (kIsWeb) {
      // Web 平台：浏览器会在调用摄像头时自动请求权限
      return true;
    } else if (Platform.isAndroid || Platform.isIOS) {
      final status = await Permission.camera.request();
      return status.isGranted;
    } else {
      // macOS、Windows 等平台
      final status = await Permission.camera.request();
      return status.isGranted;
    }
  }

  /// 请求照片读取权限
  static Future<bool> requestPhotosPermission() async {
    if (kIsWeb) {
      // Web 平台：浏览器会在访问文件时自动请求权限
      return true;
    } else if (Platform.isAndroid) {
      if (await _isAndroid13OrAbove()) {
        final status = await Permission.photos.request();
        return status.isGranted;
      } else {
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    } else if (Platform.isIOS) {
      final status = await Permission.photos.request();
      return status.isGranted;
    } else {
      // macOS、Windows 等平台
      final status = await Permission.photos.request();
      return status.isGranted;
    }
  }

  /// 请求视频读取权限
  static Future<bool> requestVideosPermission() async {
    if (kIsWeb) {
      // Web 平台：浏览器会在访问文件时自动请求权限
      return true;
    } else if (Platform.isAndroid) {
      if (await _isAndroid13OrAbove()) {
        final status = await Permission.videos.request();
        return status.isGranted;
      } else {
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    } else if (Platform.isIOS) {
      final status = await Permission.videos.request();
      return status.isGranted;
    } else {
      // macOS、Windows 等平台
      final status = await Permission.videos.request();
      return status.isGranted;
    }
  }

  /// 请求照片和视频读取权限
  static Future<bool> requestPhotosAndVideosPermission() async {
    if (kIsWeb) {
      // Web 平台：浏览器会在访问文件时自动请求权限
      return true;
    } else if (Platform.isAndroid) {
      if (await _isAndroid13OrAbove()) {
        final statuses = await [
          Permission.photos,
          Permission.videos,
        ].request();
        return statuses[Permission.photos]!.isGranted &&
            statuses[Permission.videos]!.isGranted;
      } else {
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    } else if (Platform.isIOS) {
      final statuses = await [
        Permission.photos,
        Permission.videos,
      ].request();
      return statuses[Permission.photos]!.isGranted &&
          statuses[Permission.videos]!.isGranted;
    } else {
      // macOS、Windows 等平台
      final statuses = await [
        Permission.photos,
        Permission.videos,
      ].request();
      return statuses[Permission.photos]!.isGranted &&
          statuses[Permission.videos]!.isGranted;
    }
  }

  /// 请求文件保存权限
  static Future<bool> requestStoragePermission() async {
    if (kIsWeb) {
      // Web 平台：浏览器会在保存文件时自动请求权限
      return true;
    } else if (Platform.isAndroid) {
      if (await _isAndroid11OrAbove()) {
        final status = await Permission.manageExternalStorage.request();
        return status.isGranted;
      } else {
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    } else if (Platform.isIOS) {
      final status = await Permission.photos.request();
      return status.isGranted;
    } else {
      // macOS、Windows 等平台
      final status = await Permission.storage.request();
      return status.isGranted;
    }
  }

  /// 请求照片和视频保存权限
  static Future<bool> requestMediaSavePermission() async {
    final photosGranted = await requestPhotosPermission();
    final videosGranted = await requestVideosPermission();
    return photosGranted && videosGranted;
  }

  /// 检查是否为 Android 13 或更高版本
  static Future<bool> _isAndroid13OrAbove() async {
    if (Platform.isAndroid) {
      final sdkInt = await _getAndroidSdkInt();
      return sdkInt >= 33;
    }
    return false;
  }

  /// 检查是否为 Android 11 或更高版本
  static Future<bool> _isAndroid11OrAbove() async {
    if (Platform.isAndroid) {
      final sdkInt = await _getAndroidSdkInt();
      return sdkInt >= 30;
    }
    return false;
  }

  /// 获取 Android SDK 版本
  static Future<int> _getAndroidSdkInt() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt;
    } else {
      return 0;
    }
  }
}
