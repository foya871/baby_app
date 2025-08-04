import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:baby_app/views/search/search_result/search_result_topic_controller.dart';

import '../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../components/no_more/no_data.dart';
import '../../../components/no_more/no_data_list_view.dart';
import '../../../utils/color.dart';
import '../../../utils/enum.dart';
// import '../../community/topic/topic_cell.dart';

class TopicResultView extends StatelessWidget {
  late SearchResultTopicController controller;

  TopicResultView({super.key});

  @override
  Widget build(BuildContext context) {
    controller = Get.put(SearchResultTopicController());
    return BaseRefreshSimpleWidget(
      controller,
      child: Container(
        alignment: Alignment.center,
        child: Obx(() {
          return NoDataListView.builder(
              noData: controller.dataInited,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.w),
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                var model = controller.data[index];
                return Container();
                // return TopicCell(model: model);
              });
        }),
      ),
    );
  }
}
