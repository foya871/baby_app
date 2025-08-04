import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../components/app_bg_view.dart';
import '../../../../../components/image_view.dart';
import '../../../../../components/save_screen/save_screen.dart';
import '../../../../../components/text_view.dart';
import '../../../../../generate/app_image_path.dart';
import '../../../../../routes/routes.dart';
import '../../../../../services/user_service.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../../utils/color.dart';
import 'share_conten_controller.dart';

class ShareContenPage extends StatelessWidget {
  ShareContenPage({super.key});

  final ShareContenController controller = Get.put(ShareContenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShareContenController>(builder: (controller) {
      return _buildBodyView(controller);
    });
  }

  _buildBodyView(ShareContenController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buidleTopbg(),
          _buildText(),
          10.verticalSpace,
          _buildQRView(controller),
          20.verticalSpace,
          _buildOperationView(controller),
          20.verticalSpace,
          Center(
            child: ImageView(
              src: AppImagePath.mine_share_topinfo,
              height: 20.w,
              width: 160.w,
              fit: BoxFit.fill,
            ),
          ),
          20.verticalSpace,
          ImageView(
            src: AppImagePath.mine_share_tips,
            height: 514.w,
            fit: BoxFit.fill,
          ),
          30.verticalSpace,
        ],
      ),
    );
  }

  _buildText() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      20.verticalSpace,
      TextView(
        text: "规则说明",
        fontSize: 16.w,
        fontWeight: FontWeight.w500,
        color: COLOR.white,
      ).marginBottom(8.w),
      EasyRichText(
        '1. 邀请1名好友成功注册即可获得1天VIP',
        defaultStyle: TextStyle(
          color: Colors.white,
          fontSize: 13.w,
        ),
        patternList: [
          EasyRichTextPattern(
            targetString: '1. 邀请1名好友成功注册即可获得1天VIP',
            style: TextStyle(color: COLOR.color_009FE8, fontSize: 13.w),
          ),
        ],
      ).marginBottom(8.w),
      EasyRichText(
        '2. 邀请好友产生充值可获充值最高70%返利收益',
        defaultStyle: TextStyle(
          color: Colors.white,
          fontSize: 13.w,
        ),
        patternList: [
          EasyRichTextPattern(
            targetString: '充值最高70%返利收益',
            style: TextStyle(color: COLOR.color_009FE8, fontSize: 13.w),
          ),
        ],
      ).marginBottom(8.w),
      EasyRichText(
        '如：邀请好友A, A冲值100元年卡VIP，即可获得70元收益，可提现',
        defaultStyle: TextStyle(
          color: Colors.white,
          fontSize: 13.w,
        ),
        patternList: [
          EasyRichTextPattern(
            targetString: '100元年卡VIP，即可获得70元收益，可提现',
            style: TextStyle(color: COLOR.color_009FE8, fontSize: 13.w),
          ),
        ],
      ).marginBottom(8.w),
      TextView(
        text: '邀请说明: 点击 [保存图片] 或 [复制链接] 分享给朋友下载即可',
        color: COLOR.white,
        fontSize: 13.w,
      )
    ]);
  }

  _buidleTopbg() {
    return Container(
      height: 128.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImagePath.ann_share_top_bg),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ImageView(
                src: "${Get.find<UserService>().user.logo}",
                width: 44.w,
                height: 44.w,
                borderRadius: BorderRadius.circular(22.w),
                defaultPlace: AppImagePath.app_default_avatar,
              ),
              8.horizontalSpace,
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TextView(
                  text: "${Get.find<UserService>().user.nickName}",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w500,
                  color: COLOR.color_6b2020,
                ),
                3.verticalSpace,
                TextView(
                  text: "邀请好友快速提现",
                  fontSize: 12.w,
                  color: COLOR.color_6b2020,
                ),
              ]),
              const Spacer(),
              Column(children: [
                TextView(
                  text: "可提现金额",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w500,
                  color: COLOR.color_6b2020,
                ),
                1.verticalSpace,
                TextView(
                  text: "${Get.find<UserService>().assets.gold ?? 0}",
                  color: COLOR.color_6b2020,
                  fontSize: 14.w,
                  fontWeight: FontWeight.w500,
                )
              ])
            ],
          ),
          26.verticalSpace,
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ImageView(
              src: AppImagePath.ann_share_btn_vip,
              width: 98.w,
              height: 36.w,
            ).onOpaqueTap(() => Get.toNamed(Routes.vip)),
            50.horizontalSpace,
            ImageView(
              src: AppImagePath.ann_share_btn_data,
              width: 98.w,
              height: 36.w,
            ).onOpaqueTap(() => Get.toNamed(Routes.sharedata)),
          ])
        ],
      ),
    );
  }

  _buildQRView(ShareContenController controller) {
    return Screenshot(
      controller: controller.screenController,
      child: AppBgView(
        imagePath: AppImagePath.mine_share_bg,
        height: 430.w,
        width: 355.w,
        alignment: Alignment.bottomCenter,
        child: AppBgView(
          height: 115.w,
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.w),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.w),
                ),
                clipBehavior: Clip.hardEdge,
                width: 115.w,
                height: 115.w,
                child: QrImageView(
                  padding: EdgeInsets.all(5.w),
                  data: controller.url.value,
                  backgroundColor: Colors.white,
                ),
              ),
              7.horizontalSpace,
              Expanded(
                child: Container(
                  height: 115.w,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  color: Colors.black.withValues(alpha: 0.45),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: '我的推广码：',
                        fontSize: 18.w,
                        color: COLOR.color_D8D8D8,
                      ),
                      5.verticalSpace,
                      TextView(
                        text: controller.inviteCode.value,
                        fontSize: 24.w,
                        color: COLOR.white,
                        fontWeight: FontWeight.w500,
                      ),
                      5.verticalSpace,
                      TextView(
                        text: controller.url.value,
                        fontSize: 16.w,
                        overflow: TextOverflow.ellipsis,
                        color: COLOR.white.withValues(alpha: 0.8),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildOperationView(ShareContenController controller) {
    return Row(
      children: [
        20.horizontalSpace,
        Expanded(
          child: _buildOperationItemView("保存图片", () {
            SaveScreen.onCaptureClick(Get.context!, controller.screenController,
                isBack: false);
          }),
        ),
        30.horizontalSpace,
        Expanded(
          child: _buildOperationItemView("复制链接", () {
            AppUtils.copyToClipboard(controller.url.value);
          }),
        ),
        20.horizontalSpace,
      ],
    );
  }

  _buildOperationItemView(String title, Function()? onTap) {
    return AppBgView(
      width: double.infinity,
      height: 40.w,
      radius: 20.w,
      backgroundColor: COLOR.themeSelectedColor,
      text: title,
      textSize: 14.w,
      textColor: COLOR.white,
      onTap: onTap,
    );
  }
}
