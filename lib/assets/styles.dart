/*
 * @Author: wangdazhuang
 * @Date: 2024-08-21 14:23:37
 * @LastEditTime: 2025-03-14 19:20:26
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/assets/styles.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/utils/color.dart';

import '../generate/app_image_path.dart';

const _am = 0xff000000; // alpha max

class _Color {
  final transparent = Colors.transparent;
  final bgColor = const Color(_am | 0x000000);
  final primary = COLOR.color_B93FFF;
  final primaryLight = const Color(_am | 0xf52443);
  final primaryPinkOpacityBg = const Color(_am | 0xeb29c6).withOpacity(0.153);
  final blackBg = COLOR.color_090B16;
  final dustGrayBg = const Color(_am | 0x999999);
  final purple = const Color(_am | 0x9500f5);
  final orange = const Color(_am | 0xf78622);
  final episodeTagBg = const Color(_am | 0xffdad9);
  final episodeTagText = const Color(_am | 0xff4340);
  final galleryBg = const Color(_am | 0xeeeeee);
  final dividerColor = const Color(_am | 0xf0f0f0);

  final primaryText = const Color(_am | 0x333333);
  final greyBlackText = const Color(_am | 0x666666);
  final dustGrayText = const Color(_am | 0x999999);
  final whiteText = Colors.white;
  final greyWhiteText = const Color(_am | 0x9b9b9b);
  final darkYellowText = const Color(_am | 0xffbe00);
  final toastText = Colors.black;
  final inputBg = const Color(_am | 0xf5f5f5);

  final appBarIconColor = Colors.white; // appbaricon颜色
  final whiteTextOpacityBg = Colors.black.withOpacity(0.4); // 白色字体的半透明背景(图片上)
  final whiteTextBg = const Color(_am | 0x494657); // 白色字体的一般背景
  final whiteDivider = Colors.white.withOpacity(0.2); // 一些divider

  final dialogBg = Colors.white;
  final bottomSheetBg = Colors.white;
  final cancelBg = const Color(_am | 0xe5e5e5);

  final lightBlackMask = const Color(0x80000000); // 图片作为淡背景时的蒙版

  final lightBrown = const Color(_am | 0x2b1f2f); //  AI会员名称背景色
  final palePurple = const Color(_am | 0xcab6d3); // AI已优惠背景色

  final colorCD73FB = const Color(_am | 0xCD73FB);
  final color898A8E = const Color(_am | 0x898A8E);
}

class _Gradient {
  Gradient get forbiddenMask => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0x00121212).withOpacity(0.93),
          const Color(0x00550000).withOpacity(0.93),
        ],
      );

  Gradient get orangeToPink => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(_am | 0xf78248),
          Color(_am | 0xf52c0f),
          Color(_am | 0xf5019a)
        ],
      );

  Gradient get pinkToBule => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(_am | 0xff01ed), Color(_am | 0x3137ff)],
      );

  Gradient get purpleDeepToLight => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(_am | 0xA62DE4), Color(_am | 0xD47FFF)],
      );

  ////渐变色 用图片代替，上面那种方式有些耗费性能
  DecorationImage get gradientImage => const DecorationImage(
        image: AssetImage(AppImagePath.app_default_gradient),
        fit: BoxFit.fill,
        repeat: ImageRepeat.noRepeat,
      );
}

class _FontSize {
  final xxxl = 26.w;
  final xxl = 24.w;
  final xl = 22.w;
  final l = 20.w;
  final lm = 18.w;
  final m = 16.w;
  final sm = 14.w;
  final s = 12.w;
  final xs = 10.w;
  final xxs = 8.w;

  //
  final pageTitle = 18.w;
  final appBarTitle = 18.w;
}

class _BorderRaidus {
  @Deprecated('use all instead')
  BorderRadius get xxl => all(20.w);
  @Deprecated('use all instead')
  BorderRadius get xl => all(16.w);
  @Deprecated('use all instead')
  BorderRadius get l => all(12.w);
  @Deprecated('use all instead')
  BorderRadius get m => all(8.w);
  @Deprecated('use all instead')
  BorderRadius get s => all(6.w);
  @Deprecated('use all instead')
  BorderRadius get xs => all(4.w);

  BorderRadius all(double r) => BorderRadius.circular(r);

  BorderRadius top(double r) => BorderRadius.vertical(top: Radius.circular(r));

  BorderRadius bottom(double r) =>
      BorderRadius.vertical(bottom: Radius.circular(r));

  BorderRadius left(double r) =>
      BorderRadius.horizontal(left: Radius.circular(r));

  BorderRadius right(double r) =>
      BorderRadius.horizontal(right: Radius.circular(r));

  // 对角(上) 左下-右上
  BorderRadius diagonalUp(double r) => BorderRadius.only(
      bottomLeft: Radius.circular(r), topRight: Radius.circular(r));

  // 对角(下) 左上-右下
  BorderRadius diagonalDown(double r) => BorderRadius.only(
      topLeft: Radius.circular(r), bottomRight: Radius.circular(r));

  @Deprecated('use all instead')
  BorderRadius get toast => BorderRadius.circular(12.w);
  @Deprecated('use top instead')
  BorderRadius get mTop => BorderRadius.vertical(top: Radius.circular(8.w));
  @Deprecated('use left instead')
  BorderRadius get xsLeft =>
      BorderRadius.horizontal(left: Radius.circular(4.w));

  // 对角 左下-右上
  @Deprecated('')
  BorderRadius get mDiagonalRight => BorderRadius.only(
      topRight: Radius.circular(8.w), bottomLeft: Radius.circular(8.w));

  // 右下
  @Deprecated('')
  BorderRadius get mRightBottom =>
      BorderRadius.only(bottomRight: Radius.circular(8.w));

  // 左下
  @Deprecated('')
  BorderRadius get mLeftBottom =>
      BorderRadius.only(bottomLeft: Radius.circular(8.w));

  // 左上
  @Deprecated('')
  BorderRadius get mLeftTop => BorderRadius.only(topLeft: Radius.circular(8.w));

// 右下左上
  @Deprecated('all')
  BorderRadius get mRightBottomTopLeft => BorderRadius.only(
      bottomRight: Radius.circular(8.w), topLeft: Radius.circular(8.w));

//左下右下
  @Deprecated('all')
  BorderRadius get mBottomLR => BorderRadius.only(
      bottomLeft: Radius.circular(8.w), bottomRight: Radius.circular(8.w));
}

class _Radius {
  Radius get l => Radius.circular(12.r);

  Radius get m => Radius.circular(8.r);

  Radius get s => Radius.circular(6.r);

  Radius get xs => Radius.circular(4.r);
}

class _Shadow {
  BoxShadow whiteShadow = BoxShadow(
    color: Colors.white,
    offset: Offset(0, 0.02.w),
    blurRadius: 16.0.r,
    spreadRadius: 0.02.r,
  );
}

abstract class Styles {
  Styles._();

  @Deprecated('COLOR')
  static final color = _Color();
  @Deprecated('')
  static final fontSize = _FontSize();
  static final gradient = _Gradient();
  static final borderRaidus = _BorderRaidus();
  static final borderRadius = _BorderRaidus();
  static final radius = _Radius();
  static final shadow = _Shadow();
}

kTextStyle(
  Color color, {
  double? fontsize,
  FontWeight? weight,
}) {
  return TextStyle(color: color, fontSize: fontsize, fontWeight: weight);
}
