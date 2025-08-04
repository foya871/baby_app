/*
 * @Author: chentuan guotengda7204@gmail.com
 * @Date: 2025-03-21 10:43:04
 * @LastEditors: chentuan guotengda7204@gmail.com
 * @LastEditTime: 2025-03-24 12:12:51
 * @FilePath: /dou_yin_jie_mi_app/lib/http/api/api_meet.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

part of 'api.dart';

extension ApiMeet on _Api {
  Future<List<MeetUserListModel>?> fetchMeetUserListByCityName(
      String cityName) async {
    try {
      final resp = await httpInstance.get(
          url: "meet/user/list",
          queryMap: {"cityName": cityName},
          complete: MeetUserListModel.fromMap);
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<MeetUserDetailModel?> fetchMeetUserDetailById(int id) async {
    try {
      final resp = await httpInstance.get(
          url: "meet/user/detail",
          queryMap: {"meetUserId": id},
          complete: MeetUserDetailModel.fromMap);
      return resp;
    } catch (e) {
      return null;
    }
  }

  Future<bool> setMeetUserUnlikeId(String id) async {
    try {
      await httpInstance.post(
        url: "meet/user/unlike",
        body: {"meetUserId": id},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<UnlockRecordModel>?> fetchUnlockRecords(int page,
      {int pageSize = 20}) async {
    try {
      final resp = await httpInstance.get(
          url: "meet/user/myUnlockList",
          queryMap: {"page": "$page", "pageSize": "$pageSize"},
          complete: UnlockRecordModel.fromMap);
      return resp;
    } catch (e) {
      return null;
    }
  }

  Future<List<UnlockRecordModel>?> fetchCityList(int page,
      {int pageSize = 20}) async {
    try {
      final resp = await httpInstance.get(
          url: "meet/user/myUnlockList",
          queryMap: {"page": "$page", "pageSize": "$pageSize"},
          complete: UnlockRecordModel.fromMap);

      return resp;
    } catch (e) {
      return null;
    }
  }

  Future<RegionListModel?> fetchRegionList() async {
    try {
      final resp = await httpInstance.get(
          url: "region/regionList", complete: RegionListModel.fromMap);
      return resp;
    } catch (e) {
      return null;
    }
  }

  Future<String?> setMeetUserUnlock(int id, int payType) async {
    try {
      final resp = await httpInstance.post(
          url: "meet/user/unlock",
          body: {
            "meetUserId": id,
            "payType": payType,
          },
          complete: (map) {
            return "${map["contactDtl"]}";
          });
      return resp;
    } catch (e) {
      return null;
    }
  }

  Future<void> meetReportSubmit(
      {required int meetUserId,
      required int reasonType,
      String? otherReason,
      List<String>? images}) async {
    final params = {
      'meetUserId': meetUserId,
      'reasonType': reasonType,
      'otherReason': otherReason,
      'images': images,
    };

    if (images == null || images.isEmpty) {
      params.remove('images');
    }

    if (otherReason == null || otherReason.isEmpty) {
      params.remove('otherReason');
    }

    try {
      await httpInstance.post(url: "meet/user/custom/complaint", body: params);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MeetCommentListModel>> fetchCommentList(
      int meetUserId, int parentId, int page,
      {int pageSize = 20}) async {
    try {
      final resp = await httpInstance.get(
          url: "meet/user/custom/commentList",
          queryMap: {
            "meetUserId": meetUserId,
            "parentId": parentId,
            "page": page,
            "pageSize": pageSize
          },
          complete: MeetCommentListModel.fromMap);
      return resp;
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveComment(
    String content,
    int meetUserId,
    int parentId,
    int topId,
    String img,
  ) async {
    try {
      final result = await httpInstance.post(
        url: "meet/user/custom/saveComment",
        body: {
          "content": content,
          "img": img,
          "meetUserId": meetUserId,
          "parentId": parentId,
          "topId": topId
        },
      );
      logger.i(result);
      return true;
    } catch (e) {
      return false;
    }
  }
}
