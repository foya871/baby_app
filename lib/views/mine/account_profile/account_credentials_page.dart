import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../../../assets/styles.dart';
import '../../../components/save_screen/save_screen.dart';
import '../../../utils/color.dart';
import 'account_credentials_controller.dart';

///账号凭证
class AccountCredentialsPage extends StatelessWidget {
  const AccountCredentialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = Styles.color.bgColor;
    ScreenshotController screenshotController = ScreenshotController();

    void onBackClick() {
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 20.w,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => onBackClick(),
        ),
        title: Text("账号凭证",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            )),
        centerTitle: true,
      ),
      body: GetBuilder<AccountCredentialsController>(
          init: AccountCredentialsController(),
          builder: (controller) {
            return AccountCredentialsPageChild(
                controller, screenshotController);
          }),
    );
  }
}

class AccountCredentialsPageChild extends StatelessWidget {
  final AccountCredentialsController controller;
  final ScreenshotController screenshotController;

  const AccountCredentialsPageChild(this.controller, this.screenshotController,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 355.w,
                    height: 488.w,
                    child: Stack(
                      children: [
                        Image.asset(
                          AppImagePath.mine_account_profile_bg,
                          width: 355.w,
                          height: 488.w,
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 30.w,
                            child: Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(AppImagePath
                                            .mine_account_qr_code_bg)),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  width: 135.w,
                                  height: 135.w,
                                  padding: EdgeInsets.all(9.w),
                                  child: QrImageView(
                                    padding: EdgeInsets.all(5.w),
                                    data: controller.share.url ?? "",
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                10.verticalSpaceFromWidth,
                                TextView(
                                  text: "用户ID",
                                  fontSize: 16.w,
                                  color: Colors.white,
                                ),
                                6.verticalSpaceFromWidth,
                                TextView(
                                  text: "${controller.us.user.userId ?? 0}",
                                  fontSize: 16.w,
                                  color: COLOR.color_009FE8,
                                  fontWeight: FontWeight.bold,
                                ),
                                7.verticalSpaceFromWidth,
                                TextView(
                                  text: "我的-账号凭证",
                                  fontSize: 14.w,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                5.verticalSpaceFromWidth,
                                Obx(() => TextView(
                                      text:
                                          "永久官网：${controller.permanentAddress.value}",
                                      fontSize: 16.w,
                                      color: COLOR.white,
                                    )),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 28.w)),
            InkWell(
              highlightColor: Styles.color.bgColor,
              splashColor: Styles.color.bgColor,
              onTap: () =>
                  SaveScreen.onCaptureClick(context, screenshotController),
              child: Container(
                width: 280.w,
                height: 41.w,
                decoration: BoxDecoration(
                  color: COLOR.color_009FE8,
                  borderRadius: BorderRadius.circular(21.w),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "保存账号凭证",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: COLOR.hexColor('#ffffff'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
