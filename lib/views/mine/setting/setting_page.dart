import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:tuple/tuple.dart';

import '../../../components/image_view.dart';
import '../../../generate/app_image_path.dart';
import 'setting_page_controller.dart';

class SettingPage extends GetView<SettingPageController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: Column(
        children: [
          Expanded(child: _buildBodyView()),
          _buildSaveView(),
        ],
      ),
    );
  }

  _buildBodyView() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          35.verticalSpace,
          _buildAvatarView(), //头像
          50.verticalSpace,
          Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: controller.list.length,
                itemBuilder: (context, index) {
                  final item = controller.list[index];
                  return _buildItemView(item);
                },
              )),
        ],
      ),
    );
  }

  ///头像
  _buildAvatarView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => ImageView(
              src: controller.avatar.value,
              width: 90.w,
              height: 90.w,
              borderRadius: BorderRadius.circular(45.w),
              defaultPlace: AppImagePath.app_default_avatar,
            )),
        8.verticalSpace,
        TextView(
          text: '点击更换头像',
          fontSize: 14.w,
          color: COLOR.white.withValues(alpha: 0.8),
        ),
      ],
    ).onOpaqueTap(() => controller.onClick('头像'));
  }

  _buildItemView(Tuple2 item) {
    if (item.item1 == '用户昵称') {
      controller.nickNameController.text = item.item2;
    }
    return SizedBox(
      height: 55.w,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                TextView(
                  text: item.item1,
                  fontSize: 16.w,
                  color: COLOR.white.withValues(alpha: 0.8),
                ),
                Expanded(
                  child: item.item1 == "用户昵称"
                      ? _buildInputView()
                      : _buildTextRightView(item),
                ),
              ],
            ),
          ),
          Container(
            color: COLOR.white.withValues(alpha: 0.1),
            height: 1,
          ),
        ],
      ),
    );
  }

  _buildInputView() {
    return TextField(
      controller: controller.nickNameController,
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 14.w,
        color: COLOR.white,
      ),
      decoration: InputDecoration(
        hintText: '用户名最多8个字',
        hintStyle: TextStyle(
          fontSize: 14.w,
          color: COLOR.white.withValues(alpha: 0.6),
        ),
        border: InputBorder.none,
      ),
    );
  }

  _buildTextRightView(Tuple2 item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (item.item1 == "检查更新" && item.item2 != "已是最新版本")
          //红点
          ...[
          Container(
            width: 5.w,
            height: 5.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: COLOR.color_FE0303,
              borderRadius: BorderRadius.circular(2.5.w),
            ),
          ),
          5.horizontalSpace,
        ],
        if (item.item1 != "用户昵称")
          TextView(
            text: item.item2,
            fontSize: 14.w,
            color: item.item1 == "用户ID" || item.item1 == "切换账号"
                ? COLOR.white
                : COLOR.white.withValues(alpha: 0.6),
          ),
        if (item.item1 == "登录注册" ||
            item.item1 == "切换账号" ||
            item.item1 == "清除缓存" ||
            item.item1 == "检查更新") ...[
          10.horizontalSpace,
          Icon(
            Icons.arrow_forward_ios,
            size: 10.w,
            color: COLOR.color_666666,
          )
        ],
      ],
    ).onOpaqueTap(() => controller.onClick(item.item1));
  }

  ///保存按钮
  _buildSaveView() {
    return AppBgView(
      height: 40.w,
      radius: 20.w,
      backgroundColor: COLOR.themeSelectedColor,
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.w),
      text: '保存',
      textColor: COLOR.white,
      textSize: 14.w,
      onTap: () => controller.onClick('保存'),
    );
  }
}
