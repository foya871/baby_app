/*
 * @Author: wangdazhuang
 * @Date: 2024-09-07 10:18:13
 * @LastEditTime: 2024-09-07 11:28:50
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/src/utils/file_downloader.dart
 */

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:baby_app/services/storage_service.dart';
import 'package:baby_app/utils/logger.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:path/path.dart' as p;

enum FileDownloaderResult { success, fail, broswer }

///authored by dzw
class FileDownloader {
  FileDownloader._internal();

  static final FileDownloader _singleton = FileDownloader._internal();

  factory FileDownloader() => _singleton;

  /// 文件媒体下载 注意 这里不支持m3u8文件哈
  Future<FileDownloaderResult> downloadMediaFile(String url,
      {ProgressCallback? onProgress, bool? onProgressInitial}) async {
    assert(url.isNotEmpty, ' download failed : url empty!');
    assert(url.contains(".m3u8") == false, ' m3u8 url file not supported!');
    if (GetPlatform.isWeb) {
      //web下载要区分一哈呢 progress进度回掉只对native客户端生效
      html.AnchorElement anchorElement = html.AnchorElement(href: url);
      anchorElement.download = url;
      anchorElement.click();
      return FileDownloaderResult.broswer;
    } else {
      // 原生下载暂时保存l
      try {
        if (onProgressInitial == true) {
          onProgress?.call(0, -1);
        }
        final path = await fileSavePathForNative(url);
        logger.d('downloadMediaFile start $url');
        await Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 15),
        )).download(
          url,
          path,
          onReceiveProgress: onProgress,
          options: Options(responseType: ResponseType.bytes),
        );
        return FileDownloaderResult.success;
      } on DioException catch (e) {
        logger.d('downloadMediaFile failed $url>>> ${e.toString()}');
        return FileDownloaderResult.fail;
      }
    }
  }

  ///文件名
  String filename(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      final u = url.split("/").last;
      if (u.isNotEmpty) {
        return u;
      }
      return url.replaceAll('/', '-');
    } else {
      final u = uri.pathSegments.lastOrNull;
      if (u?.isNotEmpty == true) {
        return u!;
      }
      return uri.path.replaceAll('/', '-');
    }
  }

  //文件保存路径
  Future<String> fileSavePathForNative(String url) async {
    final temp = await getTemporaryDirectory();
    final path = "${temp.path}/${filename(url)}";
    return path;
  }

  /// 文件保存到相册里中去 只针对原生哈 web只要发起下载即可自己保存
  Future<bool> nativaSaveMediaFile2Photogallery(String url) async {
    //保存到系统原生相册里去
    final filepath = await filedownloader.fileSavePathForNative(url);
    final filename = filedownloader.filename(url);
    final ext = p.extension(filename).toLowerCase();
    //图片文件保存
    if (['.jpg', '.jpeg', '.png', '.gif'].contains(ext)) {
      // 解密处理哈
      final file = File(filepath);
      final imagebytes = file.readAsBytesSync();
      final kkkkkk = utf8.encode("2020-zq3-888");
      Uint8List bytes = imagebytes;
      for (int i = 0; i < 100; i++) {
        bytes[i] ^= kkkkkk[i % kkkkkk.length];
      }
      final result =
          await ImageGallerySaverPlus.saveImage(bytes, name: filename);
      return result["isSuccess"];
    }
    //mp4文件
    final result =
        await ImageGallerySaverPlus.saveFile(filepath, name: filename);
    return result["isSuccess"];
  }

  Future<FileDownloaderResult> downloadMediaToGallery(
    String address, {
    ProgressCallback? onProgress,
    bool onProgressInitial = true,
  }) async {
    String url = address;
    if (!address.startsWith('http')) {
      final domain = Get.find<StorageService>().imgDomain ?? '';
      url = domain + address;
    }
    final result = await downloadMediaFile(
      url,
      onProgress: onProgress,
      onProgressInitial: onProgressInitial,
    );
    if (GetPlatform.isWeb) return result;
    if (result == FileDownloaderResult.fail) return result;
    try {
      final ok = await filedownloader.nativaSaveMediaFile2Photogallery(url);
      return ok ? FileDownloaderResult.success : FileDownloaderResult.fail;
    } catch (e) {
      return FileDownloaderResult.fail;
    }
  }
}

final filedownloader = FileDownloader();
