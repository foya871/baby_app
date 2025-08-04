/*
 * @Author: wdz
 * @Date: 2025-04-24 11:46:27
 * @LastEditTime: 2025-06-27 20:24:12
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/hive/hive_adapters.dart
 */
import 'package:hive_ce/hive.dart';

import '../utils/m3u8_download/m3u8_download_record.dart';
part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<M3u8DownloadRecord>(),
])
// Annotations must be on some element
// ignore: unused_element
void _() {}
