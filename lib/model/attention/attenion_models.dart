import 'package:baby_app/model/video_base_model.dart';
import 'package:json2dart_safe/json2dart.dart';

import '../user/user_info_model.dart';

class AttentionUserVideosResp {
  final List<VideoBaseModel> attentionVideoList;
  final List<UserInfo> userRecommendList;

  AttentionUserVideosResp.fromJson(Map<String, dynamic> json)
      : attentionVideoList = json.asList<VideoBaseModel>(
                'attentionVideoList', VideoBaseModel.toBean) ??
            [],
        userRecommendList =
            json.asList<UserInfo>('userRecommendList', UserInfo.toBean) ?? [];
}
