import 'package:baby_app/model/play/video_detail_model.dart';
import 'package:baby_app/model/video_base_model.dart';
import 'package:baby_app/utils/m3u8_download/m3u8_download_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/utils/color.dart';
import 'package:tuple/tuple.dart';

import 'package:short_video_mudle/short_video_mudle.dart';

final _baseSpace = 10.w;

extension WidgetMarginPadding on Widget {
  // 左右 base margin
  Widget get baseMarginHorizontal => marginHorizontal(_baseSpace);

  // 上下 base margin
  Widget get baseMarginVertical => marginVertical(_baseSpace);

  // 左上右margin
  Widget get baseMarginLtr => Container(
        margin: EdgeInsets.only(top: 5.w, left: _baseSpace, right: _baseSpace),
        child: this,
      );
  Widget get baseMarginLt => Container(
        margin: EdgeInsets.only(top: 5.w, left: _baseSpace),
        child: this,
      );
  Widget get baseMarginL => Container(
        margin: EdgeInsets.only(left: _baseSpace),
        child: this,
      );
  Widget get baseMarginR => Container(
        margin: EdgeInsets.only(right: _baseSpace),
        child: this,
      );
  Widget get baseMarginT => Container(
        margin: EdgeInsets.only(top: 5.w),
        child: this,
      );

  // 左右 base padding
  Widget get basePaddingHorizontal => Container(
        padding: EdgeInsets.symmetric(horizontal: _baseSpace),
        child: this,
      );

  // 上下 base padding
  Widget get basePaddingVertical => Container(
        padding: EdgeInsets.symmetric(vertical: _baseSpace),
        child: this,
      );

  // 左上下 base padding
  Widget get basePaddingLtr => Container(
        padding: EdgeInsets.only(
          top: _baseSpace,
          left: _baseSpace,
          right: _baseSpace,
        ),
        child: this,
      );
}

extension TabControllerExtension on TabController {
  // 监听动画，滑到一半就回调
  // 相同index会产生多次回调，外部处理
  // 两个都需要监听,动画只能监听滑动，不能监听点击
  Tuple2<VoidCallback, VoidCallback> makeFastListener(
      void Function(int) listener) {
    return Tuple2(
      () {
        listener(index);
      },
      () {
        final current = index;
        final index_ = current + offset.round();
        if (index_ != current) {
          listener(index_);
        }
      },
    );
  }

  void addFastListenerTuple(Tuple2<VoidCallback, VoidCallback> listener) {
    addListener(listener.item1);
    animation?.addListener(listener.item2);
  }

  void removeFasterListenerTuple(Tuple2<VoidCallback, VoidCallback> listener) {
    removeListener(listener.item1);
    animation?.removeListener(listener.item2);
  }

  void addFastListener(void Function(int) listener) {
    addFastListenerTuple(makeFastListener(listener));
  }

  /// 新增方法，忽略动画回调，滑动到一般或者中间时（offset不为0时），不再回调
  /// 场景，不需要监听动画过程的回调时使用（比如长距离点击tabBar，index0->4）
  void addStableListener(void Function(int) listener) {
    int? lastIndex;

    void handleIndex() {
      if (offset == 0.0 && index != lastIndex) {
        lastIndex = index;
        listener(index);
      }
    }

    addListener(handleIndex);
    animation?.addListener(handleIndex);
  }
}

extension GetExtension on GetInterface {
  untilNamed(String name) => until((r) => r.settings.name == name);

  showDialog({
    String? title,
    String? content,
    String backText = '取消',
    String nextText = '确定',
    VoidCallback? backTap,
    VoidCallback? nextTap,
  }) {
    return Get.dialog(Center(
      child: Container(
        width: 310.w,
        height: 166.w,
        padding:
            EdgeInsets.only(left: 32.w, right: 32.w, top: 20.w, bottom: 20.w),
        decoration: BoxDecoration(
          color: COLOR.hexColor("#2C2C2C"),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              title ?? "温馨提示",
              style: TextStyle(color: COLOR.white, fontSize: 16.w),
            ),
            if (content != null && content.isNotEmpty)
              Text(
                content,
                style:
                    TextStyle(color: COLOR.hexColor("#898A8E"), fontSize: 14.w),
              ).marginTop(20.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 112.w,
                  height: 36.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: COLOR.hexColor("#666666"),
                    borderRadius: BorderRadius.circular(18.w),
                  ),
                  child: Text(
                    backText,
                    strutStyle: StrutStyle.fromTextStyle(TextStyle(
                      color: COLOR.hexColor("#CFCFCF"),
                      fontSize: 16.w,
                      height: 22 / 16,
                    )),
                    style: TextStyle(
                      color: COLOR.hexColor("#CFCFCF"),
                      fontSize: 16.w,
                      height: 22 / 16,
                    ),
                  ),
                ).onTap(() {
                  Get.back();
                  if (backTap != null) {
                    backTap.call();
                  }
                }),
                Container(
                  width: 112.w,
                  height: 36.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: COLOR.hexColor("#B93FFF"),
                    borderRadius: BorderRadius.circular(18.w),
                  ),
                  child: Text(
                    nextText,
                    strutStyle: StrutStyle.fromTextStyle(TextStyle(
                      color: COLOR.hexColor("#FFFFFF"),
                      fontSize: 16.w,
                      height: 22 / 16,
                    )),
                    style: TextStyle(
                      color: COLOR.hexColor("#FFFFFF"),
                      fontSize: 16.w,
                      height: 22 / 16,
                    ),
                  ),
                ).onTap(() {
                  Get.back();
                  if (nextTap != null) {
                    nextTap.call();
                  }
                }),
              ],
            ).marginTop(20.w)
          ],
        ),
      ),
    ));
  }
}

extension M3u8DownloadManagerExt on M3u8DownloadManager {
  registerByDetail(VideoDetail detail) =>
      register(M3u8DownloadRecord.videoDetail(detail));

  registerByBase(VideoBaseModel base) =>
      register(M3u8DownloadRecord.videoBase(base));
}
