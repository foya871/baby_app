import 'dart:convert';

class MeetUserDetailModel {
  final String? address;
  final int? age;
  final String? areaName;
  final List<MeetUserBgImg>? bgImgs;
  final String? bust;
  final String? cityName;
  final int? commentNum;
  final int? complaintNum;
  final String? contactDtl;
  final String? createdAt;
  final String? domain;
  final List<String>? figure;
  final int? heightNum;
  final String? info;
  final bool? isUnlock;
  final int? lockNum;
  final String? logo;
  final String? mediaDomain;
  final int? meetUserId;
  final int? monthPrice;
  final String? nickName;
  final int? nightPrice;
  final int? price;
  final String? provinceName;
  final List<String>? serviceTags;
  final String? serviceTime;
  final int? unlockGold;

  MeetUserDetailModel({
    this.address,
    this.age,
    this.areaName,
    this.bgImgs,
    this.bust,
    this.cityName,
    this.commentNum,
    this.complaintNum,
    this.contactDtl,
    this.createdAt,
    this.domain,
    this.figure,
    this.heightNum,
    this.info,
    this.isUnlock,
    this.lockNum,
    this.logo,
    this.mediaDomain,
    this.meetUserId,
    this.monthPrice,
    this.nickName,
    this.nightPrice,
    this.price,
    this.provinceName,
    this.serviceTags,
    this.serviceTime,
    this.unlockGold,
  });

  factory MeetUserDetailModel.fromMap(Map<String, dynamic> map) {
    return MeetUserDetailModel(
      address: map['address'] as String?,
      age: map['age'] != null ? map['age'] as int : null,
      areaName: map['areaName'] as String?,
      bgImgs: map['bgImgs'] != null
          ? List<MeetUserBgImg>.from(
              (map['bgImgs'] as List).map((x) => MeetUserBgImg.fromMap(x)))
          : null,
      bust: map['bust'] as String?,
      cityName: map['cityName'] as String?,
      commentNum: map['commentNum'] as int?,
      complaintNum: map['complaintNum'] as int?,
      contactDtl: map['contactDtl'] as String?,
      createdAt: map['createdAt'] as String?,
      domain: map['domain'] as String?,
      figure: map['figure'] != null
          ? List<String>.from(map['figure'] as List)
          : null,
      heightNum: map['heightNum'] as int?,
      info: map['info'] as String?,
      isUnlock: map['isUnlock'] as bool?,
      lockNum: map['lockNum'] as int?,
      logo: map['logo'] as String?,
      mediaDomain: map['mediaDomain'] as String?,
      meetUserId: map['meetUserId'] as int?,
      monthPrice: map['monthPrice'] as int?,
      nickName: map['nickName'] as String?,
      nightPrice: map['nightPrice'] as int?,
      price: map['price'] as int?,
      provinceName: map['provinceName'] as String?,
      serviceTags: map['serviceTags'] != null
          ? List<String>.from(map['serviceTags'] as List)
          : null,
      serviceTime: map['serviceTime'] as String?,
      unlockGold: map['unlockGold'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory MeetUserDetailModel.fromJson(String source) =>
      MeetUserDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'age': age,
      'areaName': areaName,
      'bgImgs': bgImgs?.map((x) => x.toMap()).toList(),
      'bust': bust,
      'cityName': cityName,
      'commentNum': commentNum,
      'complaintNum': complaintNum,
      'contactDtl': contactDtl,
      'createdAt': createdAt,
      'domain': domain,
      'figure': figure,
      'heightNum': heightNum,
      'info': info,
      'isUnlock': isUnlock,
      'lockNum': lockNum,
      'logo': logo,
      'mediaDomain': mediaDomain,
      'meetUserId': meetUserId,
      'monthPrice': monthPrice,
      'nickName': nickName,
      'nightPrice': nightPrice,
      'price': price,
      'provinceName': provinceName,
      'serviceTags': serviceTags,
      'serviceTime': serviceTime,
      'unlockGold': unlockGold,
    };
  }
}

class MeetUserBgImg {
  final String? authKey;
  final List<String>? coverImg;
  final String? fileId;
  final int? playTime;
  final int? size;
  final int? type;
  final String? url;

  MeetUserBgImg({
    this.authKey,
    this.coverImg,
    this.fileId,
    this.playTime,
    this.size,
    this.type,
    this.url,
  });

  factory MeetUserBgImg.fromMap(Map<String, dynamic> map) {
    return MeetUserBgImg(
      authKey: map['authKey'] as String?,
      coverImg: map['coverImg'] != null
          ? List<String>.from(map['coverImg'] as List)
          : null,
      fileId: map['fileId'] as String?,
      playTime: map['playTime'] as int?,
      size: map['size'] as int?,
      type: map['type'] as int?,
      url: map['url'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory MeetUserBgImg.fromJson(String source) =>
      MeetUserBgImg.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return {
      'authKey': authKey,
      'coverImg': coverImg,
      'fileId': fileId,
      'playTime': playTime,
      'size': size,
      'type': type,
      'url': url,
    };
  }
}
