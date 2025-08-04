import '../../utils/enum.dart';

class LocationEvent {
  int loadType;
  String provinces;
  String cityName;
  LocationEvent(this.loadType, this.provinces, this.cityName);
}

class ClearLocationEvent {
  int loadType;
  String cityName;
  ClearLocationEvent(this.loadType, this.cityName);
}

class BloggerRefreshEvent {
  String tabName;
  BloggerRefreshEvent(this.tabName);
}

class VideoLayoutEvent {
  VideoLayout layout;
  VideoLayoutEvent(this.layout);
}

class ClearMessageEvent {
  int conversationId;
  bool clearConversation;
  ClearMessageEvent(this.conversationId, this.clearConversation);
}

class EditClassifyEvent {}

class ShortCommentInputDisplayEvent {
  final bool display;
  ShortCommentInputDisplayEvent({required this.display});
}
