import 'package:baby_app/generate/app_image_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'image_view.dart';

class CircleImage extends StatelessWidget {
  // final ImageProvider image; //图片
  final String? assetName; // 资源
  final String? url; // 网络
  final Uint8List? imageBytes; // memory
  final BoxFit? fit;
  final double size; //大小
  final Color? borderColor; //边框颜色
  final double? borderSize;
  final Widget? child;
  final Alignment childAlignment;
  final VoidCallback? onTap;

  const CircleImage({
    super.key,
    this.assetName,
    this.url,
    this.imageBytes,
    this.size = 50,
    this.fit,
    this.borderColor,
    this.borderSize,
    this.child,
    this.childAlignment = Alignment.center,
    this.onTap,
  }) : assert(url != null || assetName != null || imageBytes != null,
            'must specify one of them');

  const CircleImage.asset(
    this.assetName, {
    super.key,
    this.size = 50,
    this.fit,
    this.borderColor,
    this.borderSize,
    this.child,
    this.childAlignment = Alignment.center,
    this.onTap,
  })  : assert(assetName != null, 'assetName must not bu null'),
        imageBytes = null,
        url = null;

  const CircleImage.memory(
    this.imageBytes, {
    super.key,
    this.size = 50,
    this.fit,
    this.borderColor,
    this.borderSize,
    this.child,
    this.childAlignment = Alignment.center,
    this.onTap,
  })  : assert(imageBytes != null, 'imageBytes must not bu null'),
        assetName = null,
        url = null;

  const CircleImage.network(
    this.url, {
    super.key,
    this.size = 50,
    this.fit,
    this.borderColor,
    this.borderSize,
    this.child,
    this.childAlignment = Alignment.center,
    this.onTap,
  })  : assert(url != null, 'url must not bu null'),
        imageBytes = null,
        assetName = null;

  Widget _buildImage(double size) {
    final f = fit ?? BoxFit.cover;
    if (url != null) {
      return ImageView(
        src: url!,
        width: size,
        height: size,
        fit: f,
        defaultPlace: AppImagePath.app_default_avatar,
      );
    } else if (assetName != null) {
      return Image.asset(assetName!, width: size, height: size, fit: f);
    } else if (imageBytes != null) {
      return Image.memory(imageBytes!, width: size, height: size, fit: f);
    } else {
      assert(false, 'no resouce specified');
      return SizedBox(width: size, height: size);
    }
  }

  bool get showBorder =>
      borderColor != null && borderSize != null && borderSize! > 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: showBorder
            ? Border.all(color: borderColor!, width: borderSize!)
            : null,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Stack(
          children: [
            _buildImage(size - (borderSize ?? 0)),
            if (child != null)
              Positioned.fill(
                child: Align(
                  alignment: childAlignment,
                  child: child,
                ),
              ),
          ],
        ),
      ),
    ).onTap(onTap);
  }
}
