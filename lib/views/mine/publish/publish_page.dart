import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:baby_app/views/community/list/community_cell.dart';

import '../../../../components/no_more/no_data.dart';
import '../../../../components/no_more/no_more.dart';
import '../../../model/community/community_model.dart';
import 'publish_page_controller.dart';

class PublishPage extends GetView<PublishPageController> {
  const PublishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("我的帖子")),
      body: _buildBodyView(),
    );
  }

  _buildBodyView() {
    return EasyRefresh(
        controller: controller.refreshController,
        refreshOnStart: true,
        onRefresh: () async {
          controller.getHttpData(isRefresh: true);
        },
        onLoad: () async {
          controller.getHttpData(isRefresh: false);
        },
        child: PagedListView.separated(
          pagingController: controller.pagingController,
          padding: EdgeInsets.symmetric(vertical: 10.w),
          builderDelegate: PagedChildBuilderDelegate<CommunityModel>(
            firstPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            newPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            noMoreItemsIndicatorBuilder: (context) => const NoMore(),
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            itemBuilder: (context, value, index) => CommunityCell(model: value),
          ),
          separatorBuilder: (context, index) => 15.verticalSpace,
        ));
  }
}
