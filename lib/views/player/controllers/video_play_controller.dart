/*
 * @Author: wangdazhuang
 * @Date: 2024-08-19 11:56:27
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/views/player/controllers/video_play_controller.dart
 */

import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'package:baby_app/components/ad/ad_enum.dart';
import 'package:baby_app/components/ad/ad_utils.dart';
import 'package:baby_app/components/diolog/buy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/components/diolog/loading/loading_view.dart';
import 'package:baby_app/env/environment_service.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:baby_app/model/play/cdn_model.dart';
import 'package:baby_app/model/play/video_detail_model.dart';
import 'package:baby_app/services/user_service.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:baby_app/utils/logger.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../../model/video_base_model.dart';
import '../../../routes/routes.dart';

class VideoPlayController extends GetxController
    with StateMixin, GetSingleTickerProviderStateMixin {
  static const aspRatio = 400 / 236.0;

  static double get videoH => Get.width / aspRatio;

  ///播放器初始化
  RxBool playerInitialized = false.obs;

  Rx<VideoDetail> video = VideoDetail.fromJson({}).obs;
  RxList<VideoBaseModel> guessLikeItems = <VideoBaseModel>[].obs;

  ///左下角倒计时广告
  int timerAdCount = 0;
  RxBool showTimerAd = false.obs;
  Timer? timerTimer;
  AdInfoModel timerAd = AdInfoModel.fromJson({});

  bool get _timerAdIsNull => timerAd.adId == AdInfoModel.fromJson({}).adId;

  ///开头广告
  int startTimerAdCount = 0;
  RxBool showStartAd = false.obs;
  Timer? startAdTimer;
  AdInfoModel startAd = AdInfoModel.fromJson({});

  bool get _startAdIsNull => startAd.adId == AdInfoModel.fromJson({}).adId;

  int get _videoId => video.value.videoId ?? 0;

  bool get videoEmpty =>
      video.value.videoId == VideoDetail.fromJson({}).videoId;

  ///获取播放地址
  String get _playPath => Environment.buildAuthPlayUrlString(
      videoUrl: video.value.videoUrl,
      id: video.value.cdnRes?.id,
      authKey: video.value.authKey);

  double get videoAsp {
    var w = video.value.width ?? 16.0;
    if (w == 0) w = 16.0;
    var h = video.value.height ?? 9.0;
    if (h == 0) h = 9.0;
    return w / h;
  }

  Rx showVipPermission = false.obs;

  ///是否是第一次进入播放页
  bool _fisrtIn = true;

  ///刷新
  void _updateUI() => update();

  ///暂停广告
  AdInfoModel stopAd = AdInfoModel.fromJson({});

  bool get _stopAdIsNull => stopAd.adId == AdInfoModel.fromJson({}).adId;
  RxBool showStopAd = false.obs;

  // 播放线路
  final line = '更换线路'.obs;

  /// player相关
  VideoController? playerVC;
  Player? player;
  StreamSubscription<bool>? _completePosSubs;
  StreamSubscription<bool>? _playingSubs;
  StreamSubscription<Duration>? _postionSubs;
  StreamSubscription<Duration>? _durationSubs;
  Duration _duration = Duration.zero;

  late TabController tabController;

  ///记录一开始播放了
  bool _start2Play = false;
  bool _playEnd = false;
  bool _isFree = false;

  ///左下角倒计时
  _timerAdStart() {
    if (!_timerAdIsNull && !showTimerAd.value) {
      showTimerAd.value = true;
      timerTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (timerAdCount > 0) {
            timerAdCount -= 1;
          } else {
            timer.cancel();
            showTimerAd.value = false;
          }
          _updateUI();
        },
      );
    }
  }

  ///开头
  _startAdTimerStart() {
    if (!_startAdIsNull) {
      showStartAd.value = true;
      startAdTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (startTimerAdCount > 0) {
            startTimerAdCount -= 1;
          } else {
            timer.cancel();
            showStartAd.value = false;
            player?.play();
          }
          _updateUI();
        },
      );
    }
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    Get.find<UserService>().updateAPIAssetsInfo();
    final args = Get.arguments;

    int? videoId;

    if (args is Map<String, dynamic>) {
      videoId = args["videoId"] is int ? args["videoId"] as int : null;
      _isFree = args["isFree"] is bool ? args["isFree"] as bool : false;
    }

    if (videoId == null) {
      debugPrint("videoId is missing or invalid");
    }

    fetchVideoDetailByVideoId(videoId ?? 0);
    super.onInit();
  }

  ///切换播放源
  fetchVideoDetailByVideoId(int videoId) async {
    if (_fisrtIn) change(null, status: RxStatus.loading());
    final resp =
        await Api.fetchVideoDetailByVideoId(videoId: videoId, isFree: _isFree);
    if (_fisrtIn) change(null, status: RxStatus.success());
    _fisrtIn = false;
    if (resp == null) return;
    video.value = resp;
    _updateUI();
    _setLine();
    _changePlayPath(resp.playerPath);
    _startAdTimerStart();
    fetchGuessLikeList(videoId: videoId);
  }

  ///更换播放源
  _changePlayPath(String videoURL) async {
    _resetBeforePlay();
    if (player == null) {
      _initPlayController(videoURL);
    } else {
      await _reportHistory();
      await player?.pause();
      await player?.stop();
      player?.open(Media(videoURL), play: _startAdIsNull).then((___) {
        playerInitialized.value = true;
      });
    }
  }

  void _resetBeforePlay() {
    _start2Play = false;
    _playEnd = false;
    playerInitialized.value = false;
    showVipPermission.value = false;
    showVipPermission.value = isVipVideo && video.value.canWatch == false;

    ///开头广告
    startAdTimer?.cancel();
    showStartAd.value = false;
    startAd = AdInfoModel.fromJson({});
    final arr = AdUtils().getAdLoadInOrder(AdApiType.LONG_VIDEO_PLAY_START);
    if (arr.isNotEmpty) {
      final randomIndex = Random().nextInt(arr.length);
      startAd = arr[randomIndex];
      startTimerAdCount = startAd.minStaySecond ?? 10;
    }

    ///暂停广告
    stopAd = AdInfoModel.fromJson({});
    final items = AdUtils().getAdLoadInOrder(AdApiType.LONG_VIDEO_PAUSE);
    if (items.isNotEmpty) {
      final randomIndex = Random().nextInt(items.length);
      stopAd = items[randomIndex];
    }

    ///倒计时广告
    timerTimer?.cancel();
    showTimerAd.value = false;
    timerAd = AdInfoModel.fromJson({});
    final _ = AdUtils().getAdInfo(AdApiType.PLAY_PAGE_THUMBNAIL);
    if (_ != null) {
      timerAd = _;
      timerAdCount = _.minStaySecond ?? 10;
    }
  }

  ///初始化播放器
  _initPlayController(String videoURL) {
    logger.d("playPath:>>>>$videoURL");
    final config = PlayerConfiguration(
      muted: false, //web下静音可以实现自动播放
      title: '',
      osc: true,
      ready: () => playerInitialized.value = true,
    );
    player = Player(configuration: config);
    playerVC = VideoController(
      player!,
      configuration: VideoControllerConfiguration(
        enableHardwareAcceleration: !GetPlatform.isAndroid,
      ),
    );
    player!.open(Media(videoURL), play: _startAdIsNull);
    _addVideoListeners();
  }

  ///是否正在播放
  void _playingListener(bool event) {
    if (event) {
      ///正在播放
      if (showStopAd.value) {
        showStopAd.value = false;
      }
    } else {
      ///暂停了
      if (!showStopAd.value && !_stopAdIsNull && _start2Play && !_playEnd) {
        showStopAd.value = true;
        _updateUI();
      }
    }
  }

  ///播放结束
  void _playEndListener(bool event) {
    if (event) {
      if (video.value.canWatch == false) {
        if (isVipVideo) {
          showOpenVipSheet();
        } else {
          ///购买
          showBuyVideoPermissionSheet();
        }
      } else {
        ///能看
        player?.seek(Duration.zero).then((_) {
          player?.play();
        });
      }
    }
  }

  ///播放进度
  void _playPostionListener(Duration postion) {
    final milseconds = postion.inMicroseconds;
    final dur = _duration.inSeconds;
    if (dur > 0) _playEnd = postion.inSeconds >= dur - 1;
    if (!_start2Play && milseconds > 200) {
      _start2Play = true;
      _timerAdStart();
      player!.seek(Duration.zero).then((_) {
        player!.play();
      });
    }
  }

  ///总时长
  void _playDurationListener(Duration duration) => _duration = duration;

  ///添加监听器
  void _addVideoListeners() {
    _playingSubs = player!.stream.playing.listen(_playingListener);
    _completePosSubs = player!.stream.completed.listen(_playEndListener);
    _postionSubs = player!.stream.position.listen(_playPostionListener);
    _durationSubs = player!.stream.duration.listen(_playDurationListener);
  }

  void showOpenVipSheet() => showBuyVIPWattleDialog(type: BuyType.vip);

  ///购买弹框
  void showBuyVideoPermissionSheet() {
    final price = video.value.price ?? 0;
    showToPayDialog(Get.context!,
        discountPrice: price,
        originPrice: price,
        onDiscountButton: () => Get.toVip(),
        onRechargeButton: () => Get.toWallet(),
        onMask: () => SmartDialog.dismiss(),
        onPay: () {
          ///对比价格
          _buyAction();
        });
  }

  bool get isVipVideo => video.value.reasonType == VideoReasonTypeValueEnum.VIP;

  bool get isPurVideo =>
      video.value.reasonType == VideoReasonTypeValueEnum.NeedPay;

  ///卸载定时器和监听器
  void _unLoadSubscriptions() {
    timerTimer?.cancel();
    startAdTimer?.cancel();
    _playingSubs?.cancel();
    _completePosSubs?.cancel();
    _postionSubs?.cancel();
    _durationSubs?.cancel();
  }

  @override
  void onClose() {
    _unLoadSubscriptions();
    _reportHistory();
    tabController.dispose();
    logger.d("destroy called,release memory!");
    player?.dispose();
    super.onClose();
  }

  ///切换线路
  void changeLine(CdnRsp resp) {
    video.value.cdnRes = resp;
    _setLine();
    _changePlayPath(_playPath);
  }

  // 设置显示线路
  void _setLine() {
    final line = video.value.cdnRes?.line ?? '';
    this.line.value = line.isEmpty ? '更换线路' : line;
  }

  ///业务操作接口处理

  ///猜你喜欢
  fetchGuessLikeList({required int videoId}) async {
    if (_fisrtIn) {
      final items = await Api.fetchGuessLikeVideoList(videoId: videoId);
      if (items != null) {
        guessLikeItems.value = items;
        _updateUI();
      }
    } else {
      ///
      final items = await LoadingView.singleton.wrap(
          context: Get.context!,
          asyncFunction: () async {
            return await Api.fetchGuessLikeVideoList(videoId: videoId);
          });
      if (items?.isNotEmpty == true) {
        guessLikeItems.value = items!;
        _updateUI();
      }
    }
  }

  //点赞
  toggleLike() async {
    final resp = await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          return await Api.toggleVideoLike(_videoId, like: video.value.isLike!);
        });
    if (resp) {
      video.value.isLike = !video.value.isLike!;
      video.value.fakeLikes = video.value.isLike!
          ? video.value.fakeLikes! + 1
          : video.value.fakeLikes! - 1;
      _updateUI();
    }
  }

  ///收藏
  toggleFav() async {
    final resp = await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          return await Api.toggleVideoFav(_videoId, fav: video.value.favorite);
        });
    if (resp) {
      video.value.favorite = !video.value.favorite!;
      video.value.fakeFavorites = video.value.favorite!
          ? video.value.fakeFavorites! + 1
          : video.value.fakeFavorites! - 1;
      _updateUI();
    }
  }

  /// 购买
  _buyAction({VoidCallback? purSuccess}) async {
    final service = Get.find<UserService>();

    final ok = service.checkGold(video.value.price!);
    if (!ok) {
      showBuyVIPWattleDialog(type: BuyType.gold);
      return;
    }

    final purResult = await LoadingView.singleton.wrap(
      context: Get.context!,
      asyncFunction: () async {
        return await Api.purVideo(
          videoId: _videoId,
          payType: 1,
        );
      },
    );
    if (purResult) {
      purSuccess?.call();
      video.value.canWatch = true;
      fetchVideoDetailByVideoId(_videoId);
    }
  }

  ///关注
  feedBack({required String title, VoidCallback? done}) async {
    final result = await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          return await Api.feedVideo(videoId: _videoId, title: title);
        });
    if (result) showToast("感谢您的反馈！");
    Get.back();
  }

  ///上报观影记录
  _reportHistory() async {
    if (player == null || videoEmpty) return;
    if (video.value.canWatch == false) return;
    final postion = player!.state.position.inSeconds;
    if (postion < 5) return;
    //上报
    await Api.uploadWatchRc(
        duration: video.value.playTime ?? 0,
        lookType: _lookType(),
        videoId: _videoId,
        progress: postion);
  }

  ///观看方式 1:免费次数 2：vip观看 3： 金币观看 4：试看
  int _lookType() {
    /////视频类型：0-普通视频 1-VIP视频 2-付费视频
    int n = video.value.videoType!;
    switch (n) {
      case 0:
        return 1;
      case 1:
        return 2;
      case 2:
        return 3;
      default:
        return 0;
    }
  }
}
