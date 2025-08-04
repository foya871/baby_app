import 'package:baby_app/components/diolog/loading/loading_view.dart';
import 'package:baby_app/components/easy_toast.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/env/environment_service.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/community/community_info_model.dart';
import 'package:baby_app/model/community/community_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/services/user_service.dart';
import 'package:baby_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

class CommunityInfoCell extends StatefulWidget {
  const CommunityInfoCell({
    super.key,
    required this.model,
    required this.pictures,
    required this.community,
  });

  final CommunityInfoModel model;
  final CommunityModel community;
  final List<String> pictures;

  @override
  State createState() => CommunityInfoCellState();
}

class CommunityInfoCellState extends State<CommunityInfoCell> {
  Future vipDialog() {
    return showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: COLOR.transparent,
          child: Container(
            width: 286.w,
            height: 195.w,
            decoration: BoxDecoration(
              color: COLOR.color_13141F,
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  '提示',
                  style: TextStyle(
                    color: COLOR.white,
                    fontSize: 16.w,
                    fontWeight: FontWeight.w500,
                  ),
                ).marginOnly(top: 35.w),
                Text(
                  '开通会员观看完整版',
                  style: TextStyle(
                    color: COLOR.white_70,
                    fontSize: 15.w,
                    fontWeight: FontWeight.w500,
                  ),
                ).marginOnly(top: 10.w),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: 120.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: COLOR.white_10,
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Center(
                          child: Text(
                            '取消',
                            style: TextStyle(
                              color: COLOR.white_80,
                              fontSize: 14.w,
                            ),
                          ),
                        ),
                      ).onOpaqueTap(() {
                        Navigator.pop(context);
                      }),
                    ),
                    Expanded(
                      child: Container(
                        width: 120.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: COLOR.color_1F7CFF,
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Center(
                          child: Text(
                            '立即开通',
                            style: TextStyle(
                              color: COLOR.white,
                              fontSize: 14.w,
                            ),
                          ).onOpaqueTap(() async {
                            Navigator.pop(context);
                            await Get.toVip();
                            final user = Get.find<UserService>().user;
                            if (user.vipType! > 0) {
                              setState(() {
                                widget.community.canWatch = true;
                                widget.community.dynamicMark = 0;
                              });
                            }
                          }),
                        ),
                      ).marginOnly(left: 12.w),
                    ),
                  ],
                ).marginOnly(left: 16.w, top: 30.w, right: 16.w),
              ],
            ),
          ),
        );
      },
    );
  }

  Future payDialog() {
    return showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: COLOR.transparent,
          child: Container(
            width: 286.w,
            height: 195.w,
            decoration: BoxDecoration(
              color: COLOR.color_13141F,
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  '提示',
                  style: TextStyle(
                    color: COLOR.white,
                    fontSize: 16.w,
                    fontWeight: FontWeight.w500,
                  ),
                ).marginOnly(top: 35.w),
                Text(
                  '金币购买观看完整版',
                  style: TextStyle(
                    color: COLOR.white_70,
                    fontSize: 15.w,
                    fontWeight: FontWeight.w500,
                  ),
                ).marginOnly(top: 10.w),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: 120.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: COLOR.white_10,
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Center(
                          child: Text(
                            '取消',
                            style: TextStyle(
                              color: COLOR.white_80,
                              fontSize: 14.w,
                            ),
                          ),
                        ),
                      ).onOpaqueTap(() {
                        Navigator.pop(context);
                      }),
                    ),
                    Expanded(
                      child: Container(
                        width: 120.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: COLOR.color_1F7CFF,
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Center(
                          child: Text(
                            '立即购买',
                            style: TextStyle(
                              color: COLOR.white,
                              fontSize: 14.w,
                            ),
                          ).onOpaqueTap(() async {
                            Navigator.pop(context);
                            buyDynamic(widget.community.dynamicId ?? 0);
                          }),
                        ),
                      ).marginOnly(left: 12.w),
                    ),
                  ],
                ).marginOnly(left: 16.w, top: 30.w, right: 16.w),
              ],
            ),
          ),
        );
      },
    );
  }

  Future chargeDialog() {
    return showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: COLOR.transparent,
          child: Container(
            width: 286.w,
            height: 195.w,
            decoration: BoxDecoration(
              color: COLOR.color_13141F,
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  '购买失败',
                  style: TextStyle(
                    color: COLOR.white,
                    fontSize: 16.w,
                    fontWeight: FontWeight.w500,
                  ),
                ).marginOnly(top: 35.w),
                Text(
                  '金币不足暂时无法购买',
                  style: TextStyle(
                    color: COLOR.white_70,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                  ),
                ).marginOnly(top: 10.w),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: 120.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: COLOR.white_10,
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Center(
                          child: Text(
                            '取消',
                            style: TextStyle(
                              color: COLOR.white_80,
                              fontSize: 14.w,
                            ),
                          ),
                        ),
                      ).onOpaqueTap(() {
                        Navigator.pop(context);
                      }),
                    ),
                    Expanded(
                      child: Container(
                        width: 120.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: COLOR.color_1F7CFF,
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Center(
                          child: Text(
                            '立即充值',
                            style: TextStyle(
                              color: COLOR.white,
                              fontSize: 14.w,
                            ),
                          ).onOpaqueTap(() async {
                            Navigator.pop(context);
                            Get.toWallet();
                          }),
                        ),
                      ).marginOnly(left: 12.w),
                    ),
                  ],
                ).marginOnly(left: 16, top: 30.w, right: 16.w),
              ],
            ),
          ),
        );
      },
    );
  }

  Future buyDynamic(int dynamicId) async {
    final result = await LoadingView.singleton.wrap(
      context: Get.context!,
      asyncFunction: () async {
        return await Api.buyCommunity(dynamicId: dynamicId);
      },
    );

    if (result) {
      setState(() {
        widget.community.canWatch = true;
        widget.community.dynamicMark = 0;
      });
      EasyToast.show('购买成功');
    }
  }

  Future action() async {
    if (widget.community.dynamicMark == 1) {
      if (!Get.find<UserService>().isVIP) {
        vipDialog();
        return;
      }
      if (widget.model.video == null) return;
      final video = widget.model.video;
      final cdnRes = video?.cdnRes;
      final playPath = Environment.buildAuthPlayUrlString(
          videoUrl: video?.videoUrl, authKey: video?.authKey, id: cdnRes?.id);
      Get.toVideoBoxByURL(url: playPath);
    } else if (widget.community.dynamicMark == 2) {
      final userAssetsGold = Get.find<UserService>().assets.gold ?? 0;
      double price = widget.community.price ?? 0;
      if (userAssetsGold < price) {
        chargeDialog();
        return;
      }
      payDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.model.type == 0
          ? Text(
              widget.model.text ?? '',
              style: TextStyle(
                color: COLOR.white,
                fontSize: 13.w,
                height: 1.5,
              ),
            ).marginOnly(bottom: 5.w)
          : widget.model.type == 1
              ? ImageView(
                  src: widget.model.image ?? '',
                  fit: BoxFit.contain,
                  clipWidth: 480,
                ).marginOnly(bottom: 5.w).onOpaqueTap(() {
                  Get.toImageViewer(widget.pictures);
                })
              : Stack(
                  children: <Widget>[
                    ImageView(
                      src: widget.model.video?.coverImg ?? '',
                      width: double.infinity,
                      height: 190.w,
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: Center(
                        child: Image.asset(
                          AppImagePath.community_video_play,
                          width: 45.w,
                          height: 45.w,
                        ),
                      ),
                    ),
                    if (widget.community.canWatch == false)
                      Positioned(
                        top: 8.w,
                        right: 8.w,
                        child: Image.asset(
                          widget.community.dynamicMark == 1
                              ? AppImagePath.community_vip_icon
                              : AppImagePath.community_gold_icon,
                          width: 36.w,
                          height: 16.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                  ],
                ).marginOnly(bottom: 5.w).onOpaqueTap(() {
                  if (widget.community.canWatch == true) {
                    if (widget.model.video == null) return;
                    final video = widget.model.video;
                    final cdnRes = video?.cdnRes;

                    final playPath = Environment.buildAuthPlayUrlString(
                        videoUrl: video?.videoUrl,
                        authKey: video?.authKey,
                        id: cdnRes?.id);
                    Get.toVideoBoxByURL(url: playPath);
                  } else {
                    action();
                  }
                }),
    );
  }
}
