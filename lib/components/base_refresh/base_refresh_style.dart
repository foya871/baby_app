/*
 * @Author: wangdazhuang
 * @Date: 2024-09-23 14:09:30
 * @LastEditTime: 2024-09-26 10:56:31
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /yuseman_app/lib/src/components/base_refresh/base_refresh_style.dart
 */
import 'package:baby_app/utils/color.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:flutter/material.dart';

class _DefaultHeader extends ClassicHeader {
  _DefaultHeader({super.position, Color? iconColor, Color? textColor})
      : super(
          dragText: "下拉刷新",
          armedText: "松开后开始刷新",
          readyText: "正在刷新",
          processedText: "刷新完成",
          processingText: "正在刷新",
          failedText: '刷新失败',
          showMessage: false,
          iconTheme:
              IconThemeData(color: iconColor ?? COLOR.hexColor("#676c73")),
          textStyle: kTextStyle(textColor ?? COLOR.hexColor("#676c73")),
          spacing: 3.0,
        );
}

class _DefaultFooter extends ClassicFooter {
  _DefaultFooter({super.position, Color? iconColor, Color? textColor})
      : super(
          dragText: "上拉加载更多",
          armedText: "松开后开始加载",
          readyText: "正在加载...",
          processedText: "加载完成",
          processingText: "正在加载...",
          noMoreText: "没有更多了",
          failedText: '加载失败',
          noMoreIcon: null,
          spacing: 3.0,
          showMessage: false,
          iconTheme:
              IconThemeData(color: iconColor ?? COLOR.hexColor("#676c73")),
          textStyle: kTextStyle(textColor ?? COLOR.hexColor("#676c73")),
        );
}

abstract class BaseRefreshStyle {
  static Header defaultHeaderBuilder({Color? iconColor, Color? textColor}) =>
      _DefaultHeader(iconColor: iconColor, textColor: textColor);

  static Header locatorHeaderBuilder({Color? iconColor, Color? textColor}) =>
      _DefaultHeader(
        position: IndicatorPosition.locator,
        iconColor: iconColor,
        textColor: textColor,
      );

  static Footer defaultFooterBuilder({Color? iconColor, Color? textColor}) =>
      _DefaultFooter(iconColor: iconColor, textColor: textColor);
  static Footer locatorFooterBuilder({Color? iconColor, Color? textColor}) =>
      _DefaultFooter(
        position: IndicatorPosition.locator,
        iconColor: iconColor,
        textColor: textColor,
      );
}
