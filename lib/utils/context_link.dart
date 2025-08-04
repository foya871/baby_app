import 'package:baby_app/utils/ad_jump.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:baby_app/utils/regex_util.dart';

List<InlineSpan> contextLink(String context, TextStyle style) {
  List<InlineSpan> contentList = [];
  RegExp exp = RegExp(
      r'(http|ftp|https)://([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?');
  Iterable<RegExpMatch> matches = exp.allMatches(context);

  int index = 0;

  for (var match in matches) {
    String c = context.substring(match.start, match.end);

    if (match.start == index) {
      index = match.end;
    }
    if (index < match.start) {
      String a = context.substring(index + 1, match.start);
      index = match.end;
      contentList.add(TextSpan(text: a));
    }
    if (RegexUtil.isURL(c)) {
      contentList.add(TextSpan(
          text: c,
          style: style,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              final url = context.substring(match.start, match.end);
              jumpExternalURL(url);
            }));
    } else {
      contentList.add(TextSpan(text: c));
    }
  }
  if (index < context.length) {
    String a = context.substring(index, context.length);
    contentList.add(TextSpan(text: a));
  }
  return contentList;
}
