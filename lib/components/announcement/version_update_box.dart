import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../assets/styles.dart';
import '../../model/announcement/app_update.dart';
import '../../utils/ad_jump.dart';
import '../../utils/color.dart';
import '../../utils/context_link.dart';
import '../easy_button.dart';
import '../text_view.dart';

class VersionUpdateBox extends StatelessWidget {
  final AppUpdateModel model;
  final VoidCallback? dismiss;
  final String? androidApkURL;
  const VersionUpdateBox({
    super.key,
    required this.model,
    this.dismiss,
    this.androidApkURL,
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
            text: "版本升级",
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
                      " ${model.info}",
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
                if (model.isForceUpdate == false)
                  EasyButton(
                    '取消',
                    backgroundColor: COLOR.transparent,
                    width: 120.w,
                    height: 37.w,
                    borderColor: COLOR.color_08b4fd,
                    borderWidth: 1.0,
                    borderRadius: BorderRadius.circular(18.5.w),
                    textStyle: kTextStyle(COLOR.color_08b4fd,
                        fontsize: 15.w, weight: FontWeight.bold),
                    onTap: () => dismiss?.call(),
                  ),
                EasyButton(
                  '立即体验',
                  backgroundColor: COLOR.color_08b4fd,
                  width: model.isForceUpdate == false ? 120.w : 252.w,
                  height: 37.w,
                  borderRadius: BorderRadius.circular(18.5.w),
                  textStyle: kTextStyle(Colors.white,
                      fontsize: 15.w, weight: FontWeight.bold),
                  onTap: () {
                    if (androidApkURL != null) {
                      ///
                      jumpExternalURL(androidApkURL!);
                    } else {
                      ///
                      jumpExternalURL(model.link ?? '');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
