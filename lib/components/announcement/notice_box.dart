import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../assets/styles.dart';
import '../../model/announcement/announcement.dart';
import '../../utils/color.dart';
import '../../utils/context_link.dart';
import '../easy_button.dart';
import '../text_view.dart';

class NoticeBox extends StatelessWidget {
  final AnnouncementModel model;
  final VoidCallback? dismiss;
  const NoticeBox({
    super.key,
    required this.model,
    this.dismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285.w,
      height: 370.w,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextView(
            text: "系统公告",
            color: Colors.white,
            fontSize: 18.w,
            fontWeight: FontWeight.bold,
          ),
          15.verticalSpaceFromWidth,
          Expanded(
            child: SingleChildScrollView(
              child: Text.rich(
                  TextSpan(
                    children: contextLink(
                      " ${model.content ?? ''}",
                      TextStyle(color: COLOR.color_08b4fd, fontSize: 14.w),
                    ),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 13.w)),
            ),
          ),
          10.w.verticalSpaceFromWidth,
          SizedBox(
            width: 252.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EasyButton(
                  '知道了',
                  backgroundColor: COLOR.themeSelectedColor,
                  width: 252.w,
                  height: 37.w,
                  borderWidth: 1.0,
                  borderRadius: BorderRadius.circular(18.5.w),
                  textStyle: kTextStyle(COLOR.white,
                      fontsize: 15.w, weight: FontWeight.bold),
                  onTap: () => dismiss?.call(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
