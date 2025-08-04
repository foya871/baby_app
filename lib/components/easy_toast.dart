/*
 * @Author: wangdazhuang
 * @Date: 2024-08-26 11:32:38
 * @LastEditTime: 2024-10-31 11:17:19
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/src/components/easy_toast.dart
 */
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter/material.dart';

abstract class EasyToast {
  EasyToast._();
  static void show(
    String text, {
    Alignment? alignment,
  }) {
    SmartDialog.showToast(text, alignment: alignment ?? Alignment.center);
  }
}
