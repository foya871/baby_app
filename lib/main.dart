/*
 * @Author: wangdazhuang
 * @Date: 2024-08-15 17:14:24
 * @LastEditTime: 2025-07-10 14:50:56
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/main.dart
 */

import 'package:baby_app/app.dart';
import 'package:baby_app/app_prepare.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {};
  MediaKit.ensureInitialized();
  await AppPrepare.init();
  runApp(const MainApp());
}
