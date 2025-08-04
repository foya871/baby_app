import 'package:baby_app/components/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PictureMessageView extends StatelessWidget {
  const PictureMessageView({
    super.key,
    required this.url,
    required this.isMe,
  });

  final String url;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return ImageView(
      src: url,
      borderRadius: BorderRadius.circular(10.w),
      width: 112.w,
      height: 112.w,
    );
  }
}
