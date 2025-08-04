/*
 * @Author: wangdazhuang
 * @Date: 2024-08-16 16:31:13
 * @LastEditTime: 2025-02-05 19:04:16
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/utils/logger.dart
 */
import 'package:logger/web.dart';

import '../env/environment_service.dart';

final logger = Logger(
  level: Environment.enableAPiLog ? Level.debug : Level.off,
  // printer: SimplePrinter(colors: false, printTime: false),
  printer: PrettyPrinter(
    colors: false,
    printEmojis: false,
    levelEmojis: null,
    methodCount: 0,
    lineLength: 300,
  ),
);
