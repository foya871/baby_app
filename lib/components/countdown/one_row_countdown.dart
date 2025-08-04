import '../../assets/styles.dart';
import '../../utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 比较简单就不用get了 -_-||
class OneRowCountdown extends StatefulWidget {
  final Duration duration;
  final double? digitBgWidth;
  final double? digitBgHeight;
  final Color? digitBgColor;
  final TextStyle? digitStyle; // 数字
  final TextStyle? textStyle; // 时分秒
  final MainAxisAlignment? alignment;
  const OneRowCountdown({
    super.key,
    required this.duration,
    this.digitBgWidth,
    this.digitBgHeight,
    this.digitBgColor,
    this.digitStyle,
    this.textStyle,
    this.alignment,
  });

  @override
  State<StatefulWidget> createState() => OneRowCountdownState();
}

class OneRowCountdownState extends State<OneRowCountdown> {
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

  Widget _buildDigit(Duration duration, TimeUnit timeUnit, bool isCountUp) {
    final digitBgWidth = widget.digitBgWidth ?? 24.w;
    final digitBgHeight = widget.digitBgHeight ?? 24.w;
    final digitBgColor = widget.digitBgColor ?? Styles.color.blackBg;
    final digitStyle = widget.digitStyle ??
        TextStyle(color: Styles.color.whiteText, fontSize: Styles.fontSize.s);
    return Container(
      width: digitBgWidth,
      height: digitBgHeight,
      decoration: BoxDecoration(
        color: digitBgColor,
        borderRadius: Styles.borderRaidus.xs,
      ),
      alignment: Alignment.center,
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
        TextStyle(color: Styles.color.whiteText, fontSize: Styles.fontSize.xs);

    return RawSlideCountdown(
      streamDuration: streamDuration,
      builder: (context, duration, isCountUp) {
        return Row(
          spacing: 4.w,
          mainAxisAlignment: widget.alignment ?? MainAxisAlignment.start,
          children: [
            _buildDigit(duration, TimeUnit.days, isCountUp),
            Text('天', style: textStyle),
            _buildDigit(duration, TimeUnit.hours, isCountUp),
            Text('时', style: textStyle),
            _buildDigit(duration, TimeUnit.minutes, isCountUp),
            Text('分', style: textStyle),
            _buildDigit(duration, TimeUnit.seconds, isCountUp),
            Text('秒', style: textStyle),
          ],
        );
      },
    );
  }
}
