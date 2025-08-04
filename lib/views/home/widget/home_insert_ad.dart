/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-16 19:18:58
 * @LastEditors: wdz
 * @LastEditTime: 2025-07-05 12:00:05
 * @FilePath: /baby_app/lib/views/home/widget/home_insert_ad.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:baby_app/components/ad/ad_enum.dart';
import 'package:baby_app/components/ad/ad_utils.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/utils/ad_jump.dart';
import 'package:flutter/material.dart';

class HomeInsertAd extends StatelessWidget {
  final AdApiType adress;
  final double height;
  final double? asp;
  const HomeInsertAd({
    super.key,
    required this.adress,
    required this.height,
    this.asp,
  });

  @override
  Widget build(BuildContext context) {
    final ads = AdUtils().getAdLoadInOrder(adress);
    ValueNotifier<int> idx = ValueNotifier(0);
    if (ads.isEmpty) return const SizedBox.shrink();
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w)),
          clipBehavior: Clip.hardEdge,
          child: CarouselSlider.builder(
            itemCount: ads.length,
            itemBuilder: (context, index, pageViewIndex) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    kAdjump(ads[index]);
                  },
                  child: ImageView(
                    src: ads[index].adImage ?? '',
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: asp ?? 1,
              onPageChanged: (index, reason) {
                idx.value = index;
              },
            ),
          ),
        ),
      ],
    );
  }
}
