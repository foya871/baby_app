/*
 * @Author: wangdazhuang
 * @Date: 2024-08-08 20:57:43
 * @LastEditTime: 2025-03-08 16:20:02
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/components/image_view.dart
 */

import 'dart:async';
import 'dart:convert';

import 'package:baby_app/generate/app_image_path.dart';
import 'package:cached_network_image/cached_network_image.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:dio/dio.dart';
// import 'package:baby_app/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart' as p;
// ignore: depend_on_referenced_packages
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:baby_app/model/axis_cover.dart';
import 'package:baby_app/services/storage_service.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

const _key = 'customCacheKey';

final _defaultCustomCacheManager = CacheManager(
  Config(
    _key,
    stalePeriod: const Duration(days: 30),
    maxNrOfCacheObjects: 100,
    repo: GetPlatform.isWeb
        ? NonStoringObjectProvider()
        : JsonCacheInfoRepository(databaseName: _key),
    // fileSystem: GetPlatform.isWeb ? MemoryCacheSystem() : IOFileSystem(_key),
    fileService: EncryptHttpFileService(),
  ),
);

// void _defaultErrorListener(String url, Object err) =>
//     logger.d('Image Load fail,url:$url,err:$err');
final localStore = Get.find<StorageService>();
var domain = localStore.imgDomain ?? '';

///生成图片路径(url, cacheKey)
(String, String) _imageSrc(String src, [int? clipW]) {
  bool hasHeader = src.startsWith("http");
  if (hasHeader) return (src, src);
  if (domain.endsWith("/") == false) {
    domain = '$domain/';
  }
  final isGif = src.contains(".gif") || src.contains('.webp');
  //默认480
  final clip = isGif
      ? ''
      : clipW == null
          ? ''
          : '_$clipW';
  return ('$domain$src$clip', '$src$clip');
}

class ImageView extends StatefulWidget {
  final String src;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final String? defaultPlace;
  final double? minHeight;
  final bool? vertical;

  ///裁剪参数 一般是 320  ｜ 480
  final int? clipWidth;

  const ImageView({
    super.key,
    required this.src,
    this.height,
    this.width,
    this.minHeight,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.defaultPlace,
    this.clipWidth,
    bool? vertical, // //和axis 不同时传入
    CoverImgAxis? axis, // 和vertical 不同时传入
  }) : vertical =
            axis != null ? axis == CoverImgAxis.vertical : (vertical ?? false);

  static Widget shortVideoMudleBuilder(
    String url, {
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    BorderRadius? borderRadius,
  }) =>
      ImageView(
        src: url,
        width: width,
        height: height,
        fit: fit,
        borderRadius: borderRadius,
      );

  @override
  createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  ///默认图
  Widget placeDefaultImage() {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: Image.asset(
        widget.defaultPlace ??
            (widget.vertical == true
                ? AppImagePath.app_default_placeholder_v
                : AppImagePath.app_default_placeholder),
        width: widget.width,
        height: widget.height,
        fit: widget.fit ?? BoxFit.fill,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.src.isEmpty) {
      return placeDefaultImage();
    }

    //本地图片
    if (widget.src.startsWith("assets")) {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: Image.asset(
          widget.src,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
        ),
      );
    }
    final src = _imageSrc(widget.src, widget.clipWidth);

    final image = CachedNetworkImage(
      fit: widget.fit ?? BoxFit.fill,
      width: widget.width,
      height: widget.height,
      imageUrl: src.$1,
      cacheKey: src.$2,
      fadeInDuration:
          kIsWeb ? Duration.zero : const Duration(milliseconds: 500),
      fadeOutDuration:
          kIsWeb ? Duration.zero : const Duration(milliseconds: 1000),
      imageRenderMethodForWeb: kIsWeb
          ? ImageRenderMethodForWeb.HttpGet
          : ImageRenderMethodForWeb.HtmlImage,
      cacheManager: _defaultCustomCacheManager,
      placeholder: (context, url) {
        return placeDefaultImage();
      },
      errorWidget: (context, url, error) {
        return placeDefaultImage();
      },
    );
    if (widget.borderRadius != null) {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: image,
      );
    }
    return Container(
      constraints: BoxConstraints(minHeight: widget.minHeight ?? 0),
      child: image,
    );
  }
}

class CustomImageViewProvider extends CachedNetworkImageProvider {
  CustomImageViewProvider(
    String src, {
    super.maxHeight,
    super.maxWidth,
    super.scale,
  }) : super(
          _imageSrc(src).$1,
          cacheKey: _imageSrc(src).$2,
          cacheManager: _defaultCustomCacheManager,
          imageRenderMethodForWeb: kIsWeb
              ? ImageRenderMethodForWeb.HttpGet
              : ImageRenderMethodForWeb.HtmlImage,
        );
}
