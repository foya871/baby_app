part of 'api.dart';

extension ApiReward on _Api {
  ///获取应用推荐
  ///labelType: 0就展示上面的官方推荐 1就展示下面的热门应用
  Future<List<ApplicationPartnerChildModel>> getAdList(
      {required int labelType}) async {
    try {
      final resp = await httpInstance.get<ApplicationPartnerChildModel>(
        url: 'sys/partner/list',
        queryMap: {
          'labelType': labelType,
        },
        complete: ApplicationPartnerChildModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  ///获取福利明细
  ///福利页面上半部分的内容
  Future<List<RewardModel>> getReward() async {
    try {
      final response = await httpInstance.get(
          url: 'dailyFitUser/fitUserInfo', complete: RewardModel.fromJson);
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///获取福利顶部内容
  Future<ActivityModel?> getDeduct() async {
    try {
      final response = await httpInstance.get(
          url: 'deduct/type', complete: ActivityModel.fromJson);
      return response;
    } catch (e) {
      return null;
    }
  }

  /// 获取积分兑换列表
  /// 福利页面下半部分的内容
  Future<List<PointModel>> getPointList() async {
    try {
      final response = await httpInstance.get(
          url: 'PrizeRedemption/list', complete: PointModel.fromJson);
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  /// 获取福利页最下面的视频列表
  Future<List<VideoBaseModel>> getFreeVideoList(
      {int page = 1,
      int pageSize = 4,
      RewardVideoRuleType type = RewardVideoRuleType.none}) async {
    try {
      var queryMap = {
        'page': page,
        'pageSize': pageSize,
      };
      if (type != RewardVideoRuleType.none) {
        queryMap['sortType'] = type.type;
      }
      final response = await httpInstance.get(
          url: 'video/getFreeVideo',
          queryMap: queryMap,
          complete: VideoBaseModel.fromJson);
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  /// 点击兑换积分
  /// 点击兑换
  Future<bool> exchangePoint(PointModel model) async {
    dynamic result;
    try {
      result = await httpInstance.post(
          url: 'PrizeRedemption/clickRedeem', body: model.toJson());
    } catch (e) {}
    return result != null;
  }

  ///获取积分奖励列表
  ///已经兑换的明细
  Future<List<RewardModel>> getRewardRecord(
      {required int page, required int pageSize}) async {
    try {
      final response = await httpInstance.get(
          url: 'dailyFitUser/rewardInfo',
          queryMap: {
            "page": page,
            "pageSize": pageSize,
          },
          complete: RewardModel.fromJson);
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///用户上报，点击福利应用，就上报
  void userReport({required int dailyBenefitNum}) async {
    try {
      await httpInstance.get(
          url: 'dailyFitUser/udpFitUser',
          queryMap: {'dailyBenefitNum': dailyBenefitNum});
    } catch (e) {}
  }
}
