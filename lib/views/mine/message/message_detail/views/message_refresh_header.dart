import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/utils/color.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class MessageRefreshHeader extends ClassicHeader {
  MessageRefreshHeader({super.position, Color? iconColor, Color? textColor})
      : super(
          dragText: "",
          armedText: "",
          readyText: "",
          processedText: "",
          processingText: "",
          failedText: '加载失败',
          showMessage: false,
          iconTheme:
              IconThemeData(color: iconColor ?? COLOR.hexColor("#676c73")),
          textStyle: kTextStyle(textColor ?? COLOR.hexColor("#676c73")),
          spacing: 3.0,
        );
}
