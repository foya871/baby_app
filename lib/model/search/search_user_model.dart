/*
 * @Author: ziqi jhzq12345678
 * @Date: 2025-01-17 15:32:59
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2025-01-17 15:33:46
 * @FilePath: /baby_app/lib/model/search/search_user_model.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
class SearchUserModel {
  bool? attention;
  String? logo;
  String? nickName;
  int? userId;

  SearchUserModel({attention, logo, nickName, userId});

  SearchUserModel.fromJson(Map<String, dynamic> json) {
    attention = json['attention'];
    logo = json['logo'];
    nickName = json['nickName'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attention'] = attention;
    data['logo'] = logo;
    data['nickName'] = nickName;
    data['userId'] = userId;
    return data;
  }
}
