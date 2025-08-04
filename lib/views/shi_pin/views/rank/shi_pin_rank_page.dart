/*
 * @Author: wangdazhuang
 * @Date: 2025-02-22 15:24:34
 * @LastEditTime: 2025-02-26 17:15:40
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/views/shi_pin/views/rank/shi_pin_rank_page.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../../components/no_more/no_data_sliver_list.dart';
import '../../../../components/short_widget/video_base_tile.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/extension.dart';
import '../../controllers/rank/shi_pin_rank_page_controller.dart';

class ShiPinRankPage extends GetView<ShiPinRankPageController> {
  const ShiPinRankPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            controller.pageTitle,
            style: TextStyle(
                fontSize: 17.w,
                fontWeight: FontWeight.w500,
                color: const Color(0xff18191c)),
          ),
        ),
        body: BaseRefreshSimpleWidget(
          controller,
          child: CustomScrollView(
            slivers: [
              Obx(() {
                final data = controller.data;
                final dataInited = controller.dataInited;
                return NoDataSliverList.separated(
                  itemCount: data.length,
                  itemBuilder: (ctx, i) => VideoBaseTile.fromIndex(
                    data[i],
                    onTap: controller.classify.isShort
                        ? () {
                            // Get.toShortVideoPlay(
                            //   controller.data.map((e) => e.video).toList(),
                            //   idx: i,
                            // );
                          }
                        : null,
                  ),
                  separatorBuilder: (ctx, i) => 8.verticalSpaceFromWidth,
                  noData: dataInited,
                );
              })
            ],
          ).baseMarginHorizontal,
        ),
      );
}
