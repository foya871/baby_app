import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/content_model.dart';
import 'content_portrait_block.dart';
import 'content_profile_videos_cell.dart';

class ContentStationBaseCell extends StatelessWidget {
  final ContentActressStationModel model;

  const ContentStationBaseCell(this.model, {super.key});

  @override
  Widget build(BuildContext context) => switch (model.type) {
        ContentActressStationType.video => ContentProfileVideosCell(
            model.content!,
            profilePadding: EdgeInsets.only(right: 14.w),
          ),
        ContentActressStationType.portraitBlock => ContentPortraitBlock(
            model.portraitBlock!.portraitList,
            title: model.portraitBlock!.title,
            titleRowPadding: EdgeInsets.only(right: 14.w),
          ),
      };
}
