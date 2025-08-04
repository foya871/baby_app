/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-19 15:58:39
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2025-01-08 18:38:45
 * @FilePath: /baby_app/lib/src/components/ad_banner/universal_banner.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/utils/ad_jump.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UniversalBanner extends StatelessWidget {
  final String adress;
  final double? height;
  final EdgeInsets? margin;
  const UniversalBanner(
      {super.key, required this.adress, this.height = 80, this.margin});

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    // final ads = initSequenceAdvertisementInfo(adress);
    // ValueNotifier<int> idx = ValueNotifier(0);
    // return ads.isEmpty
    //     ? const SizedBox.shrink()
    //     : Container(
    //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.w)),
    //         clipBehavior: Clip.hardEdge,
    //         margin: margin,
    //         child: Stack(
    //           children: [
    //             CarouselSlider.builder(
    //               itemCount: ads.length,
    //               itemBuilder: (context, index, pageViewIndex) {
    //                 return SizedBox(
    //                   width: double.infinity,
    //                   height: double.infinity,
    //                   child: GestureDetector(
    //                     onTap: () {
    //                       kAdjump(ads[index], ads[index].adId, 2);
    //                     },
    //                     child: ImageView(
    //                       src: ads[index].adImage ?? '',
    //                       fit: BoxFit.fill,
    //                     ),
    //                   ),
    //                 );
    //               },
    //               options: CarouselOptions(
    //                 autoPlay: true,
    //                 enlargeCenterPage: true,
    //                 viewportFraction: 1,
    //                 aspectRatio: (340 / (height ?? 80)),
    //                 onPageChanged: (index, reason) {
    //                   idx.value = index;
    //                 },
    //               ),
    //             ),
    //             Positioned(
    //                 right: 8.w,
    //                 bottom: 4.w,
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                       color: const Color.fromRGBO(0, 0, 0, 0.5),
    //                       borderRadius: BorderRadius.circular(3.w)),
    //                   padding: EdgeInsets.only(right: 2.w, left: 3.w),
    //                   child: Text(
    //                     '广告',
    //                     style: TextStyle(color: Colors.white, fontSize: 10.w),
    //                   ),
    //                 )),
    //             Positioned(
    //               bottom: 5.w,
    //               child: ValueListenableBuilder<int>(
    //                   valueListenable: idx,
    //                   builder: (context, value, child) {
    //                     return Container(
    //                         alignment: Alignment.center,
    //                         width: 340.w,
    //                         child: Row(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: List.generate(
    //                                 ads.length,
    //                                 (index) => Container(
    //                                       margin: EdgeInsets.only(right: 4.w),
    //                                       decoration: BoxDecoration(
    //                                           color: idx.value == index
    //                                               ? Colors.white
    //                                               : const Color.fromRGBO(
    //                                                   0, 0, 0, 0.3),
    //                                           borderRadius:
    //                                               BorderRadius.circular(3.5.w)),
    //                                       width: 7.w,
    //                                       height: 7.w,
    //                                     ))));
    //                   }),
    //             )
    //           ],
    //         ),
    //       );
  }
}
