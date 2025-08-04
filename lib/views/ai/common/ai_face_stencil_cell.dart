import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import '../../../components/image_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/ai/ai_models.dart';

///
/// 一个stencil
///

class AiFaceStencilCell extends StatelessWidget {
  static final veticalImageHeight = 211.w;
  static final horizontalImageHeight = 90.w;

  final AiStencilModel model;
  final double width;
  final double? imageHeight;
  final double hotLeftDistance;
  final double hotTopDistance;
  final VoidCallback? onTap;

  AiFaceStencilCell.horizontal(this.model, {super.key, this.onTap})
      : width = 174.w,
        imageHeight = horizontalImageHeight,
        hotLeftDistance = 5.w,
        hotTopDistance = 6.w;

  AiFaceStencilCell.vertical(this.model, {super.key, this.onTap})
      : width = 174.w,
        imageHeight = veticalImageHeight,
        hotLeftDistance = 5.w,
        hotTopDistance = 6.w;

  AiFaceStencilCell.auto(this.model, {super.key, this.onTap})
      : width = 174.w,
        imageHeight = null,
        hotLeftDistance = 5.w,
        hotTopDistance = 6.w;

  Widget _buildCover() => Stack(
        children: [
          ImageView(
            src: model.originalImg,
            width: width,
            height: imageHeight,
            borderRadius: Styles.borderRadius.all(8.w),
          ),
          if (model.isVideo)
            Positioned.fill(
              child: Center(
                child: Image.asset(
                  AppImagePath.ai_home_play,
                  width: 30.w,
                  height: 24.w,
                ),
              ),
            )
        ],
      );

  Widget _buildName() => Text(
        model.stencilName,
        maxLines: 1,
        style: TextStyle(
          fontSize: 13.w,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _buildImageStack() => Stack(
        children: [
          _buildCover(),
          if (model.hot)
            Positioned(
              top: 4.w,
              left: 5.w,
              child: Image.asset(
                AppImagePath.ai_home_stencil_hot,
                width: 28.w,
                height: 16.w,
              ),
            )
        ],
      );

  // 使用配方
  // Widget _buildRecipeBtn() => Container(
  //       decoration: BoxDecoration(
  //         color: COLOR.color_f3f5f8,
  //         borderRadius: Styles.borderRadius.all(13.w),
  //       ),
  //       width: double.infinity,
  //       height: 26.w,
  //       alignment: Alignment.center,
  //       child: Text(
  //         '使用配方',
  //         style: TextStyle(color: COLOR.black, fontSize: 13.w),
  //       ),
  //     );

  Widget _buildBody() => SizedBox(
        width: width,
        child: Column(
          spacing: 8.w,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImageStack(),
            _buildName().bottomLeft,
            // _buildRecipeBtn(),
          ],
        ),
      ).onOpaqueTap(onTap);

  @override
  Widget build(BuildContext context) => _buildBody();
}
