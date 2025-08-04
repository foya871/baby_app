import 'dart:convert';

class ChatListModel {
  final String? logo;
  final String? newMessage;
  final String? newMessageDate;
  final String? nickName;
  final int? noReadNum;
  final int? userId;

  ChatListModel({
    this.logo,
    this.newMessage,
    this.newMessageDate,
    this.nickName,
    this.noReadNum,
    this.userId,
  });

  ChatListModel copyWith({
    String? logo,
    String? newMessage,
    String? newMessageDate,
    String? nickName,
    int? noReadNum,
    int? userId,
  }) {
    return ChatListModel(
      logo: logo ?? this.logo,
      newMessage: newMessage ?? this.newMessage,
      newMessageDate: newMessageDate ?? this.newMessageDate,
      nickName: nickName ?? this.nickName,
      noReadNum: noReadNum ?? this.noReadNum,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logo': logo,
      'newMessage': newMessage,
      'newMessageDate': newMessageDate,
      'nickName': nickName,
      'noReadNum': noReadNum,
      'userId': userId,
    };
  }

  factory ChatListModel.fromMap(Map<String, dynamic> map) {
    return ChatListModel(
      logo: map['logo'] as String?,
      newMessage: map['newMessage'] as String?,
      newMessageDate: map['newMessageDate'] as String?,
      nickName: map['nickName'] as String?,
      noReadNum: map['noReadNum'] is int
          ? map['noReadNum'] as int
          : int.tryParse('${map['noReadNum']}'),
      userId: map['userId'] is int
          ? map['userId'] as int
          : int.tryParse('${map['userId']}'),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatListModel.fromJson(String source) =>
      ChatListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(logo: $logo, newMessage: $newMessage, newMessageDate: $newMessageDate, nickName: $nickName, noReadNum: $noReadNum, userId: $userId)';
  }

  @override
  bool operator ==(covariant ChatListModel other) {
    if (identical(this, other)) return true;

    return other.logo == logo &&
        other.newMessage == newMessage &&
        other.newMessageDate == newMessageDate &&
        other.nickName == nickName &&
        other.noReadNum == noReadNum &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return logo.hashCode ^
        newMessage.hashCode ^
        newMessageDate.hashCode ^
        nickName.hashCode ^
        noReadNum.hashCode ^
        userId.hashCode;
  }
}
