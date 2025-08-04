import 'package:flutter/material.dart';

import '../../../generate/app_image_path.dart';

class AvPlayerLoading extends StatelessWidget {
  final double? width;
  final double? height;
  const AvPlayerLoading({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImagePath.player_loading,
        width: width ?? 90,
        height: height ?? 90,
      ),
    );
  }
}
