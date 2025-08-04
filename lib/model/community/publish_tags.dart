// 响应数据的整体结构
class PublishTagsResponse {
  final int code;
  final String msg;
  final List<PublishTags> data;

  PublishTagsResponse({
    required this.code,
    required this.msg,
    required this.data,
  });

  // 从 JSON 转换为对象
  factory PublishTagsResponse.fromJson(Map<String, dynamic> json) {
    return PublishTagsResponse(
      code: json['code'] as int,
      msg: json['msg'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) => PublishTags.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  // 转换为 JSON
  Map<String, dynamic> toJson() => {
        'code': code,
        'msg': msg,
        'data': data.map((item) => item.toJson()).toList(),
      };
}

// 标签数据实体类
class PublishTags {
  final String id;
  final String? userId;
  final String name;
  final String? logo;
  final String? backgroundImg;
  final String? introduction;
  final int? joinNum;
  final int? postNum;
  final bool? isHot;
  final bool? isJoined;

  PublishTags({
    required this.id,
    this.userId,
    required this.name,
    this.logo,
    this.backgroundImg,
    this.introduction,
    this.joinNum,
    this.postNum,
    this.isHot,
    this.isJoined,
  });

  // 从 JSON 转换为对象
  factory PublishTags.fromJson(Map<String, dynamic> json) {
    return PublishTags(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      name: json['name'] as String? ?? '',
      logo: json['logo'] as String?,
      backgroundImg: json['backgroundImg'] as String?,
      introduction: json['introduction'] as String?,
      joinNum: json['joinNum'] as int,
      postNum: json['postNum'] as int,
      isHot: json['isHot'] as bool,
      isJoined: json['isJoined'] as bool,
    );
  }

  // 转换为 JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'logo': logo,
        'backgroundImg': backgroundImg,
        'introduction': introduction,
        'joinNum': joinNum,
        'postNum': postNum,
        'isHot': isHot,
        'isJoined': isJoined,
      };

  // 复制对象并修改部分属性
  PublishTags copyWith({
    String? id,
    String? userId,
    String? name,
    String? logo,
    String? backgroundImg,
    String? introduction,
    int? joinNum,
    int? postNum,
    bool? isHot,
    bool? isJoined,
  }) {
    return PublishTags(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      backgroundImg: backgroundImg ?? this.backgroundImg,
      introduction: introduction ?? this.introduction,
      joinNum: joinNum ?? this.joinNum,
      postNum: postNum ?? this.postNum,
      isHot: isHot ?? this.isHot,
      isJoined: isJoined ?? this.isJoined,
    );
  }
}
