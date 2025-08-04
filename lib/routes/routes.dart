/*
 * @Author: wdz
 * @Date: 2025-05-19 11:13:03
 * @LastEditTime: 2025-06-28 15:59:16
 * @LastEditors: Please set LastEditors
 * @Description: 
 * @FilePath: /baby_app/lib/routes/routes.dart
 */

import 'package:baby_app/model/ai/ai_models.dart';
import 'package:baby_app/model/classify/classify_models.dart';
import 'package:baby_app/model/station_model.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:get/get.dart';

import '../model/video_base_model.dart';
import '../views/player/controllers/video_play_controller.dart';

abstract class Routes {
  Routes._();

  static const no_net_work = '/no_net_work';
  static const noSignal = '/no_signal';
  static const main = '/home';

  static const homeDetailListPage = '/meet/comics/homeDetailListPage';

  static const stationDetailSorting = '/station/detail/sorting';
  static const stationDetailRanking = '/station/detail/ranking';
  static const contentWh = '/content/wh';
  static const rank = '/rank';

  static const videoBox = '/videobox';

  static const launch = '/launch';
  static const videoplay = '/videoplay';

  static const reward = '/reward'; //福利和应用
  static const rewardVideo = '/reward/video'; //福利和应用
  static const exchangeRewardRecord = '/exchangeRewardRecord'; //福利兑换记录
  static const search = '/search';
  static const searchResult = '/searchResult';
  static const tagVideos = '/tagVideos';
  static const producer = '/producer';
  static const creatorlist = '/creatorlist';
  static const starlist = '/starlist';
  static const shareRecord = '/shareRecord';
  static const annews = '/annews';
  static const commonplayer = '/commonplayer';
  static const webview = '/webview';

  static const addlitevideos = '/addlitevideos';
  static const choosetags = "/choosetags";
  static const addliteVideoRule = "/addliteVideoRule";

  ///home
  static const homeRecommend = '/homev/recommend';
  static const customCategory = '/custom/category';

  ///community
  static const communityRelease = '/community/release';
  static const communityDetail = '/community/detail';
  static const bloggerDetail = '/community/blogger/detail';
  static const topicDetail = '/community/topic/detail';

  ///engagement
  static const engagementDetail = '/engagement/engagementDetail';
  static const engagementStationMorePage =
      '/engagement/engagementStationMorePage';
  static const engagement_search = '/engagement/search';
  static const engagement_search_result = '/engagement/search/result';

  /// ai
  static const _aiPrefix = '/ai';
  static const aiHome = '$_aiPrefix/home';
  static const aiRecord = '$_aiPrefix/record';
  static const aiFaceImageUpload = '/ai/faceImage/upload';
  static const aiFaceVideoUpload = '/ai/faceVideo/upload';

  static const shortvideoplayer = '/shortvideoplayer';

  static const welfare = '/welfare';

  static const adultGameStrategy = '/adult/game/strategy';

  static const adultGameListByCollection = '/adult/game/list/by/collection';

  static const adultGameDetail = '/adult/game/detail';

  static const adultGameSearchResult = '/adult/game/search/result';

  static const audltGameSearchHot = '/audlt/game/search/hot';

  //comics
  static const bookshelf = '/bookshelf';
  static const sharedata = '/share/data';
  static const sharedatalist = '/share/data/list';

  // 播单详情
  static const playlistDetail = '/playlistDetail';

  static const imageviewer = '/imageviewer';

  ///mine
  static const mineSetting = '/mine/setting'; //设置
  static const mineLoginRegister = '/mine/login_register'; //登录注册
  static const vip = '/mine/vip'; // VIP
  static const wallet = '/mine/wallet'; // 钱包
  static const mineRechargeRecord = '/mine/recharge_record'; //充值记录
  static const mineWithdrawalRecord = '/mine/withdrawal_record'; //提现记录
  static const withdraw = '/mine/withdraw'; //提现
  static const mineMyIncome = '/mine/my_income'; //我的收益
  static const mineIncomeDetails = '/mine/income_details'; //收益详情
  static const share = '/mine/share'; //分享
  static const minePromotion = '/mine/promotion'; //我的推广
  static const mineFavorites = '/mine/favorites'; //收藏
  static const mineHistory = '/mine/history'; //历史记录
  static const minePurchase = '/mine/purchase'; //我的购买
  static const mineFollow = '/mine/follow'; //关注粉丝
  static const mineOriginalPage = '/mine/originalPage'; // 原创入驻
  static const mineAccountProfile = '/mine/accountProfile'; // 账号凭证
  static const minePublish = '/mine/publish'; //我的发布
  static const mineLike = '/mine/like'; //我的点赞
  static const mineExchange = '/mine/exchange'; //领取兑换
  static const mineExchangeRecord = '/mine/exchange_record'; //领取兑换
  static const mineGroup = '/mine/group'; //加群开车
  static const mineMessage = '/mine/message'; //消息
  static const mineMessageDetail = '/mine/message/detail'; //消息详情
  static const mineChangeIcon = '/mine/changeIcon'; //更换桌面图标
  static const mineInvitePage = '/mine/invitePage'; //填写邀请码
  static const mineDownloadPage = '/mine/downloadPage'; // 下载缓存
  static const mineFeedback = '/mine/feedback'; // 反馈
  static const mineAppRecommend = '/mine/appRecommend'; // 应用推荐
}

// 带参页面，统一写到这里
extension ToNamedWithParamsGet on GetInterface {
  offHome() => offNamed(Routes.main);

  toPlayVideo({required int videoId, bool isFree = false}) {
    if (Get.isRegistered<VideoPlayController>()) {
      final vc = Get.find<VideoPlayController>();
      vc.fetchVideoDetailByVideoId(videoId);
      until(
          (route) => (route.settings.name ?? '').startsWith(Routes.videoplay));
      return;
    }
    toNamed(Routes.videoplay,
        arguments: {'videoId': videoId, 'isFree': isFree});
  }

  toVideoBoxByURL({required String url}) =>
      toNamed(Routes.commonplayer, arguments: url);

  toStationDetail(StationModel station) {
    if (station.detailStyle == StationDetailStyle.rank) {
      toNamed(
        Routes.stationDetailRanking,
        arguments: {'station': station},
      );
    } else {
      toNamed(
        Routes.stationDetailSorting,
        arguments: {'station': station},
      );
    }
  }

  ///去搜索页面
  ///[classifyId] 分类id
  ///[videoType] 视频类型 1:长视频 2:短视频
  toSearchPage({required int classifyId}) => toNamed(Routes.search, arguments: {
        'classifyId': classifyId,
      });

  toAiFaceImageUpload(AiStencilModel stencil) =>
      toNamed(Routes.aiFaceImageUpload, arguments: stencil);

  toAiFaceVideoUpload(AiStencilModel stencil) =>
      toNamed(Routes.aiFaceVideoUpload, arguments: stencil);

  toImageViewer(List<String> images, {int? currentIndex}) => toNamed(
        Routes.imageviewer,
        arguments: images,
        parameters: currentIndex != null
            ? {
                "index": currentIndex.toString(),
              }
            : {},
      );

  toShortVideoPlay(List<VideoBaseModel> items, {required int? initId}) =>
      toNamed(
        Routes.shortvideoplayer,
        arguments: {'videos': items, 'initId': initId},
      );

// toProductDetail({required int id}) => toNamed(
//       Routes.productDetail,
//       parameters: {'id': id.toString()},
//     );

// toResourceDetail({required int id}) => toNamed(
//       Routes.resourceDetail,
//       parameters: {'id': id.toString()},
//     );

  toCommunityRelease() => toNamed(
        Routes.communityRelease,
      );

  toCommunityDetail({required int dynamicId}) => toNamed(
        Routes.communityDetail,
        parameters: {
          'dynamicId': '$dynamicId',
        },
      );

  toBloggerDetail({required int userId}) => toNamed(
        Routes.bloggerDetail,
        parameters: {
          'userId': '$userId',
        },
      );

  toTopicDetail({required String topic, required String id}) => toNamed(
        Routes.topicDetail,
        parameters: {
          'topic': topic,
          'id': id,
        },
      );

  toEngagementDetail({required int meetUserId}) => toNamed(
        Routes.engagementDetail,
        parameters: {
          'meetUserId': '$meetUserId',
        },
      );

  toEngagementStationMore(
          {required int stationId, required String stationName}) =>
      toNamed(
        Routes.engagementStationMorePage,
        parameters: {
          'stationId': '$stationId',
          'stationName': stationName,
        },
      );

  toAdultGameSearchResultByWord(String word) => toNamed(
        Routes.adultGameSearchResult,
        parameters: {
          "word": word,
        },
      );

  toAdultGameSearchResultByWordReplace(String word) => offNamed(
        Routes.adultGameSearchResult,
        parameters: {
          "word": word,
        },
      );

  toPlaylistDetail(int playlistId) =>
      toNamed(Routes.playlistDetail, arguments: {'playlistId': playlistId});

  toShare() => toNamed(Routes.share);

  ///去会员界面
  toVip() => toNamed(Routes.vip);

  toWallet() => toNamed(Routes.wallet);

  toRank(ClassifyModel classify, ShiPinRankType rankType, String title) =>
      toNamed(
        Routes.rank,
        arguments: {'classify': classify, 'rankType': rankType, "title": title},
      );

  // 短视频
  toTagVideosFromShort(String tagsTitle) => _toTagVideos(tagsTitle, type: 2);

  // toTagVideosFromLieQi(String tagsTitle) => _toTagVideos(tagsTitle, type: 3); // 猎奇
  toTagVideos(String tagsTitle) => _toTagVideos(tagsTitle, type: 1);

  _toTagVideos(String tagsTitle, {required int type}) =>
      toNamed(Routes.tagVideos, arguments: {
        'tagsTitle': tagsTitle,
        'type': type,
      });

  toMessageDetail({required int toUserId}) =>
      toNamed(Routes.mineMessageDetail, arguments: {
        'toUserId': toUserId,
      });
}
