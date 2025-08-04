/*
 * @Author: wdz
 * @Date: 2025-05-21 18:51:12
 * @LastEditTime: 2025-06-28 09:16:40
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/http/api/api.dart
 */
import 'dart:typed_data';
import 'package:baby_app/model/blogger_base_model.dart';
import 'package:baby_app/model/comment/comment_send_model.dart';
import 'package:baby_app/model/announcement/activity_model.dart';
import 'package:baby_app/model/classify/classify_hot_model.dart';
import 'package:baby_app/model/comment/comment_dynamic_model.dart';
import 'package:baby_app/model/comment/comment_model.dart';
import 'package:baby_app/model/message/chat_list_model.dart';
import 'package:baby_app/model/message/message_model.dart';
import 'package:baby_app/model/message/message_notice_model.dart';
import 'package:baby_app/model/community/topic_classify_model.dart';
import 'package:baby_app/model/message/send_message_model.dart';
import 'package:baby_app/model/mine/withdrawal_record_model.dart';
import 'package:dio/dio.dart';
import 'package:baby_app/components/pay/model/vip_gold_type_model.dart';
import 'package:baby_app/model/attention/attenion_models.dart';
import 'package:baby_app/model/blogger/blogger_video_collection.dart';
import 'package:baby_app/model/community/archive_model.dart';
import 'package:baby_app/model/community/community_classify_model.dart';
import 'package:baby_app/model/community/community_release_model.dart';
import 'package:baby_app/model/community/community_topic_model.dart';
import 'package:baby_app/model/daily_fit_user_circles.dart'
    show DailyFitUserCircles, CheckinGiftList;

import 'package:baby_app/model/meet/meet_comment_list_model.dart';
import 'package:baby_app/model/meet/meet_user_detail_model.dart';
import 'package:baby_app/model/meet/meet_user_list_model.dart';
import 'package:baby_app/model/meet/region_list_model.dart';
import 'package:baby_app/model/meet/unlock_record_model.dart';
import 'package:baby_app/model/mine/attention_model.dart';
import 'package:baby_app/model/mine/fans_follower_model.dart';
import 'package:baby_app/model/mine/permanent_address_model.dart';
import 'package:baby_app/model/mine/redeem_vip_model.dart';
import 'package:baby_app/model/mine/system_notice_model.dart';
import 'package:baby_app/model/mine/withdraw_config_model.dart';
import 'package:baby_app/model/user/user_info_model.dart';
import 'package:baby_app/utils/logger.dart';
import 'package:http_service/http_service.dart';
import 'package:json2dart_safe/json2dart.dart';

import '../../model/ai/ai_models.dart';

import '../../model/application/application_partner_child_model.dart';
import '../../model/classify/classify_models.dart';
import '../../model/community/community_model.dart';
import '../../model/content_model.dart';
import '../../model/daily_fit_user_circles.dart' show DailyFitUserCircles;
import '../../model/mine/buy_dynamic.dart';
import '../../model/mine/official_community_model.dart';
import '../../model/mine/profit_dynamic_item_model.dart';
import '../../model/mine/promote_income_stat_model.dart';
import '../../model/mine/proxy_record_model.dart';
import '../../model/mine/record_model.dart';
import '../../model/mine/service_model.dart';
import '../../model/mine/share_link_model.dart';
import '../../model/mine/share_record_model.dart';
import '../../model/mine/topic_item_model.dart';
import '../../model/notice/notice_num_model.dart';
import '../../model/play/cdn_model.dart';
// import '../../model/play/time_discount_model.dart';
import '../../model/play/video_detail_model.dart';
import '../../model/reward/point_model.dart';
import '../../model/reward/reward_model.dart';
import '../../model/search/search_hot_spot_model.dart';
import '../../model/search/search_result_model.dart';
import '../../model/search/search_title_model.dart';
import '../../model/station_model.dart';
import '../../model/sys/provinces_city_model.dart';
import '../../model/tags_model.dart';
import '../../model/user/Proxy_model.dart';
import '../../model/video_actress_model.dart';
import '../../model/video_base_model.dart';
import '../../utils/consts.dart';
import '../../utils/enum.dart';
import '../service/api_code.dart';

part 'api_activity.dart';
part 'api_ai.dart';
part 'api_classify.dart';
part 'api_collection.dart';
part 'api_community.dart';
part 'api_content.dart';
part 'api_meet.dart';
part 'api_mine.dart';
part 'api_short_player.dart';
part 'api_sys.dart';
part 'api_user.dart';
part 'api_video.dart';
part 'api_search.dart';
part 'api_message.dart';
part 'api_reward.dart';

class _Api {}

// ignore: non_constant_identifier_names
final Api = _Api();
