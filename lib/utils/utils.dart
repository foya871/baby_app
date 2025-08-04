/*
 * @Author: wangdazhuang
 * @Date: 2024-08-27 08:59:00
 * @LastEditTime: 2024-09-05 14:34:18
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/src/utils/utils.dart
 */
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:baby_app/utils/logger.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

abstract class Utils {
  static final _random = Random();

  static String secondsToTime(int? duration,
      {String defaultValue = '', bool short = true}) {
    if (duration == null || duration <= 0) return defaultValue;

    final dInt = duration.floor();
    final h = dInt ~/ 3600;
    final m = (dInt - (h * 3600)) ~/ 60;
    final s = dInt % 60;
    List<int> arr = [h, m, s];
    if (short) {
      arr = arr.trimLeading((e) => e == 0);
    }

    return arr.map((e) => '$e'.padLeft(2, '0')).join(':');
  }

  /// k w化处理
  static String numFmt(int number, {bool upper = false}) {
    var shortForm = "";
    final k = upper ? 'K' : 'k';
    final w = upper ? 'W' : 'w';
    if (number < 1000) {
      shortForm = number.toString();
    } else if (number >= 1000 && number < 10000) {
      shortForm = "${(number / 1000).toStringAsFixed(1)}$k";
    } else {
      shortForm = "${(number / 10000).toStringAsFixed(1)}$w";
    }
    return shortForm;
  }

  static String numFmtCh(int number) {
    var shortForm = '';
    if (number < 10000) {
      shortForm = number.toString();
    } else {
      shortForm = '${(number / 10000).toStringAsFixed(1)}万';
    }
    return shortForm;
  }

  static String dateFmt(
    String v, [
    List<String> formats = const ['yyyy', '.', 'mm', '.', 'dd'],
    bool toCST = true,
  ]) {
    var result = '';
    const cstOffset = Duration(hours: 8);
    final now = DateTime.now().toUtc(); // 当前UTC时间
    final threeDaysAgo = now.subtract(const Duration(days: 3)); // 三天前UTC时间

    try {
      // 解析输入日期并转为UTC
      final date = v.isEmpty ? now : DateTime.parse(v).toUtc();

      // 判断是否大于等于三天前（日期在三天前或更早）
      if (date.isBefore(threeDaysAgo) || date.isAtSameMomentAs(threeDaysAgo)) {
        return "三天前";
      }

      // 时区转换（如需转CST）
      if (toCST) {
        final cstDate = date.add(cstOffset); // UTC +8小时转为CST
        result = formatDate(cstDate, formats);
      } else {
        result = formatDate(date, formats);
      }
    } on Exception catch (e) {
      logger.d("dateFmt parse error: $e");
      result = v; // 解析失败返回原始值
    }
    return result;
  }

  // 1分钟前, 1小时前,1天前,1个月前,1年前
  static String dateAgo(String v) {
    const hoursPerDay = 24;
    const daysPerMonth = 30;
    const hoursPerMonth = 24 * daysPerMonth;
    const daysPerYear = 365;
    const monthsPerYear = 12;
    const hoursPerYear = hoursPerMonth * monthsPerYear;
    final date = DateTime.tryParse(v);
    if (date == null) return '';
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff < const Duration(minutes: 1)) {
      return '刚刚';
    } else if (diff < const Duration(hours: 1)) {
      return '${diff.inMinutes}分钟前';
    } else if (diff < const Duration(days: 1)) {
      return '${diff.inHours}小时前';
    } else if (diff < const Duration(days: daysPerMonth)) {
      return '${diff.inHours ~/ hoursPerDay}天前';
    } else if (diff < const Duration(days: daysPerYear)) {
      return '${diff.inHours ~/ hoursPerMonth}个月前';
    } else {
      return '${diff.inHours ~/ hoursPerYear}年前';
    }
  }

  static String formatTime(String timeString) {
    if (timeString == "") {
      return "";
    }
    // 解析时间字符串为 DateTime 对象
    DateTime inputDateTime = DateTime.parse(timeString);

    // 获取当前时间
    DateTime now = DateTime.now();

    // 获取今天的起始时间（00:00:00）
    DateTime startOfDay = DateTime(now.year, now.month, now.day);

    // 获取昨天的日期
    DateTime yesterday = startOfDay.subtract(const Duration(days: 1));

    // 获取前天的日期
    DateTime dayBeforeYesterday = startOfDay.subtract(const Duration(days: 2));

    // 判断时间与当前日期的关系
    if (inputDateTime.isAfter(startOfDay)) {
      // 如果是今天，显示时间（HH:mm:ss）
      return inputDateTime.toString().substring(11, 19); // 提取 HH:mm:ss 部分
    } else if (inputDateTime.isAfter(yesterday) &&
        inputDateTime.isBefore(startOfDay)) {
      // 如果是昨天
      return "昨天";
    } else if (inputDateTime.isAfter(dayBeforeYesterday) &&
        inputDateTime.isBefore(yesterday)) {
      // 如果是前天
      return "前天";
    } else {
      // 如果是更早的日期，显示完整日期（yyyy-MM-dd）
      return inputDateTime.toString().substring(0, 10); // 提取 yyyy-MM-dd 部分
    }
  }

  static TextPainter _textPainter(
    String text, {
    required double maxWidth,
    TextStyle? style,
    TextDirection textDirection = TextDirection.ltr,
  }) {
    final span = TextSpan(text: text, style: style);
    final painter = TextPainter(text: span, textDirection: textDirection);
    painter.layout(maxWidth: maxWidth);
    return painter;
  }

  static Size sizeOfText(String text,
      {required double maxWidth, TextStyle? style}) {
    final painter = _textPainter(text, maxWidth: maxWidth);
    return Size(painter.width, painter.height);
  }

  ///计算问题高度
  static double heigthOfText(String text, double fontSize,
      FontWeight fontWeight, double maxWidth, int maxLines) {
    TextPainter textPainter = TextPainter(
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontWeight: fontWeight, //字重
          fontSize: fontSize, //字体大小
        ),
      ),
    );
    //最大宽度
    textPainter.layout(maxWidth: maxWidth);
    //返回高度
    return textPainter.height;
  }

  // 行数
  static int linesOfText(String text,
      {required double maxWidth, TextStyle? style}) {
    final painter = _textPainter(text, maxWidth: maxWidth);
    return painter.computeLineMetrics().length;
  }

  ///计算文本宽度
  static calculateTextWidth(String text, TextStyle style, double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    return textPainter.size.width;
  }

  static String md5Bytes(Uint8List bytes) => md5.convert(bytes).toString();

  static String md5String(String s) => md5.convert(utf8.encode(s)).toString();

  // [0, max)
  static int randInt(int max) => _random.nextInt(max);

  static T? asType<T>(dynamic value, {T? defaultValue}) {
    if (value == null) return null;
    return value is T ? value : defaultValue;
  }

  static List<String> get alphabetUpper =>
      List.generate(26, (i) => String.fromCharCode(i + 65));

  ///根据秒计算时长
  static String convertSeconds(int totalSeconds) {
    int days = totalSeconds ~/ 86400; // 计算天数
    int hours = (totalSeconds % 86400) ~/ 3600; // 计算小时
    int minutes = (totalSeconds % 3600) ~/ 60; // 计算分钟
    int seconds = totalSeconds % 60; // 计算秒数

    // 格式化小时、分钟和秒数，确保为两位数
    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');

    // 构建结果字符串
    if (days > 0) {
      return '$days天 $formattedHours:$formattedMinutes:$formattedSeconds';
    } else if (hours > 0) {
      return '$formattedHours:$formattedMinutes:$formattedSeconds';
    } else {
      return '$formattedMinutes:$formattedSeconds';
    }
  }

  /// 日期格式化工具函数
  /// [dateStr]：输入的日期字符串，格式应为 ISO 8601（例如："2000-01-01T01:01:01.748Z"）
  /// [toLocal]：是否将时间转换为本地时区时间，默认为 true
  /// [dateSeparator]：日期部分的分隔符，例如 '-', '.', '/'，默认为 '-'
  /// [timeSeparator]：时间部分的分隔符，例如 ':', '.'，默认为 ':'
  /// [dateTimeSeparator]：日期和时间之间的分隔符，默认为一个空格 ' '
  /// [precision]：输出的精度，可选值为 'year', 'month', 'day', 'hour', 'minute', 'second'，默认为 'second'
  static String dateFormat(
    String date, {
    bool toLocal = true,
    String dateSeparator = '-',
    String timeSeparator = ':',
    String dateTimeSeparator = ' ',
    String precision = 'second',
  }) {
    try {
      DateTime dateTime = DateTime.parse(date);
      if (toLocal) {
        dateTime = dateTime.toLocal();
      }

      // 构建日期部分
      final year = dateTime.year.toString().padLeft(4, '0');
      if (precision == 'year') return year;
      final month = dateTime.month.toString().padLeft(2, '0');
      if (precision == 'month') return [year, month].join(dateSeparator);
      final day = dateTime.day.toString().padLeft(2, '0');
      if (precision == 'day') return [year, month, day].join(dateSeparator);

      final datePart = [year, month, day].join(dateSeparator);

      // 构建时间部分
      final hour = dateTime.hour.toString().padLeft(2, '0');
      if (precision == 'hour') return '$datePart$dateTimeSeparator$hour';
      final minute = dateTime.minute.toString().padLeft(2, '0');
      if (precision == 'minute') {
        return '$datePart$dateTimeSeparator$hour$timeSeparator$minute';
      }
      final second = dateTime.second.toString().padLeft(2, '0');
      if (precision == 'second') {
        return '$datePart$dateTimeSeparator$hour$timeSeparator$minute$timeSeparator$second';
      }
      return '$datePart$dateTimeSeparator$hour$timeSeparator$minute$timeSeparator$second';
    } catch (e) {
      return '';
    }
  }

  //日期格式化，带横杠链接
  static String dateFmtWith(
    String v, [
    List<String> formats = const ['yyyy', '-', 'mm', '-', 'dd'],
    bool toCST = true,
  ]) {
    var result = '';
    const cstOffset = Duration(hours: 8);

    try {
      DateTime date = v.isEmpty ? DateTime.now() : DateTime.parse(v);
      if (toCST && date.timeZoneOffset.compareTo(cstOffset) != 0) {
        // 这里add之后仍然是utc时间
        // !! 如果使用 z Z 时区相关format会有问题
        date = date.toUtc().add(cstOffset);
      }

      result = formatDate(date, formats);
    } on Exception catch (e) {
      logger.d("dateFmt pasrse error:$e");
    }
    return result;
  }

  static Future<bool> checkNetworkStatus() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (!connectivityResult.contains(ConnectivityResult.none)) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  ///文字高度
  static double textHeight(String text, double fontSize, FontWeight fontWeight,
      double maxWidth, int maxLines) {
    TextPainter textPainter = TextPainter(
        //用于选择用户的语言和格式首选项的标识符。
        locale: WidgetsBinding.instance.window.locale,
        //最大行数
        maxLines: maxLines,
        //文本书写方向l to r 汉字从左到右
        textDirection: TextDirection.ltr,
        //文本内容以及文本样式 style:可以根据在代码中设置的TextStyle增加字段。
        text: TextSpan(
            text: text,
            style: TextStyle(
              fontWeight: fontWeight, //字重
              fontSize: fontSize, //字体大小
            )));
    //最大宽度
    textPainter.layout(maxWidth: maxWidth);
    //返回高度
    return textPainter.height;
  }
}
