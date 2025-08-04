/*
 * @Author: wangdazhuang
 * @Date: 2025-02-19 19:31:35
 * @LastEditTime: 2025-03-15 10:03:26
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/utils/enum.dart
 */
// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:baby_app/generate/app_image_path.dart';

// 视频排序
typedef VideoSortType = int;

abstract class VideoSortTypeEnum {
  static const VideoSortType none = 0;
  static const VideoSortType latest = 1; // 最近更新
  static const VideoSortType mostPlayed = 2; // 最多观看(播放)
  static const VideoSortType mostFav = 3; // 最多喜欢
}

enum VideoLayout { small, big }

typedef ClassifyVideoType = int;

abstract class CliassifyVideoTypeEnum {
  static const ClassifyVideoType none = 0;
  static const ClassifyVideoType horzontal = 1; // 每行2个(横版)
  static const ClassifyVideoType vertical = 2; // 每行3个(竖版)
}

// 视频的分类类型
typedef ShiPinClassifyType = int;

///0-免费、1-vip、2-付费 3-短视频 4-禁区
abstract class ShiPinClassifyTypeEnum {
  static const ShiPinClassifyType free = 0;
  static const ShiPinClassifyType vip = 1;
  static const ShiPinClassifyType pay = 2;
  static const ShiPinClassifyType short = 3;
  static const ShiPinClassifyType forbidden = 4;
}

enum StationDetailStyle { horizontal, vertical, rank }

// 频道样式
typedef StationType = int;

abstract class StationTypeEnum {
  static const StationType none = 0;
  static const StationType h2WithHead = 1; // 第一个单独占一行，其余每行显示2个
  static const StationType h2 = 2; // 横版4宫格，每行显示2个（两行,4个）
  static const StationType h2_3 = 3; // 横版6宫格，同h2 (三行,6个)
  static const StationType v3 = 4; // 竖版6宫格，每行显示3个
  static const StationType v2 = 5; // 竖版6宫格，每行显示2个
  static const StationType saleRank = 6; // 销售排行
  static const StationType playRank = 7; // 播放排行
  static const StationType favRank = 8; // 收藏排行

  static bool isRank(StationType type) =>
      type == saleRank || type == playRank || type == favRank;

  // 需要显示 查看更多和换一换 的类型
  static bool showMoreAndChange(StationType type) =>
      type == h2WithHead || type == h2 || type == h2_3 || isRank(type);

  // 详情页是否使用横版样式
  static StationDetailStyle getDetailStyle(StationType type) {
    if (type == v3 || type == v2) {
      return StationDetailStyle.vertical;
    } else if (isRank(type)) {
      return StationDetailStyle.rank;
    } else {
      return StationDetailStyle.horizontal;
    }
  }

  //换一换pageSize
  static int pageSize(StationType type) => switch (type) {
        h2WithHead => 5,
        h2 => 4,
        h2_3 => 6,
        v3 => 6,
        v2 => 6,
        saleRank => 4,
        playRank => 4,
        favRank => 4,
        _ => 0,
      };
}

typedef AiTabName = String;

abstract class AiTabNameEnum {
  static const AiTabName index = 'index';
  static const AiTabName cloth = 'cloth';
  static const AiTabName faceImage = 'faceImage';
  static const AiTabName faceVideo = 'faceVideo';
  static const AiTabName faceCustom = 'faceCustom';
}

typedef VideoTypeEnum = int;

///视频类型：0-普通视频 1-VIP视频 2-付费视频
abstract class VideoTypeValueEnum {
  static const VideoTypeEnum Commmon = 0;

  static const VideoTypeEnum VIP = 1;

  static const VideoTypeEnum Pay = 2;
}

///不能关于原因 1-无次数 2-需要付费 3-需要vip 4-无粉丝团门票
typedef VideoReasonTypeEnum = int;

abstract class VideoReasonTypeValueEnum {
  // static const VideoReasonTypeEnum HaveNoTimes = 1;

  static const VideoReasonTypeEnum NeedPay = 2;

  static const VideoReasonTypeEnum VIP = 3;

// static const VideoReasonTypeEnum Luoli = 4;
}

///关联视频描述类型: 1-点击观看原片 2-点击观看解说版
typedef RSVideoDescType = int;

abstract class RSVideoDescTypeValueEnum {
  static const RSVideoDescType original = 1;

  static const RSVideoDescType speak = 2;
}

// 博主性别
typedef UserGenderType = int;

abstract class UserGenderTypeEnum {
  static const UserGenderType none = 0;
  static const UserGenderType female = 1; // 女
  static const UserGenderType male = 2; // 男
  static const UserGenderType third = 3; // 中性
}

// 视频Mark
typedef VideoMarkType = int;

abstract class VideoMarkTypeEnum {
  static const VideoMarkType none = 0;
  static const VideoMarkType long = 1; // 长视频
  static const VideoMarkType short = 2; // 短视频
}

typedef UserUpType = int;

///博主类型 1普通up 2-明星 3-出品方
abstract class UserUpTypeEnum {
  static const UserUpType common = 1;
  static const UserUpType star = 2;
  static const UserUpType producer = 3;
}

typedef VipType = int;

/// VIP 类型
abstract class VipTypeEnum {
  static const VipType none = 0;

  static const VipType forbiddenMonth = 7; // 禁区月卡
  static const VipType forbiddenYear = 8; // 禁区年卡
}

/// AI绘画tab页样式
typedef AiDrawPromptShowType = int;

abstract class AiDrawPromptShowTypeEnum {
  static const AiDrawPromptShowType none = 0;
  static const AiDrawPromptShowType text = 1; // warp text
  static const AiDrawPromptShowType image = 2; // 一排三个图片
}

// AI 脱衣类型
typedef AiClothType = int;

abstract class AiClothTypeEnum {
  static const AiClothType none = 0;
  static const AiClothType shangYi = 1; // 掀起上衣
  static const AiClothType biJiNi = 2; // 比基尼
  static const AiClothType shaQun = 3; // 透明纱裙
  static const AiClothType qiPao = 4; // 透明旗袍
}

// AI 换脸
typedef AiFaceClassifyType = int;

abstract class AiFaceClassifyTypeEnum {
  static const AiFaceClassifyType none = 0;
  static const AiFaceClassifyType image = 1; // 图片
  static const AiFaceClassifyType video = 2; // 视频
}

// AI 申诉状态
typedef AiAppealType = int;

abstract class AiAppealTypeEnum {
  static const AiAppealType none = 0; //未申诉
  static const AiAppealType appeal = 1; // 申诉
  static const AiAppealType repainting = 2; // 重绘中
  static const AiAppealType repaintOk = 3; // 重绘完成
  static const AiAppealType reapintFail = 4; // 重绘失败
  static const AiAppealType reject = 5; // 驳回
  static const AiAppealType kf = 6; // 转人工处理
  static const AiAppealType kfDone = 7; // 人工完成

  static String name(AiAppealType? type) => switch (type) {
        none => '申诉', // 这里状态是未申诉，显示为申诉
        appeal => '申诉中',
        repainting => '重绘中',
        repaintOk => '重绘完成',
        reapintFail => '重绘失败',
        reject => '驳回',
        kf => '人工处理',
        kfDone => '人工完成',
        _ => ''
      };
}

// 服务器有4种状态, 前端只有3种状态
enum AiRecordClientStatus { none, making, success, error }

// AI 记录状态
typedef AiRecordStatus = String;

abstract class AiRecordStatusEnum {
  static const AiRecordStatus none = '';
  static const AiRecordStatus send = 'send'; // 发送中
  static const AiRecordStatus received = 'received'; // 处理中
  static const AiRecordStatus success = 'success'; // 成功
  static const AiRecordStatus error = 'error'; // 失败

  static AiRecordClientStatus to(AiRecordStatus status) {
    return switch (status) {
      send || received => AiRecordClientStatus.making,
      success => AiRecordClientStatus.success,
      error => AiRecordClientStatus.error,
      _ => AiRecordClientStatus.none,
    };
  }
}

// AI消耗类型
enum AiCostType { fail, num, gold }

// 视频榜单类型
typedef ShiPinRankType = int;

class ShiPinRankTypeEnum {
  static const ShiPinRankType day = 1; // 每日精选
  static const ShiPinRankType week = 2; // 每周精选
  static const ShiPinRankType month = 3; // 每月精选
  static const ShiPinRankType total = 4; // 总榜精选
}

enum NoticeType {
  notice(1), //公告
  interaction(4), //互动
  praiseMe(6), //获赞
  ;

  final int type;

  const NoticeType(this.type);
}

enum SearchType {
  video(1), //视频
  post(2), //帖子
  city(3), //同城兼职
  topic(4), //话题
  comic(5), //漫画
  ;

  final int type;

  const SearchType(this.type);
}

enum VideoRuleType {
  complex(
    "综合排序",
    0,
  ),
  news("最新发布", 1),
  watch("最多观看", 2),
  like("最多点赞", 3),
  collect("最多收藏", 4),
  buy("最多购买", 5),
  ;

  final String title;
  final int type;

  const VideoRuleType(this.title, this.type);

  //获取Type
  static VideoRuleType fromTitle(String title) {
    return VideoRuleType.values.firstWhere((e) => e.title == title,
        orElse: () => VideoRuleType.complex);
  }
}

enum RewardVideoRuleType {
  none("", 0),
  news("最新", 1),
  hot("最热", 2),
  ;

  final String title;
  final int type;

  const RewardVideoRuleType(this.title, this.type);
}

enum RewardTopVip {
  coin(AppImagePath.reward_icon_vip_coin, '至尊金币', 100),
  ai(AppImagePath.reward_icon_reward_ai, 'AI科技', 500),
  game(AppImagePath.reward_icon_game, '成人游戏', 1000),
  ;

  final String image;
  final String title;
  final int price;

  const RewardTopVip(this.image, this.title, this.price);
}

enum PortrayRuleType {
  mostCollect(
    "最多收藏",
    1,
  ),
  latestArrival("最新上架", 2),
  mostViewed("最多观看", 3),
  ;

  final String title;
  final int type;

  const PortrayRuleType(this.title, this.type);

  //获取Type
  static PortrayRuleType fromTitle(String title) {
    return PortrayRuleType.values.firstWhere((e) => e.title == title,
        orElse: () => PortrayRuleType.mostCollect);
  }
}

enum GameRuleType {
  latest(
    "最新",
    2,
  ),
  hottest("最热", 1),
  bestSellers("畅销", 3),
  ;

  final String title;
  final int type;

  const GameRuleType(this.title, this.type);

  //获取Type
  static GameRuleType fromTitle(String title) {
    return GameRuleType.values
        .firstWhere((e) => e.title == title, orElse: () => GameRuleType.latest);
  }
}

enum GameHostType {
  all(
    "Android/pc",
    0,
  ),
  android("Android", 1),
  pc("pc", 2),
  ;

  final String title;
  final int type;

  const GameHostType(this.title, this.type);

  //获取Type
  static GameHostType fromTitle(int? type) {
    return GameHostType.values
        .firstWhere((e) => e.type == type, orElse: () => GameHostType.all);
  }
}

enum FilterVideoLongType {
  noLimit("不限", -1, -1),
  min3("3分钟以内", -1, 3 * 60),
  min3to5("3-5分钟", 3 * 60, 5 * 60),
  min5to15("5-15分钟", 5 * 60, 15 * 60),
  min15to30("15-30分钟", 15 * 60, 30 * 60),
  min30to60("30-60分钟", 30 * 60, 60 * 60),
  min60("60分钟以上", 60 * 60, -1),
  ;

  final String title;
  final int startDuration;
  final int endDuration;

  const FilterVideoLongType(this.title, this.startDuration, this.endDuration);

  //获取Type
  static FilterVideoLongType fromTitle(String title) {
    return FilterVideoLongType.values.firstWhere((e) => e.title == title,
        orElse: () => FilterVideoLongType.noLimit);
  }
}

enum AiPickImageStep {
  waitSelect,
  waitSubmit,
  submitted,
}
