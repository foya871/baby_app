import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:screenshot/screenshot.dart';

import '../assets/styles.dart';
import '../components/save_screen/save_screen.dart';
import 'color.dart';

void saveAccountDialog(BuildContext context, String account, String pwd,
    bool isLogin, String url) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoadingDialog(account, pwd, isLogin, url);
      });
}

void closeSaveAccountDialog(BuildContext context) {
  Navigator.pop(context);
}

class LoadingDialog extends Dialog {
  final String account;
  final String pwd;
  final bool isLogin;
  final String url;

  const LoadingDialog(this.account, this.pwd, this.isLogin, this.url,
      {super.key});

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();

    void onCLick() {
      SaveScreen.onCaptureClick(context, screenshotController);
    }

    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: SizedBox(
                width: 300.0,
                height: 322.0,
                child: Container(
                  decoration: const ShapeDecoration(
                    color: Color(0xffffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '保存账号卡',
                        style: TextStyle(
                          color: COLOR.hexColor('#333333'),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15.w)),
                      Divider(
                        height: 1.0,
                        color: COLOR.hexColor('#F0F0F0'),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15.w)),
                      Text(
                        '请保存账号卡，防止丢失账号密码',
                        style: TextStyle(
                          color: COLOR.hexColor('#333333'),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10.w),
                      Text(
                        '请谨慎保留账号卡，切勿分享给他人',
                        style: TextStyle(
                          color: COLOR.themeSelectedColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 27.w)),
                      Container(
                        margin: EdgeInsets.only(left: 17.w, right: 17.w),
                        width: double.maxFinite,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: COLOR.hexColor('#F5F5F5'),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              account,
                              style: TextStyle(
                                fontSize: 14.w,
                                color: COLOR.hexColor('#333333'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 12.w)),
                      Container(
                        margin: EdgeInsets.only(left: 17.w, right: 17.w),
                        width: double.maxFinite,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: COLOR.hexColor('#F5F5F5'),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              pwd,
                              style: TextStyle(
                                fontSize: 14.w,
                                color: COLOR.hexColor('#333333'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.w),
                      Text(
                        '最新域名',
                        style: TextStyle(
                          color: COLOR.hexColor('#333333'),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10.w),
                      Text(
                        url,
                        style: TextStyle(
                          color: COLOR.hexColor('#333333'),
                          fontSize: 14.w,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 18.w)),
            InkWell(
              highlightColor: Styles.color.bgColor,
              splashColor: Styles.color.bgColor,
              onTap: () => onCLick(),
              child: AppBgView(
                width: 260.w,
                height: 36.w,
                fit: BoxFit.fill,
                // imagePath: AppImagePath.mine_img_save_account_btn,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin == true ? "保存账号卡并登录" : "保存账号卡",
                      style: TextStyle(
                        fontSize: 16.w,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
