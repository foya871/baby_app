import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:http_service/http_service.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import '../../../components/diolog/video_in_waiting_dialog.dart';
import '../../../components/easy_toast.dart';
import '../../../components/popup/dialog/video_downloaded_dialog.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/play/video_detail_model.dart';
import '../../../services/user_service.dart';
import '../../../utils/enum.dart';
import '../../../utils/logger.dart';
import '../../../utils/extension.dart';

import '../controllers/video_play_controller.dart';

class VideoProgressDownloadButton extends StatefulWidget {
  final VideoDetail detail;
  final VideoPlayController vc;
  const VideoProgressDownloadButton(
      {super.key, required this.detail, required this.vc});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<VideoProgressDownloadButton> {
  late final StreamSubscription downloadSubs;
  M3u8DownloadDownloadingEvent? progressingEvent;

  @override
  void initState() {
    downloadSubs = EventBusInst.listen<M3u8DownloadEvent>(
      _handleDownloadEvent,
      test: (e) => widget.detail.videoId == e.videoId,
    );
    _fetchDownloadTime();
    super.initState();
  }

  void _handleDownloadEvent(M3u8DownloadEvent e) {
    setState(() {
      if (e is M3u8DownloadRegisteredEvent) {
      } else if (e is M3u8DownloadDownloadingEvent) {
        progressingEvent = e;
      }
    });
  }

  void _onTap() {
    if (GetPlatform.isWeb) {
      EasyToast.show("仅安卓版本支持,请下载安卓客户端!");
      return;
    }
    if (widget.vc.video.value.canWatch == false) {
      final vc = widget.vc;
      final type = vc.video.value.reasonType;
      final isPay = type == VideoReasonTypeValueEnum.NeedPay;
      if (isPay) {
        vc.showBuyVideoPermissionSheet();
        return;
      }

      ///vip弹框
      showAlertDialog(
        Get.context!,
        title: "温馨提示",
        message: 'VIP用户才能下载',
        rightText: "去充值VIP",
        onRightButton: () => Get.toVip(),
      );
      return;
    }

    final download = Get.find<UserService>().user.downloadNum ?? 0;
    if (download == 0) {
      //次数
      showAlertDialog(
        Get.context!,
        title: "温馨提示",
        message: '您剩余下载次数为0，请前往充值或升级VIP获取下载次数！',
        rightText: "前往",
        onRightButton: () => Get.toVip(),
      );
    }

    showAlertDialog(
      Get.context!,
      title: '剩余下载视频次数：$download次',
      message: '本次下载将扣除1次下载特权，请确认是否下载？',
      rightText: "下载",
      onRightButton: () {
        ///原生下载
        if (widget.detail.videoUrl!.isEmpty) return;
        final videoId = widget.detail.videoId!;
        final record = M3u8DownloadManager().getRecord(videoId);
        if (record != null) {
          if (record.isSuccess) {
            VideoDownloadedDialog(onConfirm: () => _registerDownload()).show();
            return;
          } else if (record.isWaiting) {
            VideoInWaitingDialog().show();
            return;
          } else {
            // 之前失败直接下载
          }
        }
        _registerDownload();
        _reportDownloadRecord();
      },
    );
  }

  void _fetchDownloadTime() => Get.find<UserService>().updateAPIUserInfo();

  ///上报 服务器要-1
  void _reportDownloadRecord() async {
    final resp = await httpInstance.get(url: "sys/get/downloadNum");
    if (resp is Map && resp.keys.contains("downloadNum")) {
      final _ = resp["downloadNum"];
      if (_ == null || _ == 0) {
        logger.d('没下载次数了!');
      }
    }
  }

  void _registerDownload() async {
    final register =
        await M3u8DownloadManager().registerByDetail(widget.detail);
    if (register == true) {
      EasyToast.show('添加任务成功');
    } else {
      EasyToast.show('添加任务失败');
    }
  }

  String text = '';
  Widget _buildDownload() {
    final textStyle = TextStyle(
      fontSize: 12.w,
      color: Colors.white,
    );
    final record = M3u8DownloadManager().getRecord(widget.detail.videoId ?? 0);

    double progress = .0;
    String? text;
    if (record == null) {
      text = '下载';
    } else if (record.isWaiting) {
      text = '等待中';
      if (progressingEvent != null) {
        final current = progressingEvent?.downloadedTime ?? 0;
        final totalTime = progressingEvent?.totalTime ?? 0;
        if (totalTime != 0) {
          progress = current / totalTime;
          text = '${(progress * 100).toStringAsFixed(2)}%';
        }
      }
    } else if (record.isSuccess) {
      text = '已下载';
    } else {
      text = '下载失败';
    }
    return Text(
      text,
      style: textStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(AppImagePath.player_download, width: 22.w, height: 22.w),
        3.verticalSpace,
        _buildDownload(),
      ],
    ).onTap(_onTap);
  }
}
