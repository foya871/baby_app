part of 'api.dart';

extension ApiMine on _Api {
  ///用户注册||用户登陆
  ///[isRegister] true 注册   false 登陆
  Future<UserInfo?> userRegisterLogin({
    required isRegister,
    required String account,
    required String password,
  }) async {
    try {
      final response = await httpInstance.post(
        url: isRegister ? 'user/register' : 'user/account/login',
        body: {'account': account, 'password': password},
        complete: UserInfo.fromJson,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  ///修改资料
  Future<bool> modifyInfo({
    String? age,
    String? bgImg,
    String? code,
    int? gender,
    String? logo,
    String? nickName,
    String? personSign,
  }) async {
    Map<String, dynamic> body = {};
    if (age != null && age.isNotEmpty) {
      body['age'] = age;
    }
    if (bgImg != null && bgImg.isNotEmpty) {
      body['bgImg'] = bgImg;
    }
    if (code != null && code.isNotEmpty) {
      body['code'] = code;
    }
    if (gender != null && gender != 0) {
      body['gender'] = gender;
    }
    if (logo != null && logo.isNotEmpty) {
      body['logo'] = logo;
    }
    if (nickName != null && nickName.isNotEmpty) {
      body['nickName'] = nickName;
    }
    if (personSign != null && personSign.isNotEmpty) {
      body['personSign'] = personSign;
    }

    try {
      await httpInstance.post(
        url: 'user/modify/info',
        body: body,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///用户推广统计
  Future<PromoteIncomeStatModel?> getPromoteIncomeStat() async {
    try {
      final response = await httpInstance.get(
        url: 'user/promoteIncomeStat',
        complete: PromoteIncomeStatModel.fromJson,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  ///获取推广收益列表
  Future<List<ProfitDynamicItemModel>> getCommunityIncomeStat(
      {required int page, int pageSize = 20}) async {
    try {
      final response = await httpInstance.get(
        url: 'community/dynamic/user/incomeStat',
        queryMap: {'page': page, 'pageSize': pageSize},
        complete: ProfitDynamicItemModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///帖子收益详情
  Future<List<BuyDynamic>> getBuyDynamicDetails({
    required int dynamicId,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'community/dynamic/user/purDetails',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'dynamicId': dynamicId,
        },
        complete: BuyDynamic.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///获取分享链接
  Future<List<ShareRespModel>> getShareLink() async {
    try {
      final response = await httpInstance.get(
        url: 'user/shared/link',
        requestEntireModel: false,
        complete: ShareRespModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  ///用户推广记录
  Future<List<ShareRecordModel>> getShareRecordList({
    required int page,
    int pageSize = 30,
    DateTime? searchTime,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'user/getUserProcess',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          if (searchTime != null) 'searchTime': searchTime,
        },
        complete: ShareRecordModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///代理用户业绩明细
  Future<List<ProxyRecordModel>> getProxyRecordList({
    required int page,
    int pageSize = 30,
    DateTime? createdAt,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'user/proxy/data/dtl',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          if (createdAt != null) 'createdAt': createdAt,
        },
        complete: ProxyRecordModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///会员卡和金币列表
  Future<VipGoldTypeModel?> getVipGoldCards() async {
    try {
      final response = await httpInstance.get(
        url: 'user/vip/card/list',
        complete: VipGoldTypeModel.fromJson,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  ///获取充值记录
  ///[tranType] 2:VIP记录 3:金币记录
  Future<List<RecordModel>> geRechargeRecordList({
    required int tranType,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final response = await httpInstance.get<RecordModel>(
        url: 'tran/view/list',
        queryMap: {
          'tranType': tranType,
          'page': page,
          'pageSize': pageSize,
        },
        complete: RecordModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///获取提现配置
  Future<WithdrawConfigModel?> getWithdrawalConfig() async {
    try {
      List<WithdrawConfigModel>? response = await httpInstance.get(
        url: "wd/config",
        complete: WithdrawConfigModel.fromJson,
      );
      if (response == null || response.isEmpty) {
        return null;
      }
      return response.first;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  ///申请提现
  ///[payType]提现方式 (0-余额; 1-支付宝; 2-微信; 3-云闪付)
  ///[purType]提现货币类型 (1-余额; 2-金币)
  ///[accountNo]收款人账号
  ///[receiptName]收款人姓名
  Future<bool> applyWithdrawal({
    required String money,
    required String receiptName,
    required String accountNo,
    required int payType,
    required int purType,
  }) async {
    try {
      await httpInstance.post(
        url: "wd/apply",
        body: {
          "accountNo": accountNo,
          "money": money,
          "payType": payType,
          "purType": purType,
          "receiptName": receiptName
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///获取提现记录
  Future<List<WithdrawalRecordModel>> getWithdrawalRecord({
    required int page,
    int pageSize = 10,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'wd/record',
        queryMap: {'page': page, 'pageSize': pageSize},
        complete: WithdrawalRecordModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///获取我的相关的综合数据
  ///[type] 1:我的收藏 2:我的浏览 3:我的购买 4:我的点赞
  Future<SearchResultModel?> getMyIntegrates({
    required int type,
    required int sign,
    required int page,
    int pageSize = 30,
  }) async {
    final url = type == 1
        ? 'search/favoriteList'
        : type == 2
            ? 'search/historyRecordList'
            : type == 3
                ? 'search/purRecordList'
                : 'search/likeList';
    try {
      final response = await httpInstance.get(
        url: url,
        queryMap: {
          'sign': sign,
          'page': page,
          'pageSize': pageSize,
        },
        complete: SearchResultModel.fromJson,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  ///关注列表、粉丝列表
  ///[isFans] true 粉丝列表  false 关注列表
  Future<List<FansFollowerModel>> getFansFollowers({
    required bool isFans,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      List<FansFollowerModel> response = await httpInstance.get(
        url: isFans ? 'user/fansList' : 'user/attentionList',
        queryMap: {'page': page, 'pageSize': pageSize},
        complete: FansFollowerModel.fromJson,
      );

      return response;
    } catch (e) {
      return [];
    }
  }

  ///获取个人动态列表(仅限查选个人相关的)
  ///[circleType] 0-社区动态 1-乱伦汇动态
  ///[sortType] 0-综合 1-最新 2-播放最多 3-收藏最多
  ///[status] 1-审核中，2-审核通过，3-审核拒绝
  Future<List<CommunityModel>> getPersonDynamicList({
    required int page,
    int pageSize = 30,
    int circleType = 0,
    int? sortType,
    int status = 2,
    int? userId,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'community/dynamic/person/list',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'type': circleType,
          if (sortType != null) 'sortType': sortType,
          'status': status,
          if (userId != null) 'userId': userId,
        },
        complete: CommunityModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///领取兑换
  Future<bool> redeemVip({required String code}) async {
    try {
      await httpInstance.post(
        url: 'user/redeem/vip',
        body: {'reCode': code},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///获取兑换记录
  Future<List<RedeemVipModel>> getRedeemRecord(
      {required int page, int pageSize = 30}) async {
    try {
      final response = await httpInstance.get(
        url: 'user/redeemRecord',
        queryMap: {'page': page, 'pageSize': pageSize},
        complete: RedeemVipModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///加群开车 商务合作
  Future<List<OfficialCommunityModel>> getOfficialGroup() async {
    try {
      final response = await httpInstance.get(
        url: 'sys/group/list',
        complete: OfficialCommunityModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///加群开车 商务合作
  Future<List<TopicSubscribeItemModel>> getSubscribeTopicList(
      {required int page, int pageSize = 20}) async {
    try {
      final response = await httpInstance.get(
        url: 'topic/subscribe/list',
        queryMap: {'page': page, 'pageSize': pageSize},
        complete: TopicSubscribeItemModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  /// 获取收藏视频
  Future<List<VideoBaseModel>?> fetchFavOrBuyVideoList(
      {required int page, required int pageSize, bool isBuy = false}) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: isBuy ? "video/userPurVideo" : 'video/userFavorites',
        queryMap: {'page': page, 'pageSize': pageSize, "videoMark": 1},
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  /// 获取收藏或者购买的视频
  Future<List<CommunityModel>?> fetchFavOrBuyCommunityList(
      {required int page, required int pageSize, bool isBuy = false}) async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: isBuy
            ? "community/dynamic/user/purList"
            : 'community/dynamic/userFavorite',
        queryMap: {'page': page, 'pageSize': pageSize},
        complete: CommunityModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }
}
