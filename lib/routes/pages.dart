/*
 * @Author: wangdazhuang
 * @Date: 2024-08-16 16:31:12
 * @LastEditTime: 2025-06-28 15:58:50
 * @LastEditors: Please set LastEditors
 * @Description: 
 * @FilePath: /baby_app/lib/routes/pages.dart
 */
import 'package:baby_app/components/image_viewer/image_viewer_bindings.dart';
import 'package:baby_app/components/image_viewer/image_viewer_page.dart';
import 'package:baby_app/launch_page.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/views/ai/bindings/ai_face_image_upload_page_bindings.dart';
import 'package:baby_app/views/ai/bindings/ai_face_video_upload_page_bindings.dart';
import 'package:baby_app/views/ai/bindings/ai_home_page_bindinds.dart';
import 'package:baby_app/views/ai/bindings/ai_record_page_bindings.dart';
import 'package:baby_app/views/ai/views/ai_face_image_upload_page.dart';
import 'package:baby_app/views/ai/views/ai_face_video_upload_page.dart';
import 'package:baby_app/views/ai/views/ai_home_page.dart';
import 'package:baby_app/views/ai/views/ai_record_page.dart';
import 'package:baby_app/views/community/blogger/blogger_detail_page.dart';
import 'package:baby_app/views/community/blogger/blogger_detail_page_controller.dart';
import 'package:baby_app/views/community/detail/community_detail_page.dart';
import 'package:baby_app/views/community/detail/community_detail_page_controller.dart';
import 'package:baby_app/views/community/release/community_release_page.dart';
import 'package:baby_app/views/community/release/community_release_page_controller.dart';
import 'package:baby_app/views/community/topic/topic_detail_page.dart';
import 'package:baby_app/views/community/topic/topic_detail_page_controller.dart';
import 'package:baby_app/views/main/bindings/main_bindings.dart';
import 'package:baby_app/views/main/views/main_page.dart';
import 'package:baby_app/views/mine/account_profile/account_credentials_controller.dart';
import 'package:baby_app/views/mine/change_icon/change_icon_page.dart';
import 'package:baby_app/views/mine/download/download_page_controller.dart';
import 'package:baby_app/views/mine/exchange/exchange_record_page.dart';
import 'package:baby_app/views/mine/feedback/feedback_page.dart';
import 'package:baby_app/views/mine/invite/invite_page.dart';
import 'package:baby_app/views/mine/message/message_controller.dart';
import 'package:baby_app/views/mine/message/message_detail/message_detail_controller.dart';
import 'package:baby_app/views/mine/message/message_detail/message_detail_page.dart';
import 'package:baby_app/views/mine/message/message_page.dart';
import 'package:baby_app/views/mine/mine_withdrawal/mine_withdrawal_record_page.dart';
import 'package:baby_app/views/mine/mine_withdrawal/withdrawal_page.dart';
import 'package:baby_app/views/mine/mine_withdrawal/withdrawal_page_controller.dart';
import 'package:baby_app/views/mine/original/mine_original_page.dart';
import 'package:baby_app/views/mine/setting/setting_page.dart';
import 'package:baby_app/views/mine/setting/setting_page_controller.dart';
import 'package:baby_app/views/mine/share/promotion_page.dart';
import 'package:baby_app/views/mine/share/share_data/share_data_list_controller.dart';
import 'package:baby_app/views/mine/share/share_data/share_data_list_view.dart';
import 'package:baby_app/views/mine/share/share_data/share_data_view.dart';
import 'package:baby_app/views/mine/share/share_page.dart';
import 'package:baby_app/views/mine/vip_wallet/income/income_details_page.dart';
import 'package:baby_app/views/mine/vip_wallet/income/income_details_page_controller.dart';
import 'package:baby_app/views/mine/vip_wallet/income/income_page_controller.dart';
import 'package:baby_app/views/mine/vip_wallet/recharge_record/recharge_record_page_controller.dart';
import 'package:baby_app/views/mine/vip_wallet/vip_page.dart';
import 'package:baby_app/views/mine/vip_wallet/wallet_page.dart';
import 'package:baby_app/views/no_signal/no_net_work_page.dart';
import 'package:baby_app/views/no_signal/no_signal.dart';
import 'package:baby_app/views/player/common_player_page.dart';
import 'package:baby_app/views/player/video_play_page.dart';
import 'package:baby_app/views/reward/exchange_reward_record/exchange_reward_record_controller.dart';
import 'package:baby_app/views/reward/exchange_reward_record/exchange_reward_record_view.dart';
import 'package:baby_app/views/reward/reward_container/reward_container_controller.dart';
import 'package:baby_app/views/reward/reward_container/reward_container_view.dart';
import 'package:baby_app/views/reward/reward_vip_video/reward_vip_video_controller.dart';
import 'package:baby_app/views/search/search_page.dart';
import 'package:baby_app/views/search/search_page_controller.dart';
import 'package:baby_app/views/search/search_result/search_result_page_controller.dart';
import 'package:baby_app/views/shi_pin/bindings/content/content_wh_bindings.dart';
import 'package:baby_app/views/shi_pin/bindings/rank/shi_pin_rank_page_bindings.dart';
import 'package:baby_app/views/shi_pin/bindings/station/station_detail_with_ranking_page_bindings.dart';
import 'package:baby_app/views/shi_pin/bindings/station/station_detail_with_sorting_page_bindings.dart';
import 'package:baby_app/views/shi_pin/views/content/content_wh_page.dart';
import 'package:baby_app/views/shi_pin/views/rank/shi_pin_rank_page.dart';
import 'package:baby_app/views/shi_pin/views/station/station_detail_with_ranking_page.dart';
import 'package:baby_app/views/shi_pin/views/station/station_detail_with_sorting_page.dart';
import 'package:baby_app/views/videotag/bindings/tag_videos_page_bindings.dart';
import 'package:baby_app/views/videotag/views/tag_videos_page.dart';
import 'package:get/get.dart';

import '../views/discover/sys_partner_app_list/view.dart';
import '../views/home/home_detail_list/home_detail_list_logic.dart'
    show HomeDetailListLogic;
import '../views/home/home_detail_list/home_detail_list_page.dart'
    show HomeDetailListPage;
import '../views/mine/account_profile/account_credentials_page.dart';
import '../views/mine/download/download_page.dart';
import '../views/mine/exchange/exchange_page.dart';
import '../views/mine/exchange/exchange_page_controller.dart';
import '../views/mine/exchange/exchange_record_page_controller.dart';
import '../views/mine/favorites/favorites_page.dart';
import '../views/mine/favorites/favorites_page_controller.dart';
import '../views/mine/follow/follow_page.dart';
import '../views/mine/follow/follow_page_controller.dart';
import '../views/mine/group/group_page.dart';
import '../views/mine/group/group_page_controller.dart';
import '../views/mine/history/history_page.dart';
import '../views/mine/history/history_page_controller.dart';
import '../views/mine/invite/invite_page_controller.dart';
import '../views/mine/like/like_page.dart';
import '../views/mine/like/like_page_controller.dart';
import '../views/mine/login_register/login_register_page.dart';
import '../views/mine/login_register/login_register_page_controller.dart';
import '../views/mine/mine_withdrawal/mine_withdrawal_record_page_controller.dart';
import '../views/mine/publish/publish_page.dart';
import '../views/mine/publish/publish_page_controller.dart';
import '../views/mine/purchase/purchase_page.dart';
import '../views/mine/purchase/purchase_page_controller.dart';
import '../views/mine/share/promotion_page_controller.dart';
import '../views/mine/share/share_page_controller.dart';
import '../views/mine/vip_wallet/income/income_page.dart';
import '../views/mine/vip_wallet/recharge_record/recharge_record_page.dart';
import '../views/mine/vip_wallet/vip_page_controller.dart';
import '../views/mine/vip_wallet/wallet_page_controller.dart';
import '../views/player/controllers/common_video_play_controller.dart';
import '../views/player/controllers/video_play_controller.dart';
import '../views/reward/reward_vip_video/reward_vip_video_view.dart';
import '../views/search/search_result/search_result_page.dart';

class Pages {
  Pages._();

  static final pages = [
    GetPage(name: Routes.no_net_work, page: () => const NoNetWorkPage()),
    GetPage(name: Routes.noSignal, page: () => const NoSignalPage()),
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
      binding: MainBindings(),
    ),
    GetPage(
      name: Routes.launch,
      page: () => const LaunchPage(),
    ),
    GetPage(
      name: Routes.homeDetailListPage,
      page: () => const HomeDetailListPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomeDetailListLogic());
      }),
    ),
    GetPage(
      name: Routes.videoplay,
      page: () => const VideoPlayPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<VideoPlayController>(() => VideoPlayController());
      }),
    ),
    GetPage(
      name: Routes.search,
      page: () => SearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SearchPageController());
      }),
    ),
    GetPage(
      name: Routes.searchResult,
      page: () => const SearchResultPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SearchResultPageController());
      }),
    ),
    GetPage(
      name: Routes.tagVideos,
      page: () => const TagVideosPage(),
      binding: TagVideosPageBindings(),
    ),
    GetPage(
      name: Routes.commonplayer,
      page: () => const CommonPlayerPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<CommonVideoPlayerController>(
            () => CommonVideoPlayerController());
      }),
    ),
    GetPage(
      name: Routes.stationDetailSorting,
      page: () => const StationDetailWithSortingPage(),
      binding: StationDetailWithSortingPageBindings(),
    ),
    GetPage(
      name: Routes.stationDetailRanking,
      page: () => const StationDetailWithRankingPage(),
      binding: StationDetailWithRankingPageBindings(),
    ),
    GetPage(
      name: Routes.imageviewer,
      page: () => const ImageViewer(),
      binding: ImageViewerBindings(),
    ),
    GetPage(
      name: Routes.reward,
      page: () => const RewardContainerPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => RewardContainerController());
      }),
    ),
    GetPage(
      name: Routes.rewardVideo,
      page: () => const RewardVipVideoPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => RewardVipVideoController());
      }),
    ),
    GetPage(
      name: Routes.exchangeRewardRecord,
      page: () => const ExchangeRewardRecordPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ExchangeRewardRecordController());
      }),
    ),
    ...ai,
    ...content,
    ...community,
    ...mine,
  ];

  static final ai = <GetPage>[
    GetPage(
      name: Routes.aiHome,
      page: () => const AiPage(),
      binding: AiHomePageBindinds(),
    ),
    GetPage(
      name: Routes.aiRecord,
      page: () => const AiRecordPage(),
      binding: AiRecordPageBindings(),
    ),
    GetPage(
      name: Routes.aiFaceImageUpload,
      page: () => const AiFaceImageUploadPage(),
      binding: AiFaceImageUploadPageBindings(),
    ),
    GetPage(
      name: Routes.aiFaceVideoUpload,
      page: () => const AiFaceVideoUploadPage(),
      binding: AiFaceVideoUploadPageBindings(),
    ),
  ];

  static final content = <GetPage>[
    GetPage(
      name: Routes.contentWh,
      page: () => const ContentWhPage(),
      binding: ContentWhPageBindings(),
    ),
    GetPage(
      name: Routes.rank,
      page: () => const ShiPinRankPage(),
      binding: ShiPinRankPageBindings(),
    ),
  ];

  static final community = <GetPage>[
    GetPage(
      name: Routes.topicDetail,
      page: () => const TopicDetailPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TopicDetailPageController());
      }),
    ),
    GetPage(
      name: Routes.communityRelease,
      page: () => const CommunityReleasePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CommunityReleasePageController());
      }),
    ),
    GetPage(
      name: Routes.bloggerDetail,
      page: () => const BloggerDetailPage(),
      binding: BindingsBuilder(() {
        final userId = int.tryParse(Get.parameters['userId'] ?? '') ?? 0;
        Get.lazyPut(() => BloggerDetailPageController(), tag: '$userId');
        // Get.lazyPut(() => BloggerDetailPageController());
      }),
    ),
    GetPage(
      name: Routes.communityDetail,
      page: () => const CommunityDetailPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CommunityDetailPageController());
      }),
    ),
  ];

  static final mine = [
    GetPage(
      name: Routes.mineSetting,
      page: () => const SettingPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SettingPageController());
      }),
    ),
    GetPage(
      name: Routes.mineLoginRegister,
      page: () => const LoginRegisterPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginRegisterPageController());
      }),
    ),
    GetPage(
      name: Routes.vip,
      page: () => const VipPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => VipPageController());
      }),
    ),
    GetPage(
      name: Routes.wallet,
      page: () => const WalletPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => WalletPageController());
      }),
    ),
    GetPage(
      name: Routes.mineRechargeRecord,
      page: () => const RechargeRecordPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => RechargeRecordPageController());
      }),
    ),
    GetPage(
      name: Routes.mineWithdrawalRecord,
      page: () => const MineWithdrawalRecordPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MineWithdrawalRecordPageController());
      }),
    ),
    GetPage(
      name: Routes.withdraw,
      page: () => const WithdrawalPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => WithdrawalPageController());
      }),
    ),
    GetPage(
      name: Routes.mineMyIncome,
      page: () => const IncomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => IncomePageController());
      }),
    ),
    GetPage(
      name: Routes.mineIncomeDetails,
      page: () => const IncomeDetailsPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => IncomeDetailsPageController());
      }),
    ),
    GetPage(
      name: Routes.share,
      page: () => const SharePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SharePageController());
      }),
    ),
    GetPage(
      name: Routes.minePromotion,
      page: () => const PromotionPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PromotionPageController());
      }),
    ),
    GetPage(
      name: Routes.mineFavorites,
      page: () => const FavoritesPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => FavoritesPageController());
      }),
    ),
    GetPage(
      name: Routes.mineHistory,
      page: () => const HistoryPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HistoryPageController());
      }),
    ),
    GetPage(
      name: Routes.minePurchase,
      page: () => const PurchasePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PurchasePageController());
      }),
    ),
    GetPage(
      name: Routes.mineFollow,
      page: () => const FollowPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => FollowPageController());
      }),
    ),
    GetPage(
      name: Routes.mineOriginalPage,
      page: () => const MineOriginalPage(),
    ),
    GetPage(
      name: Routes.mineAppRecommend,
      page: () => const SysPartnerAppListView(),
    ),
    GetPage(
      name: Routes.mineAccountProfile,
      page: () => const AccountCredentialsPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AccountCredentialsController());
      }),
    ),
    GetPage(
      name: Routes.minePublish,
      page: () => const PublishPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PublishPageController());
      }),
    ),
    GetPage(
      name: Routes.mineLike,
      page: () => const LikePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LikePageController());
      }),
    ),
    GetPage(
      name: Routes.mineExchange,
      page: () => const ExchangePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ExchangePageController());
      }),
    ),
    GetPage(
      name: Routes.mineExchangeRecord,
      page: () => const ExchangeRecordPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ExchangeRecordPageController());
      }),
    ),
    GetPage(
      name: Routes.mineGroup,
      page: () => const GroupPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => GroupPageController());
      }),
    ),
    GetPage(
      name: Routes.mineMessage,
      page: () => const MessagePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MessageController());
      }),
    ),
    GetPage(
      name: Routes.mineMessageDetail,
      page: () => const MessageDetailPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MessageDetailController());
      }),
    ),
    GetPage(
      name: Routes.mineChangeIcon,
      page: () => const ChangeIconPage(),
    ),
    GetPage(
        name: Routes.mineInvitePage,
        page: () => const InvitePage(),
        binding:
            BindingsBuilder(() => Get.lazyPut(() => InvitePageController()))),
    GetPage(
        name: Routes.mineDownloadPage,
        page: () => const DownloadPage(),
        binding:
            BindingsBuilder(() => Get.lazyPut(() => DownloadPageController()))),
    GetPage(
      name: Routes.mineFeedback,
      page: () => const FeedbackPage(),
    ),
    GetPage(
      name: Routes.sharedata,
      page: () => ShareDataPage(),
    ),
    GetPage(
      name: Routes.sharedatalist,
      page: () => const ShareDataListPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ShareDataListController());
      }),
    ),
  ];
}
