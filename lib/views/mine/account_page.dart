import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../components/save_screen/save_screen.dart';
import '../../components/text_view.dart';
import '../../services/user_service.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final userService = Get.find<UserService>();

  var screenController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQRView(),
          40.verticalSpace,
          AppBgView(
            height: 40.w,
            radius: 20.w,
            backgroundColor: COLOR.themeSelectedColor,
            margin: EdgeInsets.symmetric(horizontal: 40.w),
            text: "保存到相册",
            textColor: COLOR.white,
            textSize: 14.w,
            onTap: () {
              SaveScreen.onCaptureClick(Get.context!, screenController,
                  isBack: false);
              dismiss();
            },
          )
        ],
      ).marginHorizontal(40.w),
    );
  }

  _buildQRView() {
    return Screenshot(
      controller: screenController,
      child: Center(
        child: AppBgView(
          height: 390.h,
          radius: 12.w,
          imagePath: AppImagePath.mine_account_bg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: TextView(
                      text: '账号凭证',
                      fontSize: 22.w,
                      color: COLOR.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  20.verticalSpace,
                  TextView(
                    text:
                        '账号凭证是除绑定手机号外唯一可以用于恢复/切换账号的凭证，请及时保存 保存后请妥善保管切勿丢失或泄露给他人',
                    fontSize: 13.w,
                    color: COLOR.white.withValues(alpha: 0.8),
                    textAlign: TextAlign.start,
                  ),
                  20.verticalSpace,
                  TextView(
                    text: '您的账号信息',
                    fontSize: 15.w,
                    color: COLOR.white,
                    fontWeight: FontWeight.w600,
                  ),
                  10.verticalSpace,
                  _buildItemView('用户名', userService.user.nickName ?? ""),
                  10.verticalSpace,
                  _buildItemView('用户ID', "${userService.user.userId ?? 0}"),
                ],
              ).marginHorizontal(15.w),
              30.verticalSpace,
              AppBgView(
                backgroundColor: COLOR.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.w),
                  bottomRight: Radius.circular(12.w),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: '扫描二维码恢复账号',
                            fontSize: 14.w,
                            color: COLOR.color_333333,
                            fontWeight: FontWeight.w600,
                          ),
                          3.verticalSpace,
                          TextView(
                            text: "https://luanlun51.com/account?code=123456",
                            fontSize: 13.w,
                            color: COLOR.color_333333.withValues(alpha: 0.8),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    15.horizontalSpace,
                    AppBgView(
                      radius: 4.w,
                      border: Border.all(
                          color: COLOR.color_333333.withValues(alpha: 0.2),
                          width: 1.w),
                      child: QrImageView(
                        padding: EdgeInsets.all(5.w),
                        data: "https://luanlun51.com",
                        size: 65.w,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ).marginHorizontal(15.w),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildItemView(String title, String text) {
    return Row(
      children: [
        TextView(
          text: title,
          fontSize: 14.w,
          color: COLOR.white,
        ),
        5.horizontalSpace,
        Expanded(
          child: AppBgView(
            height: 38.w,
            radius: 19.w,
            backgroundColor: COLOR.white.withValues(alpha: 0.1),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            text: text,
            textColor: COLOR.white.withValues(alpha: 0.8),
            textSize: 14.w,
          ),
        ),
      ],
    );
  }
}
