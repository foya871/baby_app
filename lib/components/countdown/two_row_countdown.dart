import 'package:short_video_mudle/short_video_mudle.dart';

import '../../assets/styles.dart';
import '../../utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 比较简单就不用get了 -_-||
class TwoRowCountdown extends StatefulWidget {
  final Duration duration;
  final double? digitBgWidth;
  final double? digitBgHeight;
  final Color? digitBgColor;
  final BorderRadius? digitBgBorderRadius;
  final double? digitSepratorWidth;
  final TextStyle? digitStyle; // 数字
  final TextStyle? textStyle; // 时分秒

  const TwoRowCountdown({
    super.key,
    required this.duration,
    this.digitBgWidth,
    this.digitBgHeight,
    this.digitBgColor,
    this.digitBgBorderRadius,
    this.digitSepratorWidth,
    this.digitStyle,
    this.textStyle,
  });

  @override
  State<StatefulWidget> createState() => TwoRowCountdownState();
}

class TwoRowCountdownState extends State<TwoRowCountdown> {
  late final StreamDuration streamDuration;

  @override
  void initState() {
    streamDuration = StreamDuration(
      config: StreamDurationConfig(
        countDownConfig: CountDownConfig(duration: widget.duration),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    streamDuration.dispose();
    super.dispose();
  }

  Widget _buildDigit({
    required Duration duration,
    required TimeUnit timeUnit,
    required bool isCountUp,
    required digitStyle,
    required digitBgHeight,
  }) {
    final digitBgWidth = widget.digitBgWidth ?? 44.w;
    final digitBgColor = widget.digitBgColor ?? Styles.color.whiteTextBg;
    return Container(
      width: digitBgWidth,
      height: digitBgHeight,
      decoration: BoxDecoration(
        color: digitBgColor,
        borderRadius: widget.digitBgBorderRadius ?? Styles.borderRaidus.xs,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawDigitItem(
            duration: duration,
            timeUnit: timeUnit,
            digitType: DigitType.first,
            countUp: isCountUp,
            style: digitStyle,
            slideDirection: SlideDirection.down,
          ),
          RawDigitItem(
            duration: duration,
            timeUnit: timeUnit,
            digitType: DigitType.second,
            countUp: isCountUp,
            style: digitStyle,
            slideDirection: SlideDirection.down,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.textStyle ??
        TextStyle(color: Styles.color.whiteText, fontSize: Styles.fontSize.s);

    final digitStyle = widget.digitStyle ??
        TextStyle(color: Styles.color.whiteText, fontSize: Styles.fontSize.s);
    final digitBgHeight = widget.digitBgHeight ?? 44.w;
    final digitSepratorWidth = widget.digitSepratorWidth ?? 10.w;

    return RawSlideCountdown(
      streamDuration: streamDuration,
      builder: (context, duration, isCountUp) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDigit(
                  duration: duration,
                  timeUnit: TimeUnit.days,
                  isCountUp: isCountUp,
                  digitStyle: digitStyle,
                  digitBgHeight: digitBgHeight,
                ),
                Text('天', style: textStyle),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDigit(
                  duration: duration,
                  timeUnit: TimeUnit.hours,
                  isCountUp: isCountUp,
                  digitStyle: digitStyle,
                  digitBgHeight: digitBgHeight,
                ),
                Text('时', style: textStyle),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDigit(
                  duration: duration,
                  timeUnit: TimeUnit.minutes,
                  isCountUp: isCountUp,
                  digitStyle: digitStyle,
                  digitBgHeight: digitBgHeight,
                ),
                Text('分', style: textStyle),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDigit(
                  duration: duration,
                  timeUnit: TimeUnit.seconds,
                  isCountUp: isCountUp,
                  digitStyle: digitStyle,
                  digitBgHeight: digitBgHeight,
                ),
                Text('秒', style: textStyle),
              ],
            )
          ].joinSeperator(Container(
            width: digitSepratorWidth,
            height: digitBgHeight,
            alignment: Alignment.center,
            child: Text(':', style: digitStyle),
          )),
        );
      },
    );
  }
}
