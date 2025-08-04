import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/utils/color.dart';

import 'login_register_page_controller.dart';

class LoginRegisterPage extends GetView<LoginRegisterPageController> {
  const LoginRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              controller.isHaveAccount.value ? "切换账号" : '登录/注册',
            )),
      ),
      body: _buildBodyView(),
    );
  }

  _buildBodyView() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          90.verticalSpace,
          _buildTitleView('账号'),
          _buildInputView(controller.accountController, '请输入至少6位数账号', false,
              inputFormatters: [
                FilteringTextInputFormatter.deny(
                  RegExp(r'[\u4E00-\u9FFF\u3000-\u303F]'), // 阻止中文和中文标点
                ),
                LengthLimitingTextInputFormatter(20),
              ]),
          30.verticalSpace,
          _buildTitleView('密码'),
          _buildInputView(controller.passwordController, '请输入至少6位数密码', true),
          50.verticalSpace,
          Row(
            children: [
              if (!controller.isHaveAccount.value) ...[
                Expanded(
                    child:
                        _buildButtonView('注册', () => controller.submit(true))),
                20.horizontalSpace,
              ],
              Expanded(
                child: Obx(() => _buildButtonView(
                    controller.isHaveAccount.value ? "切换账号" : '登录',
                    () => controller.submit(false))),
              ),
            ],
          ),
          42.verticalSpace,
          TextView(
            text: '温馨提示：',
            fontSize: 14.w,
            color: COLOR.white,
            fontWeight: FontWeight.w500,
          ),
          12.verticalSpace,
          TextView(
            text: '1. 账号密码必须是6位以上的字母加数字组合\n'
                '2. 请务必记住自己的账号密码，不提供密码修改和找回\n'
                '3. 请勿把账号分享给别人，如遗失账号平台概不负责',
            fontSize: 12.w,
            color: COLOR.white,
          ),
        ],
      ),
    );
  }

  _buildTitleView(String title) {
    return TextView(
      text: title,
      fontSize: 16.w,
      color: COLOR.white,
      fontWeight: FontWeight.w500,
    );
  }

  _buildInputView(
    TextEditingController controller,
    String hintText,
    bool obscureText, {
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: COLOR.white, fontSize: 14.w),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: COLOR.white.withValues(alpha: 0.6)),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: COLOR.white.withValues(alpha: 0.2),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: COLOR.themeSelectedColor,
          ),
        ),
      ),
    );
  }

  _buildButtonView(String title, Function() onTap) {
    return AppBgView(
      height: 44.w,
      radius: 22.w,
      backgroundColor:
          title == '注册' ? COLOR.transparent : COLOR.themeSelectedColor,
      border: Border.all(
        color: title == '注册' ? COLOR.themeSelectedColor : COLOR.transparent,
        width: 1.w,
      ),
      text: title,
      textColor: title == '注册' ? COLOR.themeSelectedColor : COLOR.white,
      textSize: 15.w,
      onTap: onTap,
    );
  }
}
