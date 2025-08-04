/*
 * @Author: wangdazhuang
 * @Date: 2024-08-19 09:11:37
 * @LastEditTime: 2024-10-16 17:19:42
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/src/utils/consts.dart
 */

import 'package:flutter/material.dart';

class Consts {
  Consts._();
  static const generalBoxName = '_general_';
  static const userBoxName = 'userInfo';
  static const m3u8DownloaderBoxName = '_m3u8_downloader_';
  static const hiveTypeIdDownloadRecord = 13;

  ///
  static const imMessageBoxName = '_im_messages_';
  static const imConversationBoxName = '_im_conversation_';

  static final generalBoxKey = [
    0x01,
    0x02,
    0x03,
    0x04,
    0x05,
    0x06,
    0x07,
    0x08,
    0x09,
    0x10,
    0x11,
    0x12,
    0x13,
    0x14,
    0x15,
    0x16,
    0x17,
    0x18,
    0x19,
    0x20,
    0x21,
    0x22,
    0x23,
    0x24,
    0x25,
    0x26,
    0x27,
    0x28,
    0x29,
    0x30,
    0x31,
    0x32
  ];

  static const pageFirst = 1;
  static const pageSizeMax = 100;
  static const cny = '¥';

  // ai
  static const aiClothCostGold = 10.0;
  static const aiClothCostCount = 1;
  static const aiFaceImageCostCount = 1;
  static const aiFaceCustomCostGold = 10.0; // 自定义换脸
  static const aiFaceCustomCostCount = 1;
  // static const aiFaceVideoCostCount = 1;

  static const defaultBackButtonIcon = Icons.arrow_back_ios_new;
}
