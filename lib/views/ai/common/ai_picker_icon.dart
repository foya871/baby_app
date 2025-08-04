import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/image_picker/easy_image_picker.dart';
import '../../../components/image_picker/easy_image_picker_file.dart';
import '../../../generate/app_image_path.dart';
import '../../../utils/color.dart';

/// 上传按钮

class AiPickerIcon extends StatelessWidget {
  final double? width;

  final ValueCallback<EasyImagePickerFile?>? onTap;
  final bool example;
  final bool expand;

  const AiPickerIcon({super.key, this.width, this.onTap, this.expand = true})
      : example = false;

  const AiPickerIcon.example(
      {super.key, this.width, this.onTap, this.expand = true})
      : example = true;

  void _onTap() async {
    final file = await EasyImagePicker.pickSingleImageGrant();
    onTap?.call(file);
  }

  @override
  Widget build(BuildContext context) {
    if (!example) {
      final w = width ?? 24.w;
      final h = width ?? 24.w;
      return Container(
        width: expand ? double.infinity : null,
        height: expand ? double.infinity : null,
        alignment: Alignment.center,
        child: Image.asset(
          AppImagePath.ai_home_upload_image,
          width: w,
          height: h,
        ),
      ).onOpaqueTap(_onTap);
    } else {
      return Container(
        height: expand ? double.infinity : null,
        width: expand ? double.infinity : null,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '示例图',
              style: TextStyle(
                fontSize: 13.w,
                fontWeight: FontWeight.w600,
                color: COLOR.color_999999,
              ),
            ),
            SizedBox(height: 6.w),
            Image.asset(
              AppImagePath.ai_face_example,
              width: 72.w,
              height: 72.w,
            ),
            SizedBox(height: 6.w),
            Text(
              '点此上传',
              style: TextStyle(
                fontSize: 13.w,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ).onOpaqueTap(_onTap);
    }
  }
}
