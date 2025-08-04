import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/utils/color.dart';

class WidgetUtils {
  ///构建文本框
  static Widget buildTextField(double? width, double? height, double textSize,
      Color textColor, String? hint,
      {Color backgroundColor = Colors.white,
      Color hintColor = COLOR.color_959595,
      String? defText,
      ValueChanged<String>? onChanged,
      TextInputType? inputType,
      bool obscureText = false,
      bool autofocus = false,
      bool enabled = true,
      bool suffixIcon = false,
      int maxLines = 1,
      int? maxLength,
      EdgeInsetsGeometry? padding,
      List<TextInputFormatter>? inputFormatters,
      TextEditingController? controller,
      InputBorder? focusedBorder,
      FocusNode? focusNode}) {
    padding ??= EdgeInsets.symmetric(horizontal: 10.w);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      padding: padding,
      width: width,
      height: height,
      alignment: Alignment.center,
      child: suffixIcon
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    (defText == "" ? hint : defText) ?? '',
                    style: TextStyle(
                        fontSize: textSize,
                        color: defText == "" ? hintColor : textColor,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                // Icon(Icons.keyboard_arrow_down,size: 18.r,color: Colors.black54),
              ],
            )
          : TextField(
              autofocus: autofocus,
              enabled: enabled,
              // cursorHeight: textSize,
              cursorColor: COLOR.black,
              maxLines: maxLines,
              maxLength: maxLength,
              focusNode: focusNode,
              controller: controller ??
                  TextEditingController.fromValue(TextEditingValue(
                      text: defText ?? '',
                      selection: TextSelection.fromPosition(TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: (defText ?? '').length)))),
              onChanged: onChanged,
              keyboardType: inputType,
              inputFormatters: inputFormatters,
              obscureText: obscureText,
              style: TextStyle(
                  fontSize: textSize,
                  color: textColor,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                enabled: enabled,
                isCollapsed: true,
                errorBorder: InputBorder.none,
                focusedBorder: focusedBorder,
                focusedErrorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintStyle: TextStyle(fontSize: textSize, color: hintColor),
                labelStyle: TextStyle(fontSize: textSize, color: hintColor),
                errorStyle: TextStyle(fontSize: textSize, color: hintColor),
              ),
            ),
    );
  }

  static AppBar buildAppBar(String title,
      {SystemUiOverlayStyle? systemOverlayStyle, List<Widget>? actions}) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 16.w,
            color: COLOR.color_111316,
            fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      elevation: 0,
      toolbarHeight: 44.h,
      systemOverlayStyle: systemOverlayStyle,
      actions: actions,
    );
  }
}
