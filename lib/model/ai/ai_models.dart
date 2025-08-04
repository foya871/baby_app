import 'package:json2dart_safe/json2dart.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../components/pay/model/recharge_type_model.dart';
import '../../utils/enum.dart';
import '../play/cdn_model.dart';

class AiEntranceConfigModel {
  final String createdAt;
  final String id;
  final String img;
  final double rcPrice;
  final bool status;
  final bool liveEnable;
  final String updatedAt;

  // 是否在维护
  bool get isMaintain => !status;

  AiEntranceConfigModel.empty() : this.fromJson({});

  AiEntranceConfigModel.fromJson(Map<String, dynamic> json)
      : createdAt = json.asString('createdAt'),
        id = json.asString('id'),
        img = json.asString('img'),
        rcPrice = json.asDouble('rcPrice'),
        status = json.asBool('status'),
        liveEnable = json.asBool('liveEnable'),
        updatedAt = json.asString('updatedAt');

  static dynamic toBean(dynamic json) => AiEntranceConfigModel.fromJson(json);
}

class AiDrawPromptModel {
  final List<AiDrawPromptModel> childPrompt;
  final String coverImg;
  final int parentPromptId;
  final String promptEnglishTitle;
  final int promptId;
  final String promptTitle;
  final int promptType;
  final bool showVip;
  final AiDrawPromptShowType showShort;

  AiDrawPromptModel.empty() : this.fromJson({});

  AiDrawPromptModel.fromJson(Map<String, dynamic> json)
      : childPrompt =
            json.asList('childPrompt', AiDrawPromptModel.toBean) ?? [],
        coverImg = json.asString('coverImg'),
        parentPromptId = json.asInt('parentPromptId'),
        promptEnglishTitle = json.asString('promptEnglishTitle'),
        promptId = json.asInt('promptId'),
        promptTitle = json.asString('promptTitle'),
        promptType = json.asInt('promptType'),
        showVip = json.asBool('showVip'),
        showShort = json.asInt('showShort', AiDrawPromptShowTypeEnum.none);

  static dynamic toBean(dynamic json) => AiDrawPromptModel.fromJson(json);
}

class AiDrawDefaultPromptModel {
  final String id;
  final int defaultId;
  final String defaultName;
  final String coverImg;
  final List<AiDrawPromptModel> defaultPrompt;

  bool get isMangHe => defaultPrompt.isEmpty;

  AiDrawDefaultPromptModel.fromJson(Map<String, dynamic> json)
      : id = json.asString('id'),
        defaultId = json.asInt('defaultId'),
        defaultName = json.asString('defaultName'),
        coverImg = json.asString('coverImg'),
        defaultPrompt =
            json.asList('defaultPrompt', AiDrawPromptModel.toBean) ?? [];

  static dynamic toBean(dynamic json) =>
      AiDrawDefaultPromptModel.fromJson(json);
}

class AiVipCardModel {
  final int aiCardId;
  String aiCardName;
  final int aiVipNumber;
  final String desc;
  final double disPrice;
  final int expiredTime;
  final double price;
  final List<RechargeTypeModel> types;

  String get offPriceText => (price - disPrice).toStringAsShort();

  String get disPriceText => disPrice.toStringAsShort();

  AiVipCardModel.fromJson(Map<String, dynamic> json)
      : aiCardId = json.asInt('aiCardId'),
        aiCardName = json.asString('aiCardName'),
        aiVipNumber = json.asInt('aiVipNumber'),
        desc = json.asString('desc'),
        disPrice = json.asDouble('disPrice'),
        expiredTime = json.asInt('expiredTime'),
        price = json.asDouble('price'),
        types = json.asList('types', RechargeTypeModel.toBean) ?? [];

  static dynamic toBean(dynamic json) => AiVipCardModel.fromJson(json);
}

class AiVipProductModel {
  final List<AiVipCardModel> vipCardList;

  AiVipProductModel.empty() : this.fromJson({});

  AiVipProductModel.fromJson(Map<String, dynamic> json)
      : vipCardList = json.asList('vipCardList', AiVipCardModel.toBean) ?? [];

  static dynamic toBean(dynamic json) => AiVipProductModel.fromJson(json);
}

class AiStencilClassModel {
  final int classId;
  final String classTitle;

  AiStencilClassModel.empty() : this.fromJson({});
  AiStencilClassModel.all()
      : classId = -987654321,
        classTitle = '全部';

  bool get isAll => classId == -987654321;

  AiStencilClassModel.fromJson(Map<String, dynamic> json)
      : classId = json.asInt('classId'),
        classTitle = json.asString('classTitle');

  static dynamic toBean(dynamic json) => AiStencilClassModel.fromJson(json);
}

class AiStencilModel {
  final double amount;
  final String createdAt;
  final String fileName;
  final String fileServerId;
  final String originalImg;
  final String playPath;
  final int playTime;
  final int status;
  final String stencilId;
  final String stencilName;
  final String type; // rpv, rpi
  final String updatedAt;
  final String authKey;
  final CdnRsp? cdnRes;
  final bool hot;

  bool get isVideo => type == 'rpv';

  bool get isImage => type == 'rpi';

  String buildPlayUrl() => '';

  AiStencilModel.empty() : this.fromJson({});

  bool get isEmpty => stencilId == '';

  AiStencilModel.fromJson(Map<String, dynamic> json)
      : amount = json.asDouble('amount'),
        createdAt = json.asString('createdAt'),
        fileName = json.asString('fileName'),
        fileServerId = json.asString('fileServerId'),
        originalImg = json.asString('originalImg'),
        playPath = json.asString('playPath'),
        playTime = json.asInt('playTime'),
        status = json.asInt('status'),
        stencilId = json.asString('stencilId'),
        stencilName = json.asString('stencilName'),
        type = json.asString('type'),
        updatedAt = json.asString('updatedAt'),
        authKey = json.asString('authKey'),
        cdnRes = json.asBean(
            'cdnRes', (v) => CdnRsp.fromJson(Map<String, dynamic>.from(v))),
        hot = json.asBool('hot');

  static dynamic toBean(dynamic json) => AiStencilModel.fromJson(json);
}

class AiFaceCustomCreateStencilResp {
  final String orderNo;

  AiFaceCustomCreateStencilResp.fromJson(Map<String, dynamic> json)
      : orderNo = json['orderNo'];

  static dynamic toBean(dynamic json) =>
      AiFaceCustomCreateStencilResp.fromJson(json);
}

class AiRcRecordV2Model {
  final String tradeNo;
  final AiRecordStatus status;
  final String fileName;
  final bool shardStatus;
  final int appeal;
  final int appealNum;

  AiRcRecordV2Model.fromJson(Map<String, dynamic> json)
      : tradeNo = json.asString('tradeNo'),
        status = json.asString('status', AiRecordStatusEnum.none),
        fileName = json.asString('fileName'),
        shardStatus = json.asBool('shardStatus'),
        appeal = json.asInt('appeal'),
        appealNum = json.asInt('appealNum');
}

class AiHandleRecordModel {
  final double amount;
  final int appeal;
  final String appealNum;
  final String backMoney;
  final String coverImg;
  final String createdAt;
  final List<String> fileNames;
  final String id;
  final bool isDel;
  final bool isFree;
  final bool manualStatus;
  final String originalImg;
  final int playTime;
  final String remark;
  final int retryNum;
  final bool shardStatus;
  final AiRecordStatus status;
  final String stencilId;
  final String stencilName;
  final String tradeNo;
  final int type;
  final String updatedAt;
  final int userId;

  String get videoUrl => fileNames.firstOrNull ?? '';

  AiHandleRecordModel.fromJson(Map<String, dynamic> json)
      : amount = json.asDouble('amount'),
        appeal = json.asInt('appeal'),
        appealNum = json.asString('appealNum'),
        backMoney = json.asString('backMoney'),
        // bgUserNames = json.asString('bgUserNames'),
        coverImg = json.asString('coverImg'),
        createdAt = json.asString('createdAt'),
        fileNames = json.asList<String>('fileNames') ?? [],
        id = json.asString('id'),
        isDel = json.asBool('isDel'),
        isFree = json.asBool('isFree'),
        manualStatus = json.asBool('manualStatus'),
        originalImg = json.asString('originalImg'),
        playTime = json.asInt('playTime'),
        remark = json.asString('remark'),
        retryNum = json.asInt('retryNum'),
        shardStatus = json.asBool('shardStatus'),
        status = json.asString('status', AiRecordStatusEnum.none),
        stencilId = json.asString('stencilId'),
        stencilName = json.asString('stencilName'),
        tradeNo = json.asString('tradeNo'),
        type = json.asInt('type'),
        updatedAt = json.asString('updatedAt'),
        userId = json.asInt('userId');

  static dynamic toBean(dynamic json) => AiHandleRecordModel.fromJson(json);
}

class AiHandleRecordModelResp {
  final String domain;
  final List<AiHandleRecordModel> data;

  AiHandleRecordModelResp.fromJson(Map<String, dynamic> json)
      : domain = json.asString('domain'),
        data = json.asList('data', AiHandleRecordModel.toBean) ?? [];
}

// //普通的，没有申诉信息
// class AiRecordModel {
//   final String fileName;
//   final AiRecordStatus status;
//   final String stencilName;
//   final String tradeNo;

//   AiRecordModel.fromJson(Map<String, dynamic> json)
//       : fileName = json.asString('fileName'),
//         status = json.asString('status', AiRecordStatusEnum.none),
//         stencilName = json.asString('stencilName'),
//         tradeNo = json.asString('tradeNo');

//   static dynamic toBean(dynamic json) => AiRecordModel.fromJson(json);
// }
