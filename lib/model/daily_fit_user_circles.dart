class DailyFitUserCircles {
  int? circles;
  List<CheckinGiftList>? checkinGiftList;

  DailyFitUserCircles({this.circles, this.checkinGiftList});

  DailyFitUserCircles.fromJson(Map<String, dynamic> json) {
    circles = json['circles'];
    if (json['checkinGiftList'] != null) {
      checkinGiftList = <CheckinGiftList>[];
      json['checkinGiftList'].forEach((v) {
        checkinGiftList!.add(new CheckinGiftList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['circles'] = this.circles;
    if (this.checkinGiftList != null) {
      data['checkinGiftList'] =
          this.checkinGiftList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckinGiftList {
  int? type;
  String? giftId;
  int? giftNum;
  String? giftName;
  String? giftImg;

  CheckinGiftList(
      {this.type, this.giftId, this.giftNum, this.giftName, this.giftImg});

  CheckinGiftList.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    giftId = json['giftId'];
    giftNum = json['giftNum'];
    giftName = json['giftName'];
    giftImg = json['giftImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['giftId'] = this.giftId;
    data['giftNum'] = this.giftNum;
    data['giftName'] = this.giftName;
    data['giftImg'] = this.giftImg;
    return data;
  }
}
