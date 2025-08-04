import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../utils/color.dart';
import '../home_controller.dart';

class HomeNavigationMenu extends StatefulWidget {
  bool forbidden;

  HomeNavigationMenu(this.forbidden, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeNavigationMenuState();
  }
}

class HomeNavigationMenuState extends State<HomeNavigationMenu> {
  late HomePageController controller;

  @override
  void initState() {
    controller = Get.find<HomePageController>(
      tag: widget.forbidden
          ? HomePageController.forbiddenTag
          : HomePageController.homeTag,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 9.w, top: 30.h),
          child: const Text(
            '导航列表',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 1,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: controller.stations.value.length,
            itemBuilder: (context, index) {
              final station = controller.stations.value[index];
              final isSelected = index == controller.selectedIndex; // 判断当前项是否选中

              return InkWell(
                onTap: () {
                  setState(() {
                    controller.selectedIndex = index; // 更新选中状态
                  });
                  Navigator.of(context).pop();
                  controller.switchToTabForStation(station);
                },
                child: Container(
                  decoration: BoxDecoration(
                    // 根据选中状态设置不同的背景色
                    color: isSelected
                        ? COLOR.color_1F7CFF
                        : const Color(0xff474244).withValues(alpha: 0.4),
                    // 未选中时为原灰色
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Text(
                      station.classifyTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.white : null, // 选中时文字为白色（可选）
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
