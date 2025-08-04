import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../assets/styles.dart';
import '../../../utils/color.dart';
import '../../../utils/utils.dart';

class AiStep {
  final String name;
  AiStep(this.name);
}

class AiStepperController extends GetxController {
  final activeIndex = 0.obs;

  void setActive(int activeIndex) => this.activeIndex.value = activeIndex;
}

class AiStepper extends StatelessWidget {
  final double headTailWidth;
  final List<AiStep> steps;
  final AiStepperController controller;

  const AiStepper(this.steps,
      {super.key, required this.headTailWidth, required this.controller});

  Widget _buildLine(double width,
      {required bool active, BorderRadius? borderRadius}) {
    return Container(
      width: width,
      height: 5.w,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: active ? COLOR.themeSelectedColor : COLOR.color_EEEEEE,
      ),
    );
  }

  // <widget, 宽度>
  Tuple2<Widget, double> _buildCircleAndText(AiStep step, bool active) {
    final style = TextStyle(
      fontSize: 12.w,
      fontWeight: FontWeight.w500,
      color: active ? COLOR.themeSelectedColor : COLOR.color_333333,
    );
    final width =
        Utils.sizeOfText(step.name, maxWidth: 100.w, style: style).width;
    final widget = Column(
      children: [
        Container(
          width: 11.w,
          height: 11.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? COLOR.themeSelectedColor : COLOR.color_EEEEEE,
          ),
        ),
        SizedBox(height: 10.w),
        Text(step.name, style: style)
      ],
    );
    return Tuple2(widget, width);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final activeIndex = controller.activeIndex.value;
      return LayoutBuilder(builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final dis = (maxWidth - headTailWidth * 2) / (steps.length - 1);
        var widthOffset = .0;
        final lines = steps.mapIndexed((i, step) {
          double width;
          BorderRadius? borderRadius;
          if (i == 0) {
            width = headTailWidth;
            borderRadius = Styles.borderRadius.xsLeft;
          } else {
            width = dis;
          }
          widthOffset += width;
          final widget = _buildLine(
            width,
            active: i <= activeIndex,
            borderRadius: borderRadius,
          );
          return Tuple2(widget, widthOffset);
        }).toList();
        // 最后再增加一个尾部
        lines.add(
          Tuple2(
            _buildLine(
              headTailWidth,
              active: activeIndex == steps.length - 1,
              borderRadius: Styles.borderRadius.right(4.w),
            ),
            headTailWidth,
          ),
        );
        final stepWidget = steps
            .mapIndexed(
                (i, step) => _buildCircleAndText(step, i <= activeIndex))
            .toList();
        final s = stepWidget.mapIndexed((i, e) {
          return Positioned(left: lines[i].item2 - e.item2 / 2, child: e.item1);
        }).toList();
        return Stack(
          children: [
            Container(height: 40.w),
            Positioned(
                top: 3.w,
                child: Row(children: lines.map((e) => e.item1).toList())),
            ...s,
          ],
        );
      });
    });
  }
}
