// import 'package:collection/collection.dart';
// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
// import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
// import 'package:ffmpeg_kit_flutter/log.dart';
// import 'package:ffmpeg_kit_flutter/statistics.dart';
// import 'package:flutter/foundation.dart';
// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart';

// import '../model/play/video_detail_model.dart';
// import 'logger.dart';
// import 'utils.dart';

// const _mp4Ext = '.mp4';

// // 这是用的时间，不是大小
// typedef M3u8DownloadProgressCallback = void Function(
//     double currentPlayTime, double totalPlayTime);

// class M3u8Downloader {
//   final int id;
//   final Uri url;
//   final String? title;
//   double? _playTime; // 秒
//   int? _ffmpegSessionId;
//   final int tryCountMax;
//   final int? probeTimeoutMs;
//   bool? onProgressInitial;
//   M3u8DownloadProgressCallback? onProgress;
//   VoidCallback? onDone;
//   VoidCallback? onError;
//   VoidCallback? onCancel;

//   double? get playTime => _playTime;
//   bool _canceled = false;
//   bool _started = false;
//   int _tryCount = 0;

//   M3u8Downloader(
//     this.url, {
//     this.id = 0,
//     double? playTime,
//     this.title,
//     this.onProgressInitial,
//     this.onProgress,
//     this.onDone,
//     this.onError,
//     this.onCancel,
//     this.tryCountMax = 1,
//     this.probeTimeoutMs = 15 * 1000,
//   }) : _playTime = playTime;

//   Future<bool> _probe() async {
//     try {
//       final session = await FFprobeKit.getMediaInformation(url.toString(), 3);
//       logger.d('probe cmd:ffmpeg ${session.getCommand()}');
//       final info = session.getMediaInformation();
//       if (info == null) {
//         final code = await session.getReturnCode();
//         final output = await session.getOutput();
//         logger.d('probe fail code:${code?.getValue()}, output:$output');
//         return false;
//       }
//       final durationSeconds = info.getDuration();
//       // final size = info.getSize(); // 这里不能用size,这个size只是m3u8文件的size
//       if (durationSeconds == null) return false;
//       _playTime = double.tryParse(durationSeconds);
//       if (_playTime != null) {
//         return true;
//       }
//     } catch (e) {
//       logger.d('ffmpeg prob fail $e');
//     }
//     return false;
//   }

//   String _buildFilename() {
//     if (title?.isNotEmpty == true) {
//       final ext = p.extension('$title');
//       if (ext.toLowerCase() == _mp4Ext) {
//         return title!;
//       }
//       return '$title$_mp4Ext';
//     }
//     String? path = url.queryParameters['path'];
//     path ??= url.path;
//     if (path.isNotEmpty) {
//       final ext = p.extension(path);
//       if (['.m3u8', '.m3u'].contains(ext)) {
//         final name = p.basenameWithoutExtension(path);
//         return '$name$_mp4Ext';
//       }
//     }
//     return '${Utils.md5String(url.toString())}$_mp4Ext';
//   }

//   void _setSessionId(int? sessionId) => _ffmpegSessionId ??= sessionId;

//   void _onDoneWrapper() {
//     _started = false;
//     onDone?.call();
//   }

//   void _onCancelWrapper() {
//     _started = false;
//     onCancel?.call();
//   }

//   void _onErrorWrapper([bool retry = true]) {
//     _started = false;

//     if (retry && _tryCount < tryCountMax) {
//       start();
//       return;
//     }
//     onError?.call();
//   }

//   Future<void> cancel() async {
//     if (_canceled) return;
//     logger.d('cancel entry id:$id url:$url');
//     _canceled = true;
//     if (_ffmpegSessionId == null) return;
//     try {
//       await FFmpegKit.cancel(_ffmpegSessionId);
//       return;
//     } catch (e) {
//       logger.d('M3u8Download cancel err:$e');
//     }
//   }

//   void start() {
//     if (kIsWeb) {
//       _onErrorWrapper(false);
//       return;
//     }
//     if (_started) return;
//     _started = true;
//     _canceled = false;
//     _tryCount++;
//     _setSessionId(null);

//     logger.d('start task id:$id,  tryCount:$_tryCount');
//     _startInner();
//   }

//   void _startInner() async {
//     if (_playTime == null) {
//       if (onProgressInitial == true) {
//         onProgress?.call(0, -1);
//       }
//       logger.d('probe start.. url:$url');
//       final ok = await _probe();
//       if (_canceled) {
//         _onCancelWrapper();
//         return;
//       }
//       if (!ok) {
//         _onErrorWrapper();
//         return;
//       }
//     }

//     onProgress?.call(0, _playTime!);
//     final documents = await getApplicationDocumentsDirectory();
//     if (_canceled) {
//       _onCancelWrapper();
//       return;
//     }
//     final filename = _buildFilename();
//     String fullpath = "${documents.path}/$filename";
//     logger.d('download start.. url:$url, fullpath:$fullpath');
//     final cmd =
//         '-i $url -hide_banner -copyts -y -bsf:a aac_adtstoasc -f mp4 $fullpath';
//     FFmpegKit.executeAsync(cmd, _onComplete, _onLog, _onStatics);
//   }

//   void _onComplete(FFmpegSession session) async {
//     _setSessionId(session.getSessionId());
//     logger.d('_onSession _ffmpegSessionId $_ffmpegSessionId');
//     final code = await session.getReturnCode();
//     if (code == null) {
//       _onErrorWrapper();
//       return;
//     }
//     if (code.isValueSuccess()) {
//       _onDoneWrapper();
//     } else if (code.isValueCancel()) {
//       _onCancelWrapper();
//     } else {
//       _onErrorWrapper();
//     }
//   }

//   void _onLog(Log log) => _setSessionId(log.getSessionId());

//   void _onStatics(Statistics stat) {
//     _setSessionId(stat.getSessionId());
//     onProgress?.call(stat.getTime() / 1000, _playTime!);
//   }
// }

// class _M3u8DownloadManager {
//   final tasks = <M3u8Downloader>[];

//   bool hasTask(int videoId) => tasks.indexWhere((e) => e.id == videoId) >= 0;
//   bool register(
//     VideoDetail model, {
//     bool onProgressInitial = true,
//     M3u8DownloadProgressCallback? onProgress,
//     VoidCallback? onDone,
//     VoidCallback? onError,
//     VoidCallback? onCancel,
//     int tryCount = 3,
//     bool startImmediately = true,
//   }) {
//     if (hasTask(model.videoId!)) return false;
//     final title = model.title;
//     final videoUrl = model.videoUrl!;
//     if (videoUrl.isEmpty && !videoUrl.contains('.m3u')) return false;
//     final url = model.authPlayUrl;
//     final downloader = M3u8Downloader(
//       url,
//       id: model.videoId!,
//       title: title,
//       playTime: model.playTime!.toDouble(), // 这里可能会比实际的不匹配
//       onProgressInitial: onProgressInitial,
//       onProgress: onProgress,
//       onDone: onDone,
//       onCancel: onCancel,
//       onError: onError,
//       tryCountMax: tryCount,
//     );
//     if (startImmediately) {
//       downloader.start();
//     }
//     tasks.add(downloader);
//     return true;
//   }

//   M3u8Downloader? _find(int videoId) =>
//       tasks.firstWhereOrNull((e) => e.id == videoId);

//   void cancel(int videoId) => _find(videoId)?.cancel();

//   void cancelAll() {
//     for (final e in tasks) {
//       e.cancel();
//     }
//   }

//   void start(int videoId) => _find(videoId)?.start();
// }

// // ignore: non_constant_identifier_names
// final M3u8DownloadManager = _M3u8DownloadManager();
