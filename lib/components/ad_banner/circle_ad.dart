import 'package:flutter/widgets.dart';

import 'package:baby_app/components/ad/ad_info_model.dart';
import '../../utils/ad_jump.dart';
import '../circle_image.dart';

class CircleAd extends StatelessWidget {
  final AdInfoModel ad;
  final double size;
  final BoxFit? fit;

  const CircleAd(
    this.ad, {
    required this.size,
    this.fit,
    super.key,
  });

  @override
  Widget build(BuildContext context) => CircleImage.network(
        ad.adImage ?? '',
        size: size,
        fit: fit,
        onTap: () => kAdjump(ad),
      );
}
