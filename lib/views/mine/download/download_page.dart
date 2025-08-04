import 'package:baby_app/components/app_bar/app_bar_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../components/no_more/no_data.dart';
import '../../../components/no_more/no_more.dart';
import '../../../components/short_widget/video_base_cell.dart';
import '../../../model/video_base_model.dart';
import '../../../utils/m3u8_download/m3u8_download_record.dart';
import 'download_page_controller.dart';

class DownloadPage extends GetView<DownloadPageController> {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("下载缓存"),
      ),
      body: EasyRefresh(
        controller: controller.refreshController,
        refreshOnStart: true,
        onRefresh: () async {
          controller.pagingController.refresh();
        },
        // onLoad: () async {
        //   controller.getHttpData(isRefresh: false);
        // },
        child: _buildGridView(),
      ),
    );
  }

  Widget _buildGridView() {
    return PagedGridView(
      pagingController: controller.pagingController,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      builderDelegate: PagedChildBuilderDelegate<M3u8DownloadRecord>(
        firstPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
        newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
        noMoreItemsIndicatorBuilder: (context) => const NoMore(),
        noItemsFoundIndicatorBuilder: (context) => const NoData(),
        itemBuilder: (context, value, index) {
          VideoBaseModel video = VideoBaseModel(
            mark: 1,
            title: value.title,
            fakeWatchNum: value.watchNum,
            createdAt: value.createdAt.timeZoneName,
          );
          return VideoBaseCell.small(video: video);
        },
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.w,
        crossAxisSpacing: 7.w,
        childAspectRatio: 1.11,
      ),
    );
  }
}
