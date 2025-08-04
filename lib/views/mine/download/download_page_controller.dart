import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../utils/m3u8_download/m3u8_download_record.dart';

class DownloadPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  EasyRefreshController refreshController = EasyRefreshController();
  PagingController<int, M3u8DownloadRecord> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((page) {
      getHttpData(page);
    });
  }

  @override
  void onClose() {
    refreshController.dispose();
    pagingController.dispose();
    super.onClose();
  }

  getHttpData(int page) {
    final records =
        M3u8DownloadManager().getAllRecords<M3u8DownloadRecord>().toList();
    if (records.isNotEmpty) {
      if (page == 1) {
        pagingController.itemList?.clear();
      }
      pagingController.appendLastPage(records);
    } else {
      pagingController.appendLastPage([]);
    }
  }
}
