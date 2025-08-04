import 'package:hive_ce/hive.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../env/environment_service.dart';
import '../../model/play/video_detail_model.dart';
import '../../model/video_base_model.dart';
import '../enum.dart';

class M3u8DownloadRecord extends HiveObject with M3u8DownloadRecordMixin {
  String videoUrl;
  String authKey;
  String cover;
  String title;
  VideoTypeEnum videoType;
  double price;
  int watchNum;

  M3u8DownloadRecord({
    //
    required int videoId,
    int playTime = 0,
    required M3u8DownloadRecordState state,
    String stateDesc = '',
    String downloadFilepath = '',
    DateTime? createdAt,
    //
    required this.videoUrl,
    required this.authKey,
    required this.cover,
    this.title = '',
    required this.videoType,
    this.price = 0.0,
    required this.watchNum,
  }) {
    initRecordMixin(
      createdAt: createdAt ?? DateTime.now(),
      videoId: videoId,
      playTime: playTime,
      state: state,
      stateDesc: stateDesc,
      downloadPath: downloadFilepath,
    );
  }

  @override
  Uri? getFullUrl() =>
      Uri.parse("${Environment.kbaseAPI}m3u8/decode/by/id?videoId=$videoId");

  M3u8DownloadRecord.videoDetail(VideoDetail detail)
      : videoUrl = detail.videoUrl!,
        authKey = '',
        cover = detail.hCover,
        title = detail.title!,
        videoType = detail.videoType!,
        price = detail.price!,
        watchNum = detail.fakeWatchNum! {
    initRecordMixin(
      createdAt: DateTime.now(),
      videoId: detail.videoId!,
      playTime: detail.playTime ?? 0,
      state: M3u8DownloadRecordStateEnum.waiting,
    );
  }

  M3u8DownloadRecord.videoBase(VideoBaseModel base)
      : videoUrl = base.videoUrl!,
        authKey = '',
        cover = base.hCover,
        title = base.title!,
        videoType = base.videoType!,
        price = base.price!,
        watchNum = base.fakeWatchNum! {
    initRecordMixin(
      createdAt: DateTime.now(),
      videoId: base.videoId!,
      playTime: base.playTime ?? 0,
      state: M3u8DownloadRecordStateEnum.waiting,
    );
  }
}
