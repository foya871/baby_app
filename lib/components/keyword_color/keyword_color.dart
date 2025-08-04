/*
 * @Author: ziqi jhzq12345678
 * @Date: 2025-01-17 17:11:58
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2025-01-17 17:25:47
 * @FilePath: /baby_app/lib/components/keyword_color/keyword_color.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';

class KeywordColor extends StatelessWidget {
  final String title;
  final String? keyWord;
  final TextStyle style;
  final TextStyle kstyle;
  final int maxLine;
  const KeywordColor({
    super.key,
    required this.title,
    this.keyWord,
    this.maxLine = 1,
    required this.style,
    required this.kstyle,
  });
  @override
  Widget build(BuildContext context) {
    if (keyWord != null && title.contains(keyWord!)) {
      final strs = title.split(keyWord!);
      List<TextSpan> texts = [];
      for (var v = 0; v < strs.length; v++) {
        texts.add(TextSpan(
          text: strs[v],
          style: style,
        ));
        if (v != strs.length - 1) {
          texts.add(TextSpan(
            text: keyWord,
            style: kstyle,
          ));
        }
      }
      return RichText(
          maxLines: maxLine,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: texts));
    } else {
      return Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: style,
      );
    }
  }
}
