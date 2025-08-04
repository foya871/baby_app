import 'package:baby_app/components/ad/ad_utils.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/utils/extension.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../generate/app_image_path.dart';
import 'ad_info_model.dart';
import '../../utils/ad_jump.dart';
import '../../utils/color.dart';
import '../image_view.dart';
import 'ad_enum.dart';

class AdMultipleView extends StatefulWidget {
  final AdApiType type;
  final double width;
  final double? height;
  final double? radius;

  final double? smallIconSize;
  final double? spacing;
  final double? runSpacing;

  /// 只有 NAV_ICON 用的到
  final int? stationId;

  final bool? isShowMark;
  final double? markRadius;
  final (double? top, double? bottom, double? left, double? right)? position;

  /// 只有用于 START
  final String? placeholder;

  const AdMultipleView({
    super.key,
    required this.type,
    this.width = double.infinity,
    this.height,
    this.radius,
    this.smallIconSize,
    this.spacing,
    this.runSpacing,
    this.stationId,
    this.isShowMark,
    this.markRadius,
    this.position,
    this.placeholder,
  });

  /// 小图标列表
  ///  --------------------------------
  /// ｜  图标   图标   图标   图标   图标  ｜
  /// ｜  名字   名字   名字   名字   名字  ｜
  /// ｜                                 ｜
  /// ｜  图标   图标   图标   图标   图标  ｜
  /// ｜  名字   名字   名字   名字   名字  ｜
  ///  --------------------------------
  const AdMultipleView.smallIcons({
    super.key,
    required this.type,
    this.width = double.infinity,
    this.height,
    this.radius,
    this.smallIconSize,
    this.spacing,
    this.runSpacing,
    this.stationId,
  })  : isShowMark = null,
        markRadius = null,
        position = null,
        placeholder = null;

  /// 横幅广告
  /// --------------------------------
  /// ｜       横幅广告图片banner       ｜
  /// ｜       横幅广告图片banner       ｜
  /// ｜       横幅广告图片banner       ｜
  /// ｜                         广告  ｜
  /// --------------------------------
  /// 考虑到横幅广告的高度会因为每个项目的设计不同而有所差异，所以外部必传
  const AdMultipleView.banner({
    super.key,
    required this.type,
    this.width = double.infinity,
    required this.height,
    this.radius,
    this.isShowMark = true,
    this.markRadius,
    this.position,
  })  : smallIconSize = null,
        stationId = null,
        spacing = null,
        runSpacing = null,
        placeholder = null;

  /// 列表形式AD()
  const AdMultipleView.list({
    super.key,
    required this.type,
    this.width = double.infinity,
    required this.height,
    this.radius,
    this.spacing,
    this.placeholder,
  })  : smallIconSize = null,
        runSpacing = null,
        stationId = null,
        isShowMark = null,
        markRadius = null,
        position = null;

  @override
  State<AdMultipleView> createState() => _AdMultipleViewState();
}

class _AdMultipleViewState extends State<AdMultipleView> {
  List<AdInfoModel> ads = []; // 获取广告列表的逻辑需要实现
  ///仅用于记录横幅广告的当前索引
  var bannerIndex = 0.obs;

  @override
  void initState() {
    initAdData();
    super.initState();
  }

  initAdData() {
    ads = AdUtils().getAdLoadInOrder(widget.type);
    if (widget.type == AdApiType.NAV_ICON) {
      ads = ads.where((ad) => ad.labelType == 0).toList();
      if (widget.stationId != null) {
        ads = ads
            .where((ad) =>
                ad.stations
                    ?.any((station) => station.stationId == widget.stationId) ??
                false)
            .toList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ads.isNotEmpty) {
      if (
          // widget.type == AdApiType.SHORT_VIDEO_TOP_ICON ||
          widget.type == AdApiType.INSERT_ICON ||
              widget.type == AdApiType.INDEX_POP_ICON ||
              widget.type == AdApiType.INSERT_ICON ||
              widget.type == AdApiType.NAV_ICON) {
        return _buildSmallIconsView();
      }
      // if (widget.type == AdApiType.TOP_BANNER) {
      //   return _buildBannerView();
      // }
      if (widget.type == AdApiType.START ||
          widget.type == AdApiType.START_POP_UP) {
        return _buildListView();
      }
    }

    return const SizedBox.shrink();
  }

  /// 小图标列表
  ///  --------------------------------
  /// ｜  图标   图标   图标   图标   图标  ｜
  /// ｜  名字   名字   名字   名字   名字  ｜
  /// ｜                                 ｜
  /// ｜  图标   图标   图标   图标   图标  ｜
  /// ｜  名字   名字   名字   名字   名字  ｜
  ///  --------------------------------
  ///  SHORT_VIDEO_TOP_ICON、LONG_VIDEO_PLAY_ICON
  ///  INDEX_POP_ICON、CLASSIFY_TOP_ICONS
  /// NAV_ICON（特殊处理）、
  _buildSmallIconsView() {
    return Wrap(
      spacing: widget.spacing ?? 10.w,
      runSpacing: widget.runSpacing ?? 10.w,
      children: ads.map((ad) {
        return _buildSmallIconItemView(ad);
      }).toList(),
    );
  }

  Widget _buildSmallIconItemView(AdInfoModel ad) {
    return Column(
      children: [
        ImageView(
          src: ad.adImage,
          width: widget.smallIconSize ?? 62.w,
          height: widget.smallIconSize ?? 62.w,
          fit: BoxFit.fill,
          borderRadius: BorderRadius.circular(widget.radius ?? 8.w),
        ),
        Text(
          (ad.adName.isNotEmpty && ad.adName.length > 4)
              ? ad.adName.substring(0, 4)
              : ad.adName,
          style: TextStyle(
            color: COLOR.white,
            fontSize: 11.w,
            fontWeight: FontWeight.w500,
          ),
        ).marginOnly(top: 6.w),
      ],
    ).onOpaqueTap(() {
      kAdjump(ad);
    });
  }

  /// 横幅广告
  /// --------------------------------
  /// ｜                              ｜
  /// ｜       横幅广告图片banner       ｜
  /// ｜                              ｜
  /// ｜                         广告  ｜
  /// --------------------------------
  _buildBannerView() {
    return CarouselSlider.builder(
      itemCount: ads.length,
      itemBuilder: (context, index, realIndex) {
        return _buildBannerItemView(ads[index]);
      },
      options: CarouselOptions(
        height: widget.height,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: (widget.width) / (widget.height ?? 120),
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          bannerIndex.value = index;
        },
      ),
    );
  }

  _buildBannerItemView(AdInfoModel ad) {
    return Stack(
      children: [
        Positioned.fill(
          child: ImageView(
            src: ad.adImage,
            width: widget.width,
            height: widget.height,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(widget.radius ?? 8.w),
          ),
        ),
        if (widget.isShowMark == true)
          Positioned(
            top: widget.position?.$1,
            bottom: widget.position?.$2 ?? 5.w,
            left: widget.position?.$3,
            right: widget.position?.$4 ?? 5.w,
            child: Container(
              decoration: BoxDecoration(
                color: COLOR.transparent.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(widget.markRadius ?? 2.w),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
              child: TextView(
                text: "广告",
                fontSize: 12.w,
              ),
            ),
          ),
      ],
    );
  }

  ///列表形式AD
  ///  --------------------------------
  ///  ｜       列表广告图片banner       ｜
  ///  ｜      -----------------       ｜
  ///  ｜       列表广告图片banner       ｜
  ///  ｜      -----------------       ｜
  ///  ｜       列表广告图片banner       ｜
  ///  ---------------------------------
  _buildListView() {
    final adLength = ads.length > 3 ? 3 : ads.length;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: adLength,
      itemBuilder: (context, index) {
        return ImageView(
          width: Get.width,
          height: Get.height / (ads.length > 3 ? 3 : ads.length),
          src: ads[index].adImage,
          fit: BoxFit.fill,
          defaultPlace:
              widget.placeholder ?? AppImagePath.app_default_placeholder,
        )
            .onTap(() => kAdjump(ads[index]))
            .marginBottom(index == adLength - 1 ? 0 : 5.w);
      },
      separatorBuilder: (context, index) => 5.verticalSpace,
    );
  }
}
