import 'package:baby_app/components/app_bg_view.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../components/diolog/dialog.dart';
import '../../../components/text_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../utils/color.dart';
import 'android_dynamic_icon_utils.dart';

class ChangeIconPage extends StatefulWidget {
  const ChangeIconPage({super.key});

  @override
  State<StatefulWidget> createState() => ChangeIconPageState();
}

class ChangeIconPageState extends State<ChangeIconPage> {
  List<Tuple3<String, String, String>> desktops = [
    const Tuple3(AppImagePath.app_default_app_logo, '淑女巴士', "MainActivity"),
    const Tuple3(AppImagePath.mine_app_icon_desktop_icon_1, 'Excel', "IconOne"),
    const Tuple3(AppImagePath.mine_app_icon_desktop_icon_2, 'Word', "IconTwo"),
    const Tuple3(AppImagePath.mine_app_icon_desktop_icon_3, '知乎', "IconThree"),
    const Tuple3(AppImagePath.mine_app_icon_desktop_icon_4, 'PDF', "IconFour"),
    const Tuple3(AppImagePath.mine_app_icon_desktop_icon_5, 'WPS', "IconFive"),
    const Tuple3(AppImagePath.mine_app_icon_desktop_icon_6, '钉钉', "IconSix"),
    const Tuple3(AppImagePath.mine_app_icon_desktop_icon_7, '油菜', "IconSeven"),
    const Tuple3(AppImagePath.mine_app_icon_desktop_icon_8, '天气', "IconEight"),
    const Tuple3(AppImagePath.mine_app_icon_desktop_icon_9, '笔记', "IconNine"),
    const Tuple3(AppImagePath.mine_app_icon_desktop_icon_10, '系统安全', "IconTen"),
    const Tuple3(
        AppImagePath.mine_app_icon_desktop_icon_11, '系统清理', "IconEleven"),
    const Tuple3(
        AppImagePath.mine_app_icon_desktop_icon_12, '短信', "IconTwelve"),
  ];
  Tuple3<String, String, String>? selectItem;

  @override
  void initState() {
    super.initState();
    if (GetPlatform.isAndroid) {
      AndroidDynamicIconUtils()
          .initialize(desktops.map((e) => e.item3).toList());
    }
  }

  onClickDesktopIcon(Tuple3<String, String, String> item) async {
    showAlertDialog(Get.context!,
        title: "更换桌面图标",
        message: "是否更换桌面图标为 ${item.item2}?\n"
            "确定后，请等待1分钟左右，回到(不是退出)手机主页等待图标生效。\n"
            "部分机型首次会出现两个启动图标，再次切换其他图标即可。",
        messageTextAlign: TextAlign.start,
        messageMaxLines: 8,
        messageSpecifyText: [item.item3, '(不是退出)', '首次', '两个', '切换其他图标'],
        leftText: "取消",
        rightText: "确定", onRightButton: () async {
      dismiss();
      await AndroidDynamicIconUtils().changeIcon(item.item3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("桌面图标")),
      body: Column(
        children: [
          Expanded(
              child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 17.w,
            runSpacing: 10,
            children: desktops.map((item) {
              return SizedBox(
                width: 76.w,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset(item.item1, width: 76.w, height: 76.w),
                        if (selectItem == item)
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child: Image.asset(
                                AppImagePath.mine_icon_checked,
                                width: 26.w,
                                height: 26.w,
                              )),
                      ],
                    ),
                    5.verticalSpace,
                    TextView(
                      text: item.item2,
                      fontSize: 13.w,
                      color: COLOR.white,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ).onOpaqueTap(() {
                setState(() {
                  selectItem = item;
                });
              });
            }).toList(),
          )),
          AppBgView(
            text: "确定",
            height: 42.w,
            borderRadius: BorderRadius.circular(21.w),
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.w),
            textSize: 14.w,
            textColor: Colors.white,
            backgroundColor: COLOR.color_009FE8,
            onTap: () {
              if (selectItem != null) {
                onClickDesktopIcon(selectItem!);
              }
            },
          )
        ],
      ).marginSymmetric(horizontal: 10.w, vertical: 10.w),
    );
  }
}
