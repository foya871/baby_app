class FansFollowerModel {
  bool? blogger;
  int? bu;
  int? dynNum;
  bool? attention;
  String? logo;
  String? nickName;
  String? personSign;
  int? userId;
  int? vipType;
  int? workNum;

  FansFollowerModel(
      {this.blogger,
      this.bu,
      this.dynNum,
      this.attention = false,
      this.logo,
      this.nickName,
      this.personSign,
      this.userId,
      this.vipType,
      this.workNum});

  FansFollowerModel.fromJson(Map<String, dynamic> json) {
    blogger = json['blogger'];
    bu = json['bu'];
    dynNum = json['dynNum'];
    attention = json['attention'];
    logo = json['logo'];
    nickName = json['nickName'];
    personSign = json['personSign'];
    userId = json['userId'];
    vipType = json['vipType'];
    workNum = json['workNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blogger'] = this.blogger;
    data['bu'] = this.bu;
    data['dynNum'] = this.dynNum;
    data['attention'] = this.attention;
    data['logo'] = this.logo;
    data['nickName'] = this.nickName;
    data['personSign'] = this.personSign;
    data['userId'] = this.userId;
    data['vipType'] = this.vipType;
    data['workNum'] = this.workNum;
    return data;
  }
}
