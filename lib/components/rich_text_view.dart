import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextView extends StatefulWidget {
  const RichTextView({
    super.key,
    required this.text, // 输入的文本内容
    this.style, // 普通文本样式
    this.highlightStyle, // 高亮文本样式
    this.normalColor, // 普通文本颜色
    this.highlightColor, // 高亮文本颜色
    this.normalFontSize, // 普通文本字体大小
    this.highlightFontSize, // 高亮文本字体大小
    this.regex,
    this.specifyTexts, // 指定文本列表
    this.caseSensitive = false, // 是否区分大小写
    this.textAlign, // 是否区分大小写
    this.onTap, // 点击事件
    this.maxLines, // 最多显示的行数，超出则显示展开/收起
  });

  final String text; // 文本内容
  final TextStyle? style; // 普通文本样式
  final TextStyle? highlightStyle; // 高亮文本样式
  final Color? normalColor; // 普通文本颜色
  final Color? highlightColor; // 高亮文本颜色
  final double? normalFontSize; // 普通文本字体大小
  final double? highlightFontSize; // 高亮文本字体大小
  final Function(String)? onTap; // 点击事件回调
  final RegExp? regex; // 外部传入的正则表达式
  final bool caseSensitive; // 是否区分大小写
  final TextAlign? textAlign; // 是否区分大小写
  final List<String>? specifyTexts; // 指定文本列表（需要转化为可点击的文本）
  final int? maxLines; // 最多显示的行数，超出则显示展开/收起（null 时默认显示完整）

  @override
  State<RichTextView> createState() => _RichTextViewState();
}

class _RichTextViewState extends State<RichTextView> {
  bool _isExpanded = false; // 是否展开
  final RegExp _defaultExp = RegExp(
      r'((http|https|ftp)://([\w_-]+(?:\.[\w_-]+)+)([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?)|([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})');

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> textSpans = [];

    // 默认的正则表达式：匹配网址和邮箱
    RegExp exp = widget.regex ?? _defaultExp;

    // 如果指定了 specifyTexts，将它们转化为正则表达式
    List<RegExp>? specifyExpList;
    if (widget.specifyTexts != null && widget.specifyTexts!.isNotEmpty) {
      specifyExpList = widget.specifyTexts!
          .map(
            (text) => RegExp(
              RegExp.escape(text), // 转义文本为正则
              caseSensitive: widget.caseSensitive, // 是否区分大小写
            ),
          )
          .toList();
    }

    // 合并正则表达式
    final List<RegExp> regexList = [
      exp,
      if (specifyExpList != null && specifyExpList.isNotEmpty)
        ...specifyExpList, // 添加所有指定匹配项
    ];

    final combinedRegex = RegExp(
      regexList.map((e) => e.pattern).join('|'), // 合并多个正则
      caseSensitive: widget.caseSensitive, // 是否区分大小写
    );

    // 通过正则分割文本并生成 TextSpan
    widget.text.splitMapJoin(
      combinedRegex,
      onMatch: (match) {
        textSpans.add(TextSpan(
          text: match.group(0),
          style: widget.highlightStyle ??
              TextStyle(
                color: widget.highlightColor ?? Colors.blue,
                fontSize: widget.highlightFontSize,
                decoration: TextDecoration.underline,
              ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              widget.onTap?.call(match.group(0) ?? "");
            },
        ));
        return '';
      },
      onNonMatch: (nonMatch) {
        textSpans.add(TextSpan(
          text: nonMatch,
          style: widget.style ??
              TextStyle(
                color: widget.normalColor ?? Colors.black,
                fontSize: widget.normalFontSize,
              ),
        ));
        return nonMatch;
      },
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(children: textSpans, style: widget.style),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: textSpans,
                style: widget.style,
              ),
              maxLines: _isExpanded ? null : widget.maxLines,
              overflow: _isExpanded ? TextOverflow.clip : TextOverflow.ellipsis,
              textAlign: widget.textAlign ?? TextAlign.start,
            ),
            if (widget.maxLines != null &&
                textPainter.didExceedMaxLines) // 如果超出行数，显示展开/收起按钮
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _isExpanded ? "收起" : "展开",
                    style: widget.highlightStyle ??
                        const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
