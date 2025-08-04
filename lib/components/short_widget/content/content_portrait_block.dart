import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../generate/app_image_path.dart';
import '../../../model/content_model.dart';
import '../../../utils/color.dart';
import '../../grid_view/heighted_grid_view.dart';
import 'content_circle_portrait_cell.dart';

class ContentPortraitBlock extends StatelessWidget {
  final List<PornographyModel> models;
  final String title;
  final EdgeInsets? titleRowPadding;
  const ContentPortraitBlock(this.models,
      {super.key, required this.title, this.titleRowPadding});

  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              color: COLOR.color_B940FF,
              height: 17.w,
              width: 4.w,
            ),
            6.horizontalSpace,
            Text(
              title,
              style: TextStyle(color: COLOR.primaryText, fontSize: 18.w),
            )
          ],
        ),
        Row(
          children: [
            Image.asset(
              AppImagePath.shi_pin_station_right_arrow,
              width: 13.w,
              height: 13.w,
            ),
            3.horizontalSpace,
            Text(
              '更多',
              style: TextStyle(color: COLOR.color_808080, fontSize: 12.w),
            )
          ],
        )
      ],
    ).onOpaqueTap(() => Get.toNamed(Routes.contentWh));
  }

  Widget _buildPortraits() => SizedBox(
        height: 198.w,
        child: HeightedGridView(
          scrollDirection: Axis.horizontal,
          crossAxisCount: 2,
          itemCount: models.length,
          itemBuilder: (ctx, i) => ContentCirclePortraitCell(models[i]),
          rowSepratorBuilder: (ctx, i) => 16.horizontalSpace,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitleRow().padding(titleRowPadding),
        14.verticalSpaceFromWidth,
        _buildPortraits(),
      ],
    );
  }
}
