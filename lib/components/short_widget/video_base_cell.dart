import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../assets/styles.dart';
import '../../generate/app_image_path.dart';
import '../../http/api/api.dart';
import '../../model/axis_cover.dart';
import '../../model/video_base_model.dart';
import '../../routes/routes.dart';
import '../../utils/color.dart';
import '../../utils/extension.dart';
import '../../utils/utils.dart';
import '../image_view.dart';
import '../keyword_color/keyword_color.dart';
import 'video_duration_cell.dart';
import 'video_official_recommend_cell.dart';
import 'video_play_count_cell.dart';
import 'video_rank_cell.dart';

class VideoBaseCell extends StatelessWidget {
  static final smallWidth = 163.w;
  static final smallImageHeight = 91.w;
  static final smallVerticalWidth = 119.w;
  static final smallVerticalImageHeight = 162.w;
  static final bigVerticalWidth = 163.w;
  static final bigVerticalImageHeight = 210.w;
  static const bigWidth = double.infinity;
  static final bigImageHeight = 190.w;

  static final titleHeight = 36.w;

  final VideoBaseModel _video;
  final bool _isBig;
  final double titleFontSize;

  final int titleMaxLines;
  final BorderRadius? borderRadius;
  final double imageHeight;
  final double? width;
  final bool showTopLeftBanner; // 是否显示左上
  final bool showTopRightBanner; // 是否显示右上
  final CoverImgAxis coverAxis;
  final double shadowRowHeight; // 次数和时长的高度
  final VoidCallback? onTap;
  final bool showShare; // title行的分享按钮
  final String? keyWord;
  bool? isOnlyName = false; // 是否只显示名字
  bool? isFree; //是否限免

  // rank
  final int? rank;

  static double smallAsp({double? baseHorizonW}) {
    baseHorizonW ??= 14.w;
    final w = ((Get.width - 2 * baseHorizonW) - 10.w) / 2.0;
    final h = smallImageHeight + 8.w + titleHeight;
    return w / h;
  }

  // static double bigAsp({double? baseHorizonW}) {
  //   baseHorizonW ??= 14.w;
  //   final w = (Get.width - 2 * baseHorizonW);
  //   final bigtH = 40.w;
  //   final h = bigImageHeight + 8.w + bigtH + 5.w + 25.w;
  //   return w / h;
  // }

  //横版 一行两个，图片高度104，宽度182 仅仅显示名字
  VideoBaseCell.smallOnlyName({
    super.key,
    required VideoBaseModel video,
    this.showTopLeftBanner = true,
    this.showTopRightBanner = true,
    this.isFree = false,
    this.rank,
    this.onTap,
    this.keyWord = '',
  })  : _video = video,
        _isBig = false,

        titleFontSize = 13.w,
        titleMaxLines = 1,
        borderRadius = Styles.borderRaidus.m,
        imageHeight = smallImageHeight,
        width = smallWidth,
        coverAxis = CoverImgAxis.horizontal,
        shadowRowHeight = 20.w,
        isOnlyName = true,
        showShare = false;

  //横版 一行两个，图片高度104，宽度182
  VideoBaseCell.small({
    super.key,
    required VideoBaseModel video,
    this.showTopLeftBanner = true,
    this.showTopRightBanner = true,
    this.isFree = false,
    this.rank,
    this.onTap,
    this.keyWord = '',
  })  : _video = video,
        _isBig = false,
        titleFontSize = 13.w,
        titleMaxLines = 2,
        borderRadius = Styles.borderRaidus.m,
        imageHeight = smallImageHeight,
        width = smallWidth,
        coverAxis = CoverImgAxis.horizontal,
        shadowRowHeight = 20.w,
        showShare = false;

  //竖版(小) 一行三个，图片高度162， 宽度119
  VideoBaseCell.smallVertical({
    super.key,
    required VideoBaseModel video,
    this.showTopLeftBanner = true,
    this.showTopRightBanner = true,
    this.rank,
    this.onTap,
    this.keyWord,
  })  : _video = video,
        _isBig = true,
        titleFontSize = 13.w,
        borderRadius = Styles.borderRaidus.m,
        titleMaxLines = 2,
        imageHeight = smallVerticalImageHeight,
        width = smallVerticalWidth,
        coverAxis = CoverImgAxis.horizontal,
        shadowRowHeight = 20.w,
        showShare = false;

  //竖版(大) 一行两个，图片高度248，宽度182
  VideoBaseCell.bigVertical({
    super.key,
    required VideoBaseModel video,
    this.showTopLeftBanner = true,
    this.showTopRightBanner = true,
    this.rank,
    this.onTap,
    this.keyWord = '',
  })  : _video = video,
        _isBig = false,
        titleFontSize = 13.w,
        borderRadius = Styles.borderRaidus.m,
        titleMaxLines = 2,
        imageHeight = bigVerticalImageHeight,
        width = bigVerticalWidth,
        coverAxis = CoverImgAxis.horizontal,
        shadowRowHeight = 20.w,
        showShare = false;

  // 图片高度180 圆角，不显示操作行
  VideoBaseCell.big(
      {super.key,
      required VideoBaseModel video,
      this.showTopLeftBanner = true,
      this.showTopRightBanner = true,
      this.rank,
      this.onTap,
      this.showShare = false,
      this.keyWord = ''})
      : _video = video,
        _isBig = true,
        titleFontSize = 13.w,
        titleMaxLines = 2,
        borderRadius = Styles.borderRaidus.m,
        imageHeight = bigImageHeight,
        width = bigWidth,
        coverAxis = CoverImgAxis.horizontal,
        shadowRowHeight = 26.w;

  // Widget _buildVideoType() => VideoTypeBanner(
  //       videoType: _video.videoType!,
  //       price: _video.price,
  //     );

  Widget _buildTopLeft() {
    if (rank != null) {
      return VideoRankCell(rank!);
    }
    return const SizedBox.shrink();
  }

  Widget _buildTopRight() {
    if (_video.officialRecommend == true) {
      return const VideoOfficialRecommendCell();
    }
    return const SizedBox.shrink();
  }

  Widget _buildPlayCount() =>
      VideoPlayCountCell(playCount: _video.fakeWatchNum ?? 0);

  Widget _buildDuration() => VideoDurationCell(playTime: _video.playTime);

  Widget _buildCover() => ImageView(
        src: _video.coverByAxis(coverAxis),
        width: double.infinity,
        height: imageHeight,
        fit: BoxFit.cover,
        borderRadius: borderRadius,
        axis: coverAxis,
      );

  Widget _buildShare() => Container(
        decoration: BoxDecoration(
          borderRadius: Styles.borderRadius.all(4.w),
          color: COLOR.color_393939,
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
        child: Row(
          children: [
            Image.asset(
              AppImagePath.shi_pin_green_share,
              width: 13.w,
              height: 10.w,
            ),
            3.horizontalSpace,
            Text('无限看', style: TextStyle(fontSize: 10.w)),
          ],
        ),
      ).onTap(() => Get.toShare());

  Widget _buildTitle() {
    final hasKey = keyWord?.isNotEmpty == true;
    if (hasKey) {
      return SizedBox(
        width: width,
        height: titleHeight,
        child: KeywordColor(
          title: _video.title ?? '',
          maxLine: titleMaxLines,
          keyWord: keyWord,
          style: TextStyle(
            fontSize: titleFontSize,
            color: COLOR.white,
          ),
          kstyle: TextStyle(
            color: COLOR.themeSelectedColor,
            fontSize: titleFontSize,
          ),
        ),
      );
    }
    Widget title = const SizedBox.shrink();
    if (_isBig) {
      title = SizedBox(
        width: width,
        // height: titleHeight,
        child: Text(
          _video.title ?? '',
          maxLines: titleMaxLines,
          style: TextStyle(
            fontSize: titleFontSize,
            overflow: TextOverflow.ellipsis,
            color: COLOR.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else {
      title = SizedBox(
        width: width,
        height: titleHeight,
        child: Text(
          _video.title ?? '',
          maxLines: titleMaxLines,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: titleFontSize,
            // overflow: TextOverflow.ellipsis,
            color: COLOR.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(child: title),
        if (showShare) ...[
          10.horizontalSpace,
          _buildShare(),
        ]
      ],
    );
  }

  Widget _buildShadowRow() {
    return Container(
      height: shadowRowHeight,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          image: Styles.gradient.gradientImage,
          borderRadius: Styles.borderRadius.mBottomLR),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildPlayCount(),
            _buildDuration(),
          ],
        ),
      ),
    );
  }

  Widget _buildForgeroundLayer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 左上
            showTopLeftBanner ? _buildTopLeft() : const SizedBox.shrink(),
            // 右上
            showTopRightBanner ? _buildTopRight() : const SizedBox.shrink(),
          ],
        ),
        _buildShadowRow(),
      ],
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      height: 25.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageView(
                src: AppImagePath.app_default_placeholder,
                width: 12.r,
              ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                Utils.formatTime(_video.createdAt ?? ''),
                style: TextStyle(fontSize: 12.sp, color: COLOR.color_8e8e93),
              ),
            ],
          ),
          Row(
            children: [
              ImageView(
                src: AppImagePath.app_default_placeholder,
                width: 12.r,
              ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                '${_video.commentNum ?? 0}',
                style: TextStyle(fontSize: 12.sp, color: COLOR.color_8e8e93),
              ),
            ],
          ),
          Row(
            children: [
              ImageView(
                src: AppImagePath.app_default_placeholder,
                width: 12.r,
              ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                Utils.numFmt(_video.fakeWatchNum ?? 0),
                style: TextStyle(fontSize: 12.sp, color: COLOR.color_8e8e93),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stack = [];
    stack.add(_buildCover());
    stack.add(Positioned.fill(child: _buildForgeroundLayer()));

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(children: stack),
          6.verticalSpaceFromWidth,
          _buildTitle(),
          // if (_isBig) 5.verticalSpaceFromWidth,
          // if (_isBig) _buildBottom(),
          if (isOnlyName != true) 5.verticalSpaceFromWidth,
          if (isOnlyName != true) _BottomRow(_video),
          // 12.verticalSpaceFromWidth,
        ],
      ),
    ).onOpaqueTap(onTap ??
        () =>
            Get.toPlayVideo(videoId: _video.videoId!, isFree: isFree ?? false));
  }
}

class _BottomRow extends StatefulWidget {
  final VideoBaseModel video;

  const _BottomRow(this.video);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<_BottomRow> {
  VideoBaseModel get video => widget.video;

  Future<void> _onTapLike() async {
    final ok = await Api.toggleVideoLike(video.videoId ?? 0, like: video.like);
    if (!ok) return;
    setState(() {
      video.onToggleLikeSuccess();
    });
  }

  Widget _buildDate() => Text(
        // Utils.dateAgo(video.reviewDate ?? ''),
        Utils.dateFmt(video.reviewDate ?? '', ['yyyy', '-', 'mm', '-', 'dd']),
        style: TextStyle(
          color: COLOR.color_A6ABB1,
          fontSize: 10.w,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _buildComments() => Text(
        '${Utils.numFmt(video.commentNum ?? 0)}评论',
        style: TextStyle(
          fontSize: 10.w,
          color: Colors.white.withValues(alpha: 0.6),
          fontWeight: FontWeight.w500,
        ),
      );

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDate(),
          _buildComments(),
        ],
      );
}
