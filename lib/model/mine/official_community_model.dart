class OfficialCommunityModel {
  String? createdAt;
  int? groupType;
  String? id;
  String? link;
  String? name;
  int? sort;
  int? type;
  String? updatedAt;

  OfficialCommunityModel(
      {this.createdAt,
      this.groupType,
      this.id,
      this.link,
      this.name,
      this.sort,
      this.type,
      this.updatedAt});

  OfficialCommunityModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    groupType = json['groupType'];
    id = json['id'];
    link = json['link'];
    name = json['name'];
    sort = json['sort'];
    type = json['type'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['groupType'] = this.groupType;
    data['id'] = this.id;
    data['link'] = this.link;
    data['name'] = this.name;
    data['sort'] = this.sort;
    data['type'] = this.type;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
