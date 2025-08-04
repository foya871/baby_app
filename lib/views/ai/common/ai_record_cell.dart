import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import '../../../components/easy_button.dart';
import '../../../components/easy_toast.dart';
import '../../../components/image_view.dart';
import '../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../generate/app_image_path.dart';
import '../../../http/api/api.dart';
import '../../../routes/routes.dart';
import '../../../utils/color.dart';
import '../../../utils/enum.dart';
import '../../../utils/extension.dart';
import '../../../utils/file_downloader.dart';
import '../../../utils/logger.dart';
import 'popup/ai_delete_dialog.dart';

// 记录里面一个最小显示单元

enum AiRecordCellType { image, video }

// 记录里没有统一的model，这里新写一个
class AiRecordCellOption {
  final AiRecordCellType type;
  final AiRecordClientStatus status;
  final String cover;
  final String? title;
  final List<String> fileNames;
  final String? tradeNo;
  final VoidCallback? onDelSuccess;

  // type == video 第一个
  String get videoUrl =>
      type == AiRecordCellType.video ? (fileNames.firstOrNull ?? '') : '';

  AiRecordCellOption({
    required this.type,
    required this.status,
    required this.cover,
    required this.fileNames,
    this.title,
    this.tradeNo,
    this.onDelSuccess,
  });

  void _onSave() async {
    for (final fileName in fileNames) {
      final result = await FutureLoadingDialog.progress(
        (_) => filedownloader.downloadMediaToGallery(
          fileName,
          onProgress: _.updateProgress,
        ),
        tips: '下载中...',
      ).show();
      if (result == null || result == FileDownloaderResult.fail) {
        EasyToast.show('保存失败');
        return;
      } else {
        logger.d('broswer downloading...');
      }
    }
    if (fileNames.isNotEmpty) {
      EasyToast.show('保存成功');
    }
  }

  void _onShare() => Get.toShare();

  // ignore: unused_element
  void _onDelete() {
    if (tradeNo == null || tradeNo!.isEmpty) return;
    AiDeleteOneDialog(
      type,
      onConfirm: () async {
        final ok =
            await FutureLoadingDialog(Api.delOneAiRecord(tradeNo!)).show();
        if (ok == true) {
          onDelSuccess?.call();
        }
      },
    ).show();
  }
}

class AiRecordCell extends StatelessWidget {
  final AiRecordCellOption option;
  final double? width;
  final double? imageHeight;

  AiRecordCell.vertical({super.key, required this.option})
      : width = 162.5.w,
        imageHeight = 211.w;

  AiRecordCell.horizontal({super.key, required this.option})
      : width = 162.5.w,
        imageHeight = 90.w;

  const AiRecordCell.auto({super.key, required this.option})
      : width = null,
        imageHeight = null;

  Widget? _buildPlayButton() =>
      option.type == AiRecordCellType.video && option.videoUrl.isNotEmpty
          ? Image.asset(AppImagePath.ai_home_play, width: 30.w, height: 30.w)
          : null;

  Widget _buildCover() => ImageView(
        src: option.cover,
        width: width,
        height: imageHeight,
        borderRadius: Styles.borderRadius.all(8.w),
      ).onTap(option.status == AiRecordClientStatus.success
          ? () {
              switch (option.type) {
                case AiRecordCellType.image:
                  Get.toImageViewer(option.fileNames);
                case AiRecordCellType.video:
                  if (option.videoUrl.isNotEmpty == true) {
                    Get.toVideoBoxByURL(url: option.videoUrl);
                  }
              }
            }
          : null);

  Widget _buildOperationButton(String text,
          {required Color backgroundColor,
          required Color fontColor,
          VoidCallback? onTap}) =>
      EasyButton(
        text,
        textStyle: TextStyle(
          fontSize: Styles.fontSize.s,
          color: fontColor,
        ),
        backgroundColor: backgroundColor,
        borderRadius: Styles.borderRadius.all(16.w),
        width: 48.w,
        height: 24.w,
        onTap: onTap,
      );

  Widget? _buildSuccessOperation() {
    if (option.status != AiRecordClientStatus.success) return null;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildOperationButton(
          '保存',
          backgroundColor: COLOR.black.withOpacity(0.35),
          fontColor: COLOR.white.withOpacity(0.8),
          onTap: option._onSave,
        ),
        10.horizontalSpace,
        _buildOperationButton(
          '分享',
          backgroundColor: COLOR.black.withOpacity(0.35),
          fontColor: COLOR.white.withOpacity(0.8),
          onTap: option._onShare,
        ),
      ],
    ).marginHorizontal(4.w);
  }

  // Widget? _buildFailRemove() {
  //   if (option.status != AiRecordClientStatus.error) return null;
  //   return Image.asset(AppImagePath.ai_record_remove, width: 18.w, height: 18.w)
  //       .onTap(() => option._onDelete());
  // }

  Widget? _buildFailTips() => option.status == AiRecordClientStatus.error
      ? Container(
          width: double.infinity,
          height: 26.w,
          decoration: BoxDecoration(
            color: COLOR.black.withValues(alpha: 0.7),
            // borderRadius: Styles.borderRadius.all(8.w),
          ),
          child: Center(
            child: Text(
              '生成失败',
              style: TextStyle(fontSize: 13.w),
            ),
          ),
        )
      : null;

  Widget? _buildMakingTips() => option.status == AiRecordClientStatus.making
      ? Container(
          width: double.infinity,
          height: 26.w,
          decoration: BoxDecoration(
            color: COLOR.black.withValues(alpha: 0.7),
            // borderRadius: Styles.borderRadius.all(8.w),
          ),
          child: Center(
            child: Text(
              '火速制作中',
              style: TextStyle(fontSize: 13.w),
            ),
          ),
        )
      : null;

  Widget? _buildTitle() => option.title?.isNotEmpty == true
      ? Text(
          option.title!,
          maxLines: 1,
          style: TextStyle(
            fontSize: 14.w,
            overflow: TextOverflow.ellipsis,
          ),
        )
      : null;

  Widget _buildBody() {
    final image = _buildCover();
    final title = _buildTitle();
    final playButton = _buildPlayButton();
    final makingTips = _buildMakingTips();
    final failTips = _buildFailTips();
    final operation = _buildSuccessOperation();
    // final failRemove = _buildFailRemove();
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              image,
              if (playButton != null)
                Positioned.fill(
                  child: IgnorePointer(child: Center(child: playButton)),
                ),
              if (operation != null)
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: operation.marginBottom(8.w),
                )),
              if (makingTips != null)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: makingTips,
                  ),
                ),
              if (failTips != null)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: failTips,
                  ),
                ),
              // if (failRemove != null)
              //   Positioned(
              //     right: 2.w,
              //     top: 2.w,
              //     child: Align(
              //       alignment: Alignment.topRight,
              //       child: failRemove,
              //     ),
              //   )
            ],
          ),
          if (title != null) title.marginTop(6.w),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildBody();
}
