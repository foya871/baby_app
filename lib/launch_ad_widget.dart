/*
 * @Author: wdz
 * @Date: 2025-07-09 15:55:54
 * @LastEditTime: 2025-07-10 20:26:46
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/launch_ad_widget.dart
 */
import 'dart:async';

import 'package:baby_app/components/ad/ad_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/easy_button.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:baby_app/utils/color.dart';

import 'assets/styles.dart';
import 'components/ad/ad_enum.dart';
import 'components/ad/ad_info_model.dart';
import 'components/easy_toast.dart';
import 'components/image_view.dart';
import 'env/environment_service.dart';
import 'routes/routes.dart';
import 'services/storage_service.dart';
import 'utils/ad_jump.dart';

class LuanchAdWidget extends StatefulWidget {
  const LuanchAdWidget({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<LuanchAdWidget> {
  late Timer _timer;
  int _currentTimer = 5;
  List<AdInfoModel> ads = [];

  @override
  void initState() {
    initService();
    super.initState();
  }

  void initService() async {
    final items = AdUtils().getAdLoadInOrder(AdApiType.START);
    if (items.isNotEmpty) {
      List<AdInfoModel> arr = [];
      var num = items.length >= 3 ? 3 : items.length;
      for (var i = 0; i < num; i++) {
        ///
        final ad = AdUtils().getAdInfo(AdApiType.START);
        if (ad != null) {
          arr.add(ad);
        }
      }
      ads.assignAll(arr);
      setState(() {});
    }

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_currentTimer == 0) return;
        setState(() {
          if (_currentTimer > 0) {
            _currentTimer -= 1;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildAds() {
    if (ads.isEmpty) {
      return Positioned.fill(
        child: Image.asset(
          AppImagePath.app_default_splash,
          width: Get.width,
          height: Get.height,
          fit: BoxFit.fill,
        ),
      );
    }
    var itemH = Get.height;
    final adLength = ads.length;
    if (adLength > 1) itemH = (Get.height - 5.w * (adLength - 1)) / adLength;
    final placeHolder = adLength == 1
        ? AppImagePath.app_default_splash
        : AppImagePath.app_default_placeholder;
    return Positioned.fill(
        child: Column(
      children: ads
          .mapIndexed(
            (index, e) => ImageView(
              width: Get.width,
              height: itemH,
              src: ads[index].adImage,
              fit: BoxFit.fill,
              defaultPlace: placeHolder,
            )
                .onTap(() => kAdjump(ads[index]))
                .marginBottom(index == adLength - 1 ? 0 : 5.w),
          )
          .toList(),
    ));
  }

  void _tapJumpAction() async {
    if (_currentTimer == 0 || kDebugMode) {
      final hasToken = Get.find<StorageService>().token?.isNotEmpty;
      if (GetPlatform.isWeb) {
        if (hasToken == false) {
          EasyToast.show("初始化失败,请退出重试!");
          return;
        }
      } else {
        if (hasToken == false || Environment.androidiOSAPI.isEmpty) {
          EasyToast.show("初始化失败,请退出重试!");
          return;
        }
      }
      Get.offHome();
      WakelockPlus.enable();
    }
  }

  Widget _buildBtn() {
    final fail = !GetPlatform.isWeb && Environment.androidiOSAPI.isEmpty;
    if (fail) return const SizedBox.shrink();
    final txt = _currentTimer > 0 ? '$_currentTimer' : '跳过';
    return Positioned(
      right: 15.w,
      top: kIsWeb ? 25.w : 60.w,
      child: EasyButton(
        txt,
        textStyle: kTextStyle(
          Colors.white,
          fontsize: 16.w,
          weight: FontWeight.bold,
        ),
        width: 90.w,
        height: 35.w,
        borderRadius: BorderRadius.circular(17.5.w),
        backgroundColor: COLOR.transparent.withValues(alpha: 0.4),
        onTap: _tapJumpAction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SizedBox.expand(
          child: Stack(
            children: [
              _buildAds(),
              _buildBtn(),
            ],
          ),
        ),
      );
}
