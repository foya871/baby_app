import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../components/app_bg_view.dart';
import '../../../components/image_view.dart';
import '../../../components/text_view.dart';
import '../../../model/application/application_partner_child_model.dart';
import 'app_recommend_controller.dart';

class AppRecommendPage extends StatelessWidget {
  AppRecommendPage({super.key});

  final AppRecommendController controller = Get.put(AppRecommendController());

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Obx(
      () {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              TextView(
                text: '官方推荐',
                fontSize: 16.w,
                color: COLOR.white,
                fontWeight: FontWeight.w500,
              ),
              10.verticalSpace,
              _buildTop(),
              TextView(
                text: '热门应用',
                fontSize: 16.w,
                color: COLOR.white,
                fontWeight: FontWeight.w500,
              ),
              10.verticalSpace,
              _buildBottom(),
            ],
          ).paddingHorizontal(14.w),
        );
      },
    );
  }

  _buildTop() {
    final data = controller.list;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 10.w,
        crossAxisSpacing: 10.w,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) => _buildTopView(data[index]),
    );
  }

  _buildBottom() {
    final data = controller.bottom;
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) => _buildBottomView(data[index]),
    );
  }

  _buildTopView(ApplicationPartnerChildModel item) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w)),
      child: Column(
        children: [
          ImageView(
            src: item.icon ?? "",
            height: 58.w,
            width: 58.w,
            borderRadius: BorderRadius.circular(10.w),
          ),
          5.verticalSpace,
          TextView(
            text: item.name ?? "",
            color: Colors.white,
            fontSize: 11.w,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    ).onOpaqueTap(() => controller.toExternal(item));
  }

  _buildBottomView(ApplicationPartnerChildModel item) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w)),
      child: Row(
        children: [
          ImageView(
            src: item.icon ?? "",
            height: 58.w,
            width: 58.w,
            borderRadius: BorderRadius.circular(10.w),
          ),
          8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: item.name ?? "",
                  color: Colors.white,
                  fontSize: 14.w,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                TextView(
                  text: item.desc ?? "",
                  color: Colors.white60,
                  fontSize: 11.w,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 30.w,
            width: 76.w,
            decoration: BoxDecoration(
                color: COLOR.color_1F7CFF,
                borderRadius: BorderRadius.circular(20.w)),
            child: TextView(
              text: "立即下载",
              fontSize: 13.w,
              color: COLOR.white,
            ),
          ).onOpaqueTap(() => controller.toDownload(item))
        ],
      ),
    );
  }
}
