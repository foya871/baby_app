import 'package:flutter/material.dart';

import '../../model/video_base_model.dart';
import '../../utils/ad_utils.dart';
import '../ad_banner/insert_ad.dart';
import 'video_base_cell.dart';

enum _Mode { small, smallVertical, big, bigVertical }

class VideoBaseOrAdCell extends StatelessWidget {
  final VideoBaseOrAdPlaceHolderModel model;
  final _Mode _mode;
  final int? rank;
  final VoidCallback? onTapVideo;

  const VideoBaseOrAdCell.small(this.model,
      {super.key, this.rank, this.onTapVideo})
      : _mode = _Mode.small;

  const VideoBaseOrAdCell.smallVertical(this.model,
      {super.key, this.rank, this.onTapVideo})
      : _mode = _Mode.smallVertical;

  const VideoBaseOrAdCell.bigVertical(this.model,
      {super.key, this.rank, this.onTapVideo})
      : _mode = _Mode.bigVertical;

  const VideoBaseOrAdCell.big(this.model,
      {super.key, this.rank, this.onTapVideo})
      : _mode = _Mode.big;

  @override
  Widget build(BuildContext context) {
    if (_mode == _Mode.small) {
      if (model is VideoBaseModel) {
        return VideoBaseCell.small(
          video: model,
          rank: rank,
          onTap: onTapVideo,
        );
      } else if (model is InsertAdPlaceHolderModel) {
        // return InsertAd.fromPlaceholder(
        //   model,
        //   width: VideoBaseCell.smallWidth,
        //   height: VideoBaseCell.smallImageHeight,
        //   showName: true,
        // );
      }
    } else if (_mode == _Mode.smallVertical) {
      if (model is VideoBaseModel) {
        return VideoBaseCell.smallVertical(
          video: model,
          rank: rank,
          onTap: onTapVideo,
        );
      } else if (model is InsertAdPlaceHolderModel) {
        // return InsertAd.fromPlaceholder(
        //   model,
        //   width: VideoBaseCell.smallVerticalWidth,
        //   height: VideoBaseCell.smallVerticalImageHeight,
        //   showName: true,
        // );
      }
    } else if (_mode == _Mode.big) {
      if (model is VideoBaseModel) {
        return VideoBaseCell.big(
          video: model,
          rank: rank,
          onTap: onTapVideo,
        );
      } else if (model is InsertAdPlaceHolderModel) {
        // return InsertAd.fromPlaceholder(
        //   model,
        //   width: VideoBaseCell.bigWidth,
        //   height: VideoBaseCell.bigImageHeight,
        //   showName: true,
        // );
      }
    } else if (_mode == _Mode.bigVertical) {
      if (model is VideoBaseModel) {
        return VideoBaseCell.bigVertical(
          video: model,
          rank: rank,
          onTap: onTapVideo,
        );
      } else if (model is InsertAdPlaceHolderModel) {
        // return InsertAd.fromPlaceholder(
        //   model,
        //   width: VideoBaseCell.bigVerticalWidth,
        //   height: VideoBaseCell.bigVerticalImageHeight,
        //   showName: true,
        // );
      }
    }

    assert(false, 'VideoBaseOrAdCell:bad model $model');
    return const SizedBox.shrink();
  }
}
