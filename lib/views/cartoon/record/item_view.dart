import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

class ItemView extends StatelessWidget {
  static final width = 163.w;
  static final bigImageHeight = 238.w;
  static final smallImageHeight = 216.w;

  final String status;
  final String coverImageUrl;
  final String title;
  final int useCount;
  final bool isBig;
  final double imageWidth;
  final double imageHeight;
  final Function() onTap;
  final Function() onSaveTap;
  final Function() onAppealTap;
  final Function() onDeleteTap;

  ItemView({
    super.key,
    required this.status,
    required this.coverImageUrl,
    required this.title,
    required this.useCount,
    required this.isBig,
    required this.onTap,
    required this.onSaveTap,
    required this.onAppealTap,
    required this.onDeleteTap,
  })  : imageWidth = width,
        imageHeight = isBig ? bigImageHeight : smallImageHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ImageView(
              src: coverImageUrl,
              width: imageWidth,
              height: imageHeight,
              borderRadius: BorderRadius.circular(8.w),
            ).onOpaqueTap(onTap),
            Positioned.fill(
              child: Center(
                child: status == 'success'
                    ? AppBgView(
                        height: 40.w,
                        radius: 8.w,
                        margin: EdgeInsets.symmetric(horizontal: 25.w),
                        text: '人工制作中\n24小时制作完成',
                        textSize: 12.w,
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: status == 'received' || status == 'error'
                  ? _buildStatusView(status == 'received' ? '火速制作中' : '生成失败')
                  : _buildOperationView(),
            ),
          ],
        ),
        6.verticalSpace,
        TextView(
          text: title,
          fontSize: 13.w,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        12.verticalSpace,
      ],
    ).onOpaqueTap(() {
      // Get.bottomSheet();
    });
  }

  _buildStatusView(String desc) {
    return AppBgView(
      height: 26.w,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8.w),
        bottomRight: Radius.circular(8.w),
      ),
      text: desc,
      textSize: 13.w,
    );
  }

  _buildOperationView() {
    return Row(
      children: [],
    ).marginSymmetric(horizontal: 6.w, vertical: 10.w);
  }

  _buildOperationItemView(String title, Color color) {
    return AppBgView(
      height: 24.w,
      radius: 12.w,
      backgroundColor: color.withOpacity(0.7),
      text: title,
      textSize: 12.w,
      onTap: () {
        if (title == '保存') {
          onSaveTap();
        }
        if (title == '申诉') {
          showAlertDialog(
            Get.context!,
            title: '是否要进行人工申诉重新制作',
            onRightButton: onAppealTap,
          );
        }
        if (title == '删除') {
          showAlertDialog(
            Get.context!,
            title: '确定要删除该条记录',
            onRightButton: onDeleteTap,
          );
        }
      },
    );
  }
}
