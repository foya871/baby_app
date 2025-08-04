import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextMesasgeView extends StatelessWidget {
  const TextMesasgeView({
    super.key,
    required this.text,
    required this.isMe,
  });

  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 240.w,
        minHeight: 36.w,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
      decoration: BoxDecoration(
        color: isMe ? COLOR.color_009FE8 : Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: TextView(
        text: text,
      ),
    );
  }
}
