import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/station_model.dart';
import '../../../routes/routes.dart';
import '../../../utils/color.dart';
import '../../../utils/enum.dart';
import '../../../utils/extension.dart';
import '../../easy_button.dart';
import '../video_base_cell.dart';
import 'station_base_cell_controller.dart';

class StationBaseCell extends GetWidget<StationBaseCellController> {
  final StationModel station;

  const StationBaseCell(this.station, {super.key});

  Widget _buildTitle() => Row(
        children: [
          Container(
            width: 4.w,
            height: 17.w,
            color: COLOR.color_B940FF,
          ),
          6.horizontalSpace,
          Text(
            controller.station.stationName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.w,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      );

  Widget _buildRightArrow() {
    return Row(
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
        ),
      ],
    );
  }

  Widget _buildTitleRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTitle(),
          _buildRightArrow(),
        ],
      ).onOpaqueTap(() => Get.toStationDetail(controller.station));

  Widget _buildVideoList() => Obx(
        () {
          final children = <Widget>[];
          final stationType = controller.station.type;
          final videos = [...controller.dataKeeper.data]; // 有的要删除，这里复制一份
          if (stationType == StationTypeEnum.h2WithHead ||
              stationType == StationTypeEnum.h2 ||
              stationType == StationTypeEnum.h2_3 ||
              StationTypeEnum.isRank(stationType)) {
            if (stationType == StationTypeEnum.h2WithHead) {
              final first = videos.firstOrNull;
              if (first != null) {
                children.add(
                    VideoBaseCell.big(video: first.video, showShare: true));
                videos.removeAt(0);
              }
            }
            bool isRank = controller.station.isRank;
            final slices = videos.slices(2).toList();
            for (final slice in slices) {
              children.add(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: slice
                      .map(
                        (e) => VideoBaseCell.small(
                          video: e.video,
                          rank: isRank ? e.rank : null,
                        ),
                      )
                      .toList(),
                ),
              );
            }
          } else if (stationType == StationTypeEnum.v3) {
            final slices = videos.slices(3).toList();
            for (final slice in slices) {
              children.add(
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: slice
                      .map((e) => VideoBaseCell.smallVertical(video: e.video))
                      .toList()
                      .joinWidth(7.w),
                ),
              );
            }
          } else if (stationType == StationTypeEnum.v2) {
            final slices = videos.slices(2).toList();
            for (final slice in slices) {
              children.add(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: slice
                      .map((e) => VideoBaseCell.bigVertical(video: e.video))
                      .toList(),
                ),
              );
            }
          }

          return Column(children: children.joinHeight(10.w));
        },
      );

  Widget _buildButtons() {
    final _ = controller;
    final buttonWidth = 148.w;
    final buttonBorderRadius = Styles.borderRaidus.all(20.5.w);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EasyButton.child(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppImagePath.app_default_play_circle,
                  width: 19.w, height: 19.w),
              SizedBox(width: 11.w),
              Text(
                '查看更多',
                style: TextStyle(
                  color: COLOR.white,
                  fontSize: 14.w,
                ),
              ),
            ],
          ),
          width: buttonWidth,
          height: 38.w,
          backgroundColor: COLOR.color_393939,
          borderRadius: buttonBorderRadius,
          onTap: _.onTapMore,
        ),
        EasyButton.child(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppImagePath.app_default_change,
                  width: 19.w, height: 19.w),
              11.horizontalSpace,
              Text(
                '换一换',
                style: TextStyle(
                  color: COLOR.color_999999,
                  fontSize: 14.w,
                ),
              ),
            ],
          ),
          width: buttonWidth,
          height: 38.w,
          borderColor: Styles.color.greyWhiteText,
          borderRadius: buttonBorderRadius,
          onTap: _.onTapChange,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.init(station);
    return Column(
      children: [
        _buildTitleRow(),
        16.verticalSpaceFromWidth,
        _buildVideoList(),
        if (station.showMoreAndChangeRow) ...[
          20.verticalSpaceFromWidth,
          _buildButtons().marginHorizontal(17.w),
        ]
      ],
    );
  }
}
