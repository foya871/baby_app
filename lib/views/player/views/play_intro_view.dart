import 'package:baby_app/components/ad/ad_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/easy_button.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/short_widget/video_base_cell.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/model/play/video_detail_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/ad_jump.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:baby_app/utils/extension.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:baby_app/views/player/controllers/video_play_controller.dart';
import 'package:baby_app/views/player/views/choose_serial_videos_view.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/ad/ad_enum.dart';
import '../../../components/grid_view/heighted_grid_view.dart';
import '../../../model/video_base_model.dart';
import 'video_progress_download_button.dart';

class PlayIntroView extends StatelessWidget {
  final VideoPlayController vc;

  const PlayIntroView({super.key, required this.vc});

  Widget _buildItem({
    required String icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(icon, width: 25.w, height: 25.w),
        TextView(
          text: title,
          color: Colors.white,
          fontSize: 12.w,
        )
      ],
    ).onTap(() => onTap?.call());
  }

  Widget _buildCenterBtns() {
    final favN = _video.fakeFavorites ?? 0;
    final fav = _video.favorite ?? false;
    final favIcon = fav
        ? AppImagePath.community_collect
        : AppImagePath.community_collect_no;

    final likeN = _video.fakeLikes ?? 0;
    final like = _video.isLike ?? false;
    final likeIcon =
        like ? AppImagePath.player_like_y : AppImagePath.player_like;
    return Row(
      children: [
        TextView(
          text: '$_playnum次播放',
          color: Colors.white.withValues(alpha: 0.6),
          fontSize: 12.w,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildItem(
                  icon: likeIcon,
                  title: Utils.numFmt(likeN),
                  onTap: () => vc.toggleLike()),
              20.horizontalSpace,
              _buildItem(
                icon: favIcon,
                title: Utils.numFmt(favN),
                onTap: () => vc.toggleFav(),
              ),
              20.horizontalSpace,
              _buildItem(
                  icon: AppImagePath.player_share,
                  title: '分享',
                  onTap: () => Get.toShare()),
              20.horizontalSpace,
              VideoProgressDownloadButton(detail: _video, vc: vc),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return TextView(
      text: _title,
      fontSize: 16.w,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  Widget _buildAdBox() {
    final ads = AdUtils().getAdLoadInOrder(AdApiType.PLAY_PAGE_THUMBNAIL);
    if (ads.isEmpty) return const SizedBox.shrink();
    final gap = 8.w;
    final itemW = (Get.width - 14.w * 2 - 4 * gap) / 5.0;
    return Wrap(
      spacing: gap,
      runSpacing: gap,
      children: ads
          .map(
            (e) => SizedBox(
              width: itemW,
              child: Column(
                children: [
                  ImageView(
                    src: e.adImage,
                    borderRadius: BorderRadius.circular(4.w),
                    width: itemW,
                    height: itemW,
                  ),
                  3.verticalSpace,
                  SizedBox(
                    width: itemW,
                    child: TextView(
                      text: e.adName,
                      color: Colors.white,
                      fontSize: 13.w,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ).onTap(() => kAdjump(e)),
          )
          .toList(),
    );
  }

  Widget _buildGuessHeader() {
    return TextView(
      text: '精彩推荐',
      fontSize: 16.w,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
  }

  VideoDetail get _video => vc.video.value;
  bool get _vip => _video.videoType == VideoTypeValueEnum.VIP;

  bool get _guessLike => vc.guessLikeItems.value.isNotEmpty;

  String get _title => _video.title ?? '';
  String get _playnum => Utils.numFmt(_video.fakeWatchNum ?? 0);

  Widget _buildGuessLikeItem({required VideoBaseModel model}) {
    return SizedBox(
      width: double.infinity,
      height: 90.w,
      child: Row(
        children: [
          ImageView(
            src: model.hCover,
            width: 160.w,
            height: 90.w,
            borderRadius: BorderRadius.circular(8.w),
          ),
          8.horizontalSpace,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: model.title ?? '',
                color: Colors.white,
                fontSize: 13.w,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              5.verticalSpace,
              if (model.tagTitles?.isNotEmpty == true)
                Row(
                  children: model.tagTitles!
                      .map((e) => TextView(
                            text: e,
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 10.w,
                          ).marginRight(10.w).onTap(() => Get.toTagVideos(e)))
                      .toList(),
                ),
              const Expanded(child: SizedBox.shrink()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                      text: Utils.dateAgo(model.createdAt ?? ''),
                      color: Colors.white,
                      fontSize: 10.w),
                  TextView(
                      text: '${Utils.numFmt(model.fakeWatchNum ?? 0)}观看',
                      color: Colors.white,
                      fontSize: 10.w)
                ],
              )
            ],
          ))
        ],
      ),
    ).onTap(() => vc.fetchVideoDetailByVideoId(model.videoId ?? 0));
  }

  Widget _buildGuessLikeList() {
    return HeightedGridView.sliver(
      scrollDirection: Axis.vertical,
      crossAxisCount: 1,
      rowMainAxisAlignment: MainAxisAlignment.start,
      itemCount: vc.guessLikeItems.length,
      columnSpacing: 6.w,
      itemBuilder: (ctx, i) {
        final item = vc.guessLikeItems[i];
        return _buildGuessLikeItem(model: item);
      },
      rowSepratorBuilder: (ctx, i) => 10.verticalSpace,
    );
  }

  bool get _hasTags => _video.tagTitles?.isNotEmpty == true;

  Widget _buildTags() {
    if (!_hasTags) return const SizedBox.shrink();
    final items = _video.tagTitles!;
    return Wrap(
      spacing: 6.w,
      runSpacing: 6.w,
      children: items
          .map(
            (e) => EasyButton(
              "#$e",
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              textStyle: kTextStyle(Colors.white, fontsize: 12.w),
              height: 22.w,
              borderRadius: BorderRadius.circular(11.w),
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              onTap: () => Get.toTagVideos(e),
            ),
          )
          .toList(),
    );
  }

  bool get _hasVideos => _video.videoIds?.isNotEmpty == true;

  Widget _buildVideosHeader() {
    return Row(
      children: [
        TextView(text: "剧集", fontSize: 16.w, color: Colors.white),
        const Spacer(),
        TextView(text: "查看全部", fontSize: 13.w, color: const Color(0xff999999)),
        3.horizontalSpace,
        Image.asset(
          AppImagePath.player_more,
          width: 14.w,
          height: 14.w,
        )
      ],
    ).onTap(() => Get.bottomSheet(
          isDismissible: true,
          isScrollControlled: true,
          backgroundColor: const Color(0xff13141f),
          elevation: 0,
          ChooseSerialVideosView(
            controller: vc,
            onTap: (videoId) {
              vc.fetchVideoDetailByVideoId(videoId);
              Get.back();
            },
          ),
        ));
  }

  Widget _buildVideos() {
    final gap = 12.w;
    final itemW = (Get.width - 14.w * 2 - 5 * gap) / 6.0;
    var items = _video.videoIds ?? [];
    if (items.length > 6) items = items.sublist(0, 5);
    return Wrap(
      spacing: gap,
      children: items.map((e) {
        final isme = _video.videoId == e;
        final index = items.indexOf(e) + 1;
        final bgColor = isme
            ? COLOR.themeSelectedColor
            : Colors.white.withValues(alpha: 0.1);
        return EasyButton(
          '$index',
          width: itemW,
          height: 36.w,
          backgroundColor: bgColor,
          textStyle: kTextStyle(Colors.white),
          borderRadius: BorderRadius.circular(5.w),
          onTap: () {
            if (isme) return;
            vc.fetchVideoDetailByVideoId(e);
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              10.verticalSpace.sliverBox,
              _buildTitle().sliverBox,
              if (_hasTags) 10.verticalSpace.sliverBox,
              if (_hasTags) _buildTags().sliverBox,
              10.verticalSpace.sliverBox,
              _buildCenterBtns().sliverBox,
              if (_hasVideos) _buildVideosHeader().sliverBox,
              if (_hasVideos) 10.verticalSpace.sliverBox,
              if (_hasVideos) _buildVideos().sliverBox,
              12.verticalSpace.sliverBox,
              _buildAdBox().sliverBox,
              if (_guessLike) 12.verticalSpace.sliverBox,
              if (_guessLike) _buildGuessHeader().sliverBox,
              if (_guessLike) 12.verticalSpace.sliverBox,
              if (_guessLike) _buildGuessLikeList(),
            ],
          ),
        ),
      ],
    ).baseMarginHorizontal;
  }
}
