import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../components/short_widget/search_entry_cell.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/extension.dart';

class ShiPinSearchCell extends StatelessWidget {
  final EdgeInsets? margin;
  const ShiPinSearchCell({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 327.w,
            child: const SearchEntryCell(searchType: 1),
          ),
          Image.asset(
            AppImagePath.shi_pin_video_box_entry,
            width: 24.w,
            height: 24.w,
          ).onTap(() => Get.toNamed(Routes.videoBox)),
        ],
      ),
    );
  }
}
