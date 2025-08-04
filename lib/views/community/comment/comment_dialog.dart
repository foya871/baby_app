import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/popup/bottomsheet/abstract_bottom_sheet.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/views/community/comment/comment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentDialog extends AbstractBottomSheet {
  CommentDialog(
    this.dynamicId,
    this.parentId,
    this.nickName,
  ) : super(isScrolledControlled: true);
  final int dynamicId;
  final int parentId;
  final String nickName;

  @override
  Widget build() {
    return Container(
      decoration: BoxDecoration(
        color: COLOR.themColor,
        borderRadius: Styles.borderRadius.top(10.w),
      ),
      constraints: BoxConstraints(maxHeight: 0.6.sh),
      child: CommentPage(
        dynamicId: dynamicId,
        parentId: parentId,
        nickName: nickName,
      ),
    );
  }
}
