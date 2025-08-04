part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiUser on _Api {
  /// 关注或者取消关注
  ///[isAttention] true 已关注 false 未关注
  Future<bool> followOrUnfollow(
      {required int toUserId, required isAttention}) async {
    try {
      await httpInstance.post(
        url: isAttention ? 'user/attention/cancel' : 'user/attention',
        body: {'toUserId': toUserId},
      );
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future<bool> getFollowStatus({required int toUserId}) async {
    try {
      final resp = await httpInstance.get<AttentionModel>(
          url: 'user/isAttention',
          queryMap: {'toUserId': toUserId},
          complete: AttentionModel.fromJson);
      return resp.attention ?? false;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  ///提交邀请码
  Future<bool> submitInviteCode({required String inviteCode}) async {
    try {
      await httpInstance.post(
        url: 'user/bind/inviteCode',
        body: {'inviteCode': inviteCode},
      );
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  ///代理用户业绩
  Future<ProxyModel?> proxyData() async {
    try {
      final resp = await httpInstance.get(
        url: 'user/promoteIncomeStat',
        complete: ProxyModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }
}
