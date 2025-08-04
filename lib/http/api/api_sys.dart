/*
 * @Author: wangdazhuang
 * @Date: 2024-09-23 14:09:31
 * @LastEditTime: 2024-10-16 22:51:20
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/src/http/api/api_sys.dart
 */
part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiSys on _Api {
  /// 系统消息
  Future<List<SystemNoticeModel>?> fetchSystemNotice(
      {required int page, required int pageSize}) async {
    try {
      final resp = await httpInstance.get<SystemNoticeModel>(
        url: 'information/sys/notice',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: SystemNoticeModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<String> getNewCustomerService(String domain, String deviceId) async {
    try {
      final response = await httpInstance.get(
        url: '${domain}news/customer/sign/tourists',
        queryMap: {
          'deviceId': deviceId,
        },
        complete: ServiceModel.fromJson,
      );
      if (response != null) {
        ServiceModel serviceModel = response;
        return serviceModel.signUrl ?? "";
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  ///系统公共(需要获取里面的精品应用--appCenterUrl)
  Future<String> getRecommendH5Url() async {
    try {
      final response = await httpInstance.get(
        url: 'url/recommend/getH5Url',
      );
      String url = response['url'];
      return url;
    } catch (e) {
      return "";
    }
  }

  ///永久网址
  Future<List<PermanentAddressModel>> getPermanentAddress() async {
    try {
      final response = await httpInstance.get(
        url: 'sys/getPermanentAddress',
        complete: PermanentAddressModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  Future<ProvincesCityModel?> getProvincesCityData() async {
    try {
      final response = await httpInstance.get(
        url: 'region/regionList',
        complete: ProvincesCityModel.fromJson,
      );
      return response;
    } catch (e) {
      return null;
    }
  }
}
