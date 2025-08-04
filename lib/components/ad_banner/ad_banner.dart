/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-16 19:18:58
 * @LastEditors: wdz
 * @LastEditTime: 2025-07-05 13:51:21
 * @FilePath: /baby_app/lib/components/ad_banner/ad_banner.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:carousel_slider/carousel_slider.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/utils/ad_jump.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:flutter/material.dart';

import '../../assets/styles.dart';
import '../ad/ad_enum.dart';
import '../ad/ad_utils.dart';

class AdBanner extends StatelessWidget {
  final AdApiType adress;
  final double? height;
  final EdgeInsets? margin;
  const AdBanner(
      {super.key, required this.adress, this.height = 160, this.margin});

  const AdBanner.index({super.key, this.height = 160, this.margin})
      : adress = AdApiType.NAV_ICON;

  @override
  Widget build(BuildContext context) {
    final ads = AdUtils().getAdLoadInOrder(adress);
    ValueNotifier<int> idx = ValueNotifier(0);
    if (ads.isEmpty) return const SizedBox.shrink();
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: Styles.borderRadius.m),
          margin: margin,
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
              aspectRatio: (332 / (height ?? 160)),
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
