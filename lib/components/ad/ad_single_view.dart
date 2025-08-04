import 'package:baby_app/components/ad/ad_utils.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ad_info_model.dart';
import 'ad_enum.dart';

///单个广告展示
class AdSingleView extends StatefulWidget {
  final AdApiType type;
  final double? width;
  final double? height;
  final double? radius;

  const AdSingleView({
    super.key,
    required this.type,
    this.width,
    this.height,
    this.radius,
  });

  @override
  State<AdSingleView> createState() => _AdSingleViewState();
}

class _AdSingleViewState extends State<AdSingleView> {
  AdInfoModel? ad;

  @override
  void initState() {
    ad = AdUtils().getAdInfo(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ad == null) {
      return const SizedBox.shrink();
    }
    return _buildAdView();
  }

  _buildAdView() {
    return Stack(
      children: [
        ImageView(
          src: ad!.adImage,
          width: widget.width,
          height: widget.height,
          borderRadius: BorderRadius.circular(widget.radius ?? 8.w),
        ),
      ],
    );
  }
}
