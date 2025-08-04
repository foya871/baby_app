import 'package:json2dart_safe/json2dart.dart';

import '../../utils/enum.dart';

/// tab分类
class ClassifyModel {
  int classifyId;
  String classifyTitle;
  String createdAt;

  ///0-免费、1-vip、2-付费 3-短视频 4-禁区
  ShiPinClassifyType type;
  String updatedAt;

  ///模版类型：1-未成年 2-推荐 3-列表
  int templateType;

  ///分类类型：1-长视频 2-视频 3-猎奇
  int classifyType;

  bool get isShort => type == ShiPinClassifyTypeEnum.short;
  bool get isForbidden => type == ShiPinClassifyTypeEnum.forbidden;

  bool get isWeiChenNian => templateType == 1;

  bool get isRecommmend => templateType == 2;
  bool get isCommon => templateType == 3;

  ClassifyModel.fromJson(Map<String, dynamic> json)
      : classifyId = json.asInt('classifyId'),
        classifyTitle = json.asString('classifyTitle'),
        createdAt = json.asString('createdAt'),
        type = json.asInt('type', ShiPinClassifyTypeEnum.free),
        updatedAt = json.asString('updatedAt'),
        classifyType = json.asInt('classifyType'),
        templateType = json.asInt('templateType');
}
