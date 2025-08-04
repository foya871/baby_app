import 'package:flutter/material.dart';

import '../../assets/styles.dart';
import '../easy_button.dart';

///
/// 点击重新加载
///
class BaseErrorWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  const BaseErrorWidget({super.key, this.textStyle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EasyButton(
          '点击重新加载',
          textStyle: textStyle ?? TextStyle(color: Styles.color.greyWhiteText),
          onTap: onTap,
        )
      ],
    ));
  }
}
