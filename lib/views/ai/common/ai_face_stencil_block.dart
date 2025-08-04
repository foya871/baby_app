/*
 * @Author: wdz
 * @Date: 2025-05-19 18:50:52
 * @LastEditTime: 2025-06-03 20:21:36
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /51luanlun_app/lib/views/ai/common/ai_face_stencil_block.dart
 */
import 'package:flutter/material.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../model/ai/ai_models.dart';
import '../../../utils/enum.dart';
import 'ai_face_stencil_cell.dart';

///
/// 三个stencil, 超过3个后面的不会生效
///
class AiFaceStencilBlock extends StatelessWidget {
  static const showModelCountMax = 3;
  final List<AiStencilModel> models;
  final ValueCallback<int>? onTap;

  const AiFaceStencilBlock(this.models, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (models.isEmpty) {
      return const SizedBox.shrink();
    }
    final first =
        AiFaceStencilCell.vertical(models.first, onTap: () => onTap?.call(0));
    Widget? second = models.length >= 2
        ? AiFaceStencilCell.horizontal(models[1], onTap: () => onTap?.call(1))
        : null;
    Widget? third = models.length >= 3
        ? AiFaceStencilCell.horizontal(models[2], onTap: () => onTap?.call(2))
        : null;
    final columnChildren = <Widget>[];
    if (second != null) columnChildren.add(second);
    if (third != null) columnChildren.add(third);

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          first,
          if (columnChildren.isNotEmpty)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: columnChildren,
            )
        ],
      ),
    );
  }
}
