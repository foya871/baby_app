// import 'package:baby_app/components/ad/ad_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:baby_app/utils/ad_jump.dart';
// import 'package:baby_app/utils/color.dart';
// import 'package:short_video_mudle/short_video_mudle.dart';
//
// import '../ad/ad_enum.dart';
//
// class TextAd extends StatelessWidget {
//   const TextAd({
//     super.key,
//     required this.address,
//   });
//
//   const TextAd.index({super.key})
//       : address = AdApiType.COMMUNITY_WORD_INSERT;
//   final String address;
//
//   String initColor(int idx) {
//     if (idx % 5 == 0) {
//       return '#f5114c';
//     }
//     if (idx % 2 == 1) {
//       return '#088aff';
//     }
//     return '#00cb03';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final ads = AdUtils().getAdLoadInOrder(address);
//     if (ads.isEmpty) return const SizedBox.shrink();
//     double screenWidth = MediaQuery.of(context).size.width; // 获取屏幕宽度
//     double padding = 16.w * 2; // 假设有左右 16.w padding
//     double spacing = 6.w; // Wrap 的 spacing
//     // int itemCount = ads.length;
//     // int columnCount = itemCount > 3 ? 3 : itemCount; // 限制最多 3 列
//     int columnCount = 3;
//     double maxWidth =
//         (screenWidth - padding - (spacing * (columnCount - 1))) / columnCount;
//
//     return Wrap(
//       spacing: spacing,
//       runSpacing: 8.w,
//       alignment: WrapAlignment.start,
//       children: ads.asMap().entries.map((v) {
//         return Container(
//           width: maxWidth,
//           height: 35.w,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             border: Border.all(color: COLOR.hexColor(initColor(v.key))),
//           ),
//           child: Text(
//             '${v.value.adName}',
//             style: TextStyle(
//               fontSize: 16.w,
//               fontWeight: FontWeight.w600,
//               color: COLOR.hexColor(initColor(v.key)),
//             ),
//           ),
//         ).onOpaqueTap(() {
//           kAdjump(v.value, v.value.adId);
//         });
//       }).toList(),
//     );
//   }
// }
