import 'package:collection/collection.dart';
import 'package:expandable_richtext/expandable_rich_text.dart';
import 'package:expandable_richtext/expandable_richtext_controller.dart';
import 'package:flutter/material.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:tuple/tuple.dart';

class EasyExpandableTextTag {
  final String text;
  final VoidCallback? onTap;

  EasyExpandableTextTag(this.text, {this.onTap});
}

class EasyExpandableTextTagLine {
  final List<EasyExpandableTextTag> tags;
  final TextStyle? style;

  EasyExpandableTextTagLine(this.tags, {this.style});
  EasyExpandableTextTagLine.tag(EasyExpandableTextTag tag, {this.style})
      : tags = [tag];
}

class EasyExpandableText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final String expandText;
  final String collapseText;
  final TextStyle? toggleTextStyle;
  final List<EasyExpandableTextTagLine>? tagLines;
  final bool tagLinesBeforeText;
  final bool tagLinesInNewLine;
  final bool collapseInNewLine;
  final int maxLines;
  final double? maxHeight; // 指定超出高度将会滑动

  const EasyExpandableText(
    this.text, {
    super.key,
    this.style,
    this.expandText = '展开',
    this.collapseText = '收起',
    this.toggleTextStyle,
    this.tagLines,
    this.tagLinesBeforeText = false,
    this.tagLinesInNewLine = false,
    this.collapseInNewLine = false,
    this.maxLines = 2,
    this.maxHeight,
  });
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<EasyExpandableText> {
  final _richTextController = ExpandableRichTextController();
  bool _expanded = false;
  final _customTagTaps = <String, VoidCallback?>{};

  Tuple2<String, Map<String, TextStyle>?> richTextDesc() {
    String text = widget.text;
    if (widget.tagLines == null) return Tuple2(text, null);
    final styles = <String, TextStyle>{};
    final tagText = widget.tagLines!.mapIndexed((i, v) {
      return v.tags.mapIndexed((j, e) {
        // ExpandableRichText 自定义标签同一个tag，不能识别id
        // 这里通过把tag唯一化来标识id
        final tag = 'tag_${i + 1}_${j + 1}';
        final tagStart = '<$tag>';
        final tagEnd = '</$tag>';
        if (v.style != null) {
          styles[tag] = v.style!;
        }
        _customTagTaps[tag] = e.onTap;
        return '$tagStart${e.text}$tagEnd';
      }).join(' '); // 至少要有一个空白
    }).join('\n');
    if (widget.tagLinesBeforeText) {
      return Tuple2(
          '$tagText${widget.tagLinesInNewLine ? '\n' : ' '}$text', styles);
    }

    return Tuple2(
        '$text${widget.tagLinesInNewLine ? '\n' : ' '}$tagText', styles);
  }

  void _onTapCollapse() => _richTextController.toggleText();

  @override
  Widget build(BuildContext context) {
    final desc = richTextDesc();
    Widget child = ExpandableRichText(
      desc.item1,
      controller: _richTextController,
      style: widget.style,
      expandText: widget.expandText,
      toggleTextStyle: widget.toggleTextStyle,
      collapseText: widget.collapseInNewLine ? null : widget.collapseText,
      customTagStyles: desc.item2,
      onCustomTagTap: (value) {
        if (_customTagTaps.isEmpty) return;
        // 这里 ExpandableRichText 有问题，
        // 返回的是内部tag的name，
        // 返回形如 tag>text</tag> 而且不是完整的 <tag>text</tag>
        // 这里做出处理
        if (!value.startsWith('<')) {
          value = '<$value';
        }
        final reg = RegExp(r'<(.+?)>(.*?)</(.+?)>');
        Match? match = reg.firstMatch(value);
        if (match?.groupCount != 3) return;
        final tag1 = match!.group(1);
        // final text = match.group(2);
        final tag2 = match.group(3);
        if (tag1 != tag2) return;
        _customTagTaps[tag1]?.call();
      },
      maxLines: widget.maxLines,
      onExpandedChanged: (v) {
        setState(() {
          _expanded = v;
        });
      },
    );
    if (widget.maxHeight != null) {
      child = ConstrainedBox(
        constraints: BoxConstraints(maxHeight: widget.maxHeight!),
        child: SingleChildScrollView(child: child),
      );
    }

    if (widget.collapseInNewLine) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          if (_expanded)
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.collapseText,
                style: widget.toggleTextStyle,
              ).onTap(_onTapCollapse),
            )
        ],
      );
    }

    return child;
  }
}
