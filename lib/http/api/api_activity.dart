/*
 * @Author: momomo1123
 * @Date: 2025-04-17 15:09:31
 * @Description: 
 * @FilePath: /baby_app/lib/http/api/api_activity.dart
 */
part of 'api.dart';

extension ApiApplication on _Api {
  /// 获取合作伙伴列表
  Future<List<ApplicationPartnerChildModel>> fetchPartnerByClassifyId({
    required int classifyId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<ApplicationPartnerChildModel>(
        url: 'sys/partner/list',
        queryMap: {
          'classifyId': classifyId,
          'page': page,
          'pageSize': pageSize,
        },
        complete: ApplicationPartnerChildModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  /// 获取商务合作
  Future<String> getContact() async {
    try {
      final resp = await httpInstance.get<OfficialCommunityModel>(
          url: 'sys/group/list', complete: OfficialCommunityModel.fromJson);
      final match = (resp as List)
          .whereType<OfficialCommunityModel?>()
          .firstWhere((item) => item?.type == 2, orElse: () => null);
      return match?.link ?? "";
    } catch (e) {
      return "";
    }
  }
}
