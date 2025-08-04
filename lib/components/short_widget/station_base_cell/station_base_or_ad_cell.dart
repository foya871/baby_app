import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/station_model.dart';
import '../../../utils/ad_utils.dart';
import '../../ad_banner/insert_ad.dart';
import 'station_base_cell.dart';

class StationOrInsertAdCell extends StatelessWidget {
  final StationOrAdPlaceHolderModel model;
  final EdgeInsets? padding;
  final bool? bodyNoPadding;
  const StationOrInsertAdCell(
    this.model, {
    super.key,
    this.padding,
    this.bodyNoPadding,
  });

  @override
  Widget build(BuildContext context) {
    if (model is StationModel) {
      return StationBaseCell(model);
    } else if (model is InsertAdPlaceHolderModel) {
      return Container(
        padding: padding ?? EdgeInsets.zero,
        // child: InsertAd.fromPlaceholder(model, height: 74.w),
      );
    } else {
      assert(false, 'StationOrInsertAdCell bad mode $model');
      return const SizedBox.shrink();
    }
  }
}
