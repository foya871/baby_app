// ignore_for_file: constant_identifier_names, non_constant_identifier_names

/*
 * @Author: wangdazhuang
 * @Date: 2024-07-16 14:09:53
 * @LastEditTime: 2025-06-28 11:22:42
 * @LastEditors: guotengda guotengda7204@gmail.com
 * @Description: 
 * @FilePath: /baby_app/lib/utils/color.dart
 */
import 'dart:math';

// import 'dart:ui';

import 'package:flutter/material.dart';

class COLOR {
  COLOR._();

  /// 4位 COLOR.hexColor("#999")
  /// 7位 COLOR.hexCOlor('#2e233e')
  static Color hexColor(String hexString) {
    final buffer = StringBuffer();
    //#fff
    bool isFour = hexString.length == 4;
    if (hexString.length == 6 || hexString.length == 7 || isFour) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    if (isFour) {
      buffer.write(hexString.substring(1));
    }
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  ///随机颜色
  static Color randomColor() {
    return Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),
        Random().nextInt(256), 1.0);
  }

  static const playerThemColor = white;
  static const themeSelectedColor = color_009fe8;
  static const themColor = color_090B16;
  static const primaryText = Colors.white;
  static const backButton = Colors.white;
  static const scaffoldBg = color_0e141e;
  static const loading = color_1F7CFF;

  static const white = Colors.white;
  static const black = Colors.black;
  static const white_80 = Color(0xCCFFFFFF);
  static const white_70 = Color(0xB3FFFFFF);
  static const white_60 = Color(0x99FFFFFF);
  static const white_50 = Color(0x80FFFFFF);
  static const white_40 = Color(0x66FFFFFF);
  static const white_30 = Color(0x4DFFFFFF);
  static const white_20 = Color(0x33FFFFFF);
  static const white_10 = Color(0x1AFFFFFF);
  static const transparent = Colors.transparent;
  static const color_63d2ff = Color(0xff63d2ff);
  static const color_090B16 = Color(0xff090b16);
  static const color_009fe8 = Color(0xff009fe8);
  static const color_FF6699 = Color(0xffFF6699);
  static const color_D8201D = Color(0xffD8201D);
  static const color_D8D8D8 = Color(0xffD8D8D8);
  static const color_333333 = Color(0xff333333);
  static const color_666666 = Color(0xff666666);
  static const color_999999 = Color(0xff999999);
  static const color_F5F5F5 = Color(0xffF5F5F5);
  static const color_DD001B = Color(0xffDD001B);
  static const color_F0F0F0 = Color(0xffF0F0F0);
  static const color_48382C = Color(0xff48382C);
  static const color_FAF5DF = Color(0xffFAF5DF);
  static const color_F52443 = Color(0xffF52443);
  static const color_D7D8D9 = Color(0xffD7D8D9);
  static const color_FFE5E5 = Color(0xffFFE5E5);
  static const color_FF4340 = Color(0xffFF4340);
  static const color_FF4a78 = Color(0xffFF4a78);
  static const color_A4A4B2 = Color(0xffA4A4B2);
  static const color_EFEFEF = Color(0xffEFEFEF);
  static const color_FFDAD9 = Color(0xffFFDAD9);
  static const color_FF0000 = Color(0xffFF0000);
  static const color_FFB5B5 = Color(0xffFFB5B5);
  static const color_D5D5D5 = Color(0xffD5D5D5);
  static const color_DC143C = Color(0xffDC143C);
  static const color_F40302 = Color(0xffF40302);
  static const color_4490F8 = Color(0xff4490F8);
  static const color_F3F4F5 = Color(0xffF3F4F5);
  static const color_1D1D1D = Color(0xff1D1D1D);
  static const color_1F7CFF = Color(0xff1f7cff);
  static const color_111 = Color(0xff111111);
  static const color_423765 = Color(0xff423765);

  static const color_898A8E = Color(0xff898A8E);
  static const color_B940FF = Color(0xffB940FF);
  static const color_B93FFF = Color(0xffB93FFF);
  static const color_9B9B9B = Color(0xff9B9B9B);
  static const color_B9B9B9 = Color(0xffB9B9B9);
  static const color_E5E5E5 = Color(0xffE5E5E5);
  static const color_F6C246 = Color(0xffF6C246);
  static const color_B5B5B5 = Color(0xffB5B5B5);
  static const color_FABD95 = Color(0xffFABD95);
  static const color_14151D = Color(0xff14151D);
  static const color_F0D94C = Color(0xffF0D94C);
  static const color_DDDDDD = Color(0xffDDDDDD);
  static const color_8D9198 = Color(0xff8D9198);
  static const color_DB3056 = Color(0xffDB3056);
  static const color_B65E04 = Color(0xffB65E04);
  static const color_BA226E = Color(0xffBA226E);
  static const color_FABC8A = Color(0xffFABC8A);
  static const color_EBEBEB = Color(0xffEBEBEB);
  static const color_8B8B98 = Color(0xff8B8B98);
  static const color_FFF1F2 = Color(0xffFFF1F2);
  static const color_F22F40 = Color(0xffF22F40);
  static const color_FEFEFE = Color(0xffFEFEFE);
  static const color_AFAFAF = Color(0xffAFAFAF);
  static const color_FE0303 = Color(0xffFE0303);
  static const color_AEAFB5 = Color(0xffAEAFB5);
  static const color_151515 = Color(0xff151515);
  static const color_808080 = Color(0xff808080);
  static const color_8F8F8F = Color(0xff8F8F8F);
  static const color_E9EFFC = Color(0xffE9EFFC);
  static const color_E7E7E7 = Color(0xffE7E7E7);
  static const color_2D2D2D = Color(0xff2D2D2D);
  static const color_1F1F1F = Color(0xff1F1F1F);
  static const color_181818 = Color(0xff181818);
  static const color_CFCFCF = Color(0xffCFCFCF);
  static const color_2C2C2C = Color(0xff2C2C2C);
  static const color_FF5C5C = Color(0xffFF5C5C);
  static const color_393939 = Color(0xff393939);
  static const color_292A31 = Color(0xff292A31);
  static const color_2B2B2B = Color(0xff2B2B2B);
  static const color_959595 = Color(0xff959595);
  static const color_1B1B1B = Color(0xff1B1B1B);
  static const color_222222 = Color(0xff222222);
  static const color_9C9AA9 = Color(0xff9C9AA9);
  static const color_1E1E1E = Color(0xff1E1E1E);
  static const color_7FFCCD = Color(0xff7FFCCD);
  static const color_F2BF62 = Color(0xffF2BF62);
  static const color_292929 = Color(0xff292929);
  static const color_CD73FB = Color(0xffCD73FB);
  static const color_60262736 = Color(0x60262736);
  static const color_FEE041 = Color(0xffFEE041);
  static const color_EEEEEE = Color(0xffEEEEEE);
  static const color_EEEEEE10 = Color(0x10EEEEEE);
  static const color_FEF100 = Color(0xffFEF100);
  static const color_DBDBDB = Color(0xffDBDBDB);
  static const color_232323 = Color(0xff232323);
  static const color_B0B0B0 = Color(0xffB0B0B0);
  static const color_E77F36 = Color(0xffE77F36);
  static const color_343434 = Color(0xff343434);
  static const color_F43670 = Color(0xffF43670);
  static const color_D2D2D2 = Color(0xffD2D2D2);
  static const color_E9E9E9 = Color(0xffE9E9E9);
  static const color_212121 = Color(0xff212121);
  static const color_212326 = Color(0xff212326);
  static const color_ffe763 = Color(0xffffe763);
  static const color_161616 = Color(0xff161616);
  static const color_160329 = Color(0xff160329);
  static const color_3B3B3B = Color(0xff3B3B3B);
  static const color_8d5527 = Color(0xff8d5527);
  static const color_A1A1A1 = Color(0xffA1A1A1);
  static const color_252525 = Color(0xff252525);
  static const color_F3C5A7 = Color(0xfff3c5a7);
  static const color_ffecf1 = Color(0xffffecf1);
  static const color_E6E6E6 = Color(0xffE6E6E6);
  static const color_676C73 = Color(0xff676C73);
  static const color_53575E = Color(0xff53575E);
  static const color_A6ABB1 = Color(0xffA6ABB1);
  static const color_ADB2B7 = Color(0xffADB2B7);
  static const color_030303 = Color(0xff030303);
  static const color_18191c = Color(0xff18191c);
  static const color_676c73 = Color(0xff676c73);
  static const color_8e8e93 = Color(0xff8e8e93);
  static const color_111316 = Color(0xff111316);
  static const color_352c6d = Color(0xff352c6d);
  static const color_f3f5f8 = Color(0xfff3f5f8);
  static const color_f5f7f8 = Color(0xfff3f5f8);
  static const color_9f9f9f = Color(0xff9f9f9f);
  static const color_cecece = Color(0xffcecece);
  static const color_FFCC02 = Color(0xffFFCC02);
  static const color_08b4fd = Color(0xff08b4fd);
  static const color_6bcc01 = Color(0xff6bcc01);
  static const color_10fc61d9 = Color(0x10fc61d9);
  static const color_fc61d9 = Color(0xfffc61d9);
  static const color_F39800 = Color(0xffF39800);
  static const color_fee900 = Color(0xfffee900);
  static const color_FCD34C = Color(0xffFCD34C);
  static const color_7B808E = Color(0xff7B808E);
  static const color_FFC59C = Color(0xffFFC59C);
  static const color_FFCF63 = Color(0xfffFCF63);
  static const color_FFAD60 = Color(0xffFFAD60);
  static const color_3A0A68 = Color(0xff3A0A68);
  static const color_FFEFFB = Color(0xffFFEFFB);
  static const color_A0A0A0 = Color(0xffA0A0A0);
  static const color_F2F2F2 = Color(0xFFF2F2F2);
  static const color_f50b4c = Color(0xFFf50b4c);
  static const color_ff004e = Color(0xFFff004e);
  static const color_f50d4b = Color(0xFFf50d4b);
  static const color_FACC00 = Color(0xFFFACC00);
  static const color_13141F = Color(0xFF13141F);
  static const color_F6F2EF = Color(0xFFF6F2EF);
  static const color_4C4E55 = Color(0xFF4C4E55);
  static const color_50111425 = Color(0x50111425);
  static const color_9c4c00 = Color(0xFF9c4c00);
  static const color_009FE8 = Color(0xFF009FE8);
  static const color_0e141e = Color(0xFF0e141e);
  static const color_f5e5bf = Color(0xFFf5e5bf);
  static const color_161e2c = Color(0xFF161e2c);
  static const color_6c2a2a = Color(0xFF6c2a2a);
  static const color_0B1018 = Color(0xFF0B1018);
  static const color_b48857 = Color(0xFFb48857);
  static const color_161a34 = Color(0xFF161a34);
  static const color_e3c890 = Color(0xFFe3c890);
  static const color_232843 = Color(0xFF232843);
  static const color_763708 = Color(0xFF763708);
  static const color_ffd5a8 = Color(0xFFffd5a8);
  static const color_6b2020 = Color(0xFF6b2020);
  static const color_8d4a41 = Color(0xFF8d4a41);  
  // 不透明度50%
  static const Color translucent_46 = Color(0x75000000);
  static const Color translucent_50 = Color(0x80000000);

  static const Color black_30 = Color(0x4D000000);

  static const Color color_323232 = Color(0xff323232);
}
