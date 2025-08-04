import 'package:baby_app/components/image_upload/image_upload.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/community/release/community_release_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommunityReleaseTopicPage extends GetView<CommunityReleasePageController> {
  const CommunityReleaseTopicPage({super.key});

  _buildContent() {
    return Container(
      width: double.infinity,
      height: 250.w,
      decoration: const BoxDecoration(
        color: COLOR.transparent,
      ),
      child: TextField(
        focusNode: controller.focusNode,
        controller: controller.contentEditingController,
        maxLines: null,
        maxLength: controller.maxLength,
        keyboardType: TextInputType.multiline,
        style: TextStyle(
          color: COLOR.white,
          fontSize: 13.w,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
          hintText: '请输入帖子内容…',
          counterText: '',
          hintStyle: TextStyle(
            color: COLOR.white_60,
            fontSize: 13.w,
          ),
          border: InputBorder.none,
        ),
      ),
    ).sliver;
  }

  _buildImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text(
              '选择图片',
              style: TextStyle(
                color: COLOR.white,
                fontSize: 16.w,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '(最多选择9张图片)',
              style: TextStyle(
                color: COLOR.white_60,
                fontSize: 12.w,
              ),
            ).marginOnly(left: 7.w),
          ],
        ),
        ImageUpload(
          success: (v) {
            controller.addImages(v);
          },
        ).marginOnly(top: 12.w),
      ],
    ).marginOnly(top: 10.w).sliver;
  }

  _buildTopic() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text(
              '选择话题',
              style: TextStyle(
                color: COLOR.white,
                fontSize: 16.w,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '(最多选择1个话题)',
              style: TextStyle(
                color: COLOR.white_60,
                fontSize: 12.w,
              ),
            ).marginOnly(left: 7.w),
          ],
        ),
        Obx((){
          return controller.topics01.isNotEmpty
            ? Wrap(
              spacing: 7.w,
              runSpacing: 8.w,
              children: controller.topics01.asMap().entries.map((e) {
                var model = e.value;
                return Container(
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: model.selected == true
                        ? COLOR.color_009FE8
                        : COLOR.white_10,
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 8.w, top: 8.w, right: 8.w),
                    child: Text(
                      '#${model.name}',
                      style: TextStyle(
                        color: model.selected == true
                            ? COLOR.white
                            : COLOR.white_80,
                        fontSize: 13.w,
                      ),
                    ),
                  ),
                ).onOpaqueTap(() {
                  controller.notifyChanged(e.key);
                });
              }).toList()).marginOnly(top: 12.w)
            : const SizedBox.shrink();
        }),
      ],
    ).marginOnly(top: 20.w, bottom: 80.w).sliver;
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              _buildContent(),
              _buildImage(),
              _buildTopic(),
            ],
          ).marginOnly(left: 10.w, right: 10.w),
        ),
      ],
    );
  }
}