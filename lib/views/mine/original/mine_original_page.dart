import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../http/api/api.dart';
import '../../../model/mine/official_community_model.dart';

///原创入驻
class MineOriginalPage extends StatefulWidget {
  const MineOriginalPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MineOriginalPageState();
  }
}

class _MineOriginalPageState extends State<MineOriginalPage> {
  OfficialCommunityModel? model;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //设置状态栏透明
      statusBarColor: Colors.transparent,
    ));

    Api.getOfficialGroup().then((response) {
      model = response
          .where((e) {
            return e.link?.isNotEmpty == true && e.link!.contains("tg");
          })
          .toList()
          .first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            AppImagePath.mine_original_entry_bg,
            width: 1.sw,
            height: Get.height,
            fit: BoxFit.fill,
          )),
          Positioned(
              bottom: 170.w,
              right: 37.w,
              child: GestureDetector(
                onTap: () {
                  // TODO 郭大侠
                  launchUrl(Uri.parse(model?.link ?? ""));
                  showToast("点击官方管理员");
                },
                child: Container(
                  width: 86.w,
                  height: 86.w,
                  color: Colors.transparent,
                ),
              )),
        ],
      ),
    );
  }
}
