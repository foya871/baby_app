/*
 * @description: 
 * @FilePath: /baby_app/lib/views/mine/mine_withdrawal/mine_withdrawal_record_page.dart
 * @author: david
 * @文件版本: V1.0.0
 * @Date: 2025-06-28 15:43:26
 * 版权信息: 2025 by david, All Rights Reserved.
 */
import 'package:baby_app/components/app_bar/app_bar_view.dart';
import 'package:baby_app/components/base_refresh/base_refresh_simple_widget.dart';
import 'package:baby_app/components/no_more/no_data_list_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'mine_withdrawal_record_page_controller.dart';

class MineWithdrawalRecordPage
    extends GetView<MineWithdrawalRecordPageController> {
  const MineWithdrawalRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("提现记录")),
        body: BaseRefreshSimpleWidget(controller, child: Obx(() {
          var data = controller.data;
          var dataInited = controller.dataInited;
          return NoDataListView.builder(
              noData: dataInited,
              cacheExtent: 64.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              itemCount: data.length,
              itemBuilder: (context, index) {
                var model = data[index];
                return Container(
                  width: 355.w,
                  height: 64.w,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: COLOR.hexColor("#e0e0e0").withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            // text: model.tradeNo.toString(),
                            text: "提现",
                            style: TextStyle(
                                fontSize: 15.w,
                                fontWeight: FontWeight.w500,
                                color: COLOR.white),
                          ),
                          SizedBox(height: 4.w),
                          TextView(
                            text: Utils.dateFmt(model.createdAt ?? ""),
                            style: TextStyle(
                                fontSize: 12.w,
                                fontWeight: FontWeight.w400,
                                color: COLOR.hexColor("#999999")),
                          )
                        ],
                      ),
                      TextView(
                        text: "-${model.money.toString()}",
                        style: TextStyle(
                            fontSize: 16.w,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )
                    ],
                  ),
                );
              });
        })));
  }
}
