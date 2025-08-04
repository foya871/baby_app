import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/views/search/search_result/search_result_post_controller.dart';

import '../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../components/no_more/no_data.dart';
import '../../../components/no_more/no_data_list_view.dart';
import '../../../utils/enum.dart';
import '../../community/list/community_cell.dart';
// import '../../community/list/community_cell.dart';

class PostResultView extends StatelessWidget {
  late SearchResultPostController controller;

  PostResultView({super.key});

  @override
  Widget build(BuildContext context) {
    controller = Get.put(
      SearchResultPostController(),
    );
    return BaseRefreshSimpleWidget(
      controller,
      child: Obx(() {
        return NoDataListView.builder(
            noData: controller.dataInited,
            cacheExtent: 100,
            padding: EdgeInsets.symmetric(vertical: 10.w),
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              var model = controller.data[index];
              return CommunityCell(model: model);
            });
      }),
    );
  }
}
