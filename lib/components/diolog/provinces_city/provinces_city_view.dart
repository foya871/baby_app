import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../utils/color.dart';

class ProvincesCityView extends StatefulWidget {
  final String locationCode;
  final double? width;
  final double? height;
  final Function() cancel;
  final Function(Tuple4 result) confirm;
  final bool isAlert;

  const ProvincesCityView({
    super.key,
    this.width,
    this.height,
    required this.locationCode,
    required this.cancel,
    required this.confirm,
    this.isAlert = true,
  });

  @override
  State<StatefulWidget> createState() => _ProvincesCityViewState();
}

class _ProvincesCityViewState extends State<ProvincesCityView> {
  RxList<Tuple3> provincesDatas = <Tuple3>[].obs; // 省数据
  RxList<Tuple3> cityDatas = <Tuple3>[].obs; // 城市数据
  RxList<Tuple3> currentCityDatas = <Tuple3>[].obs; // 当前省选中的城市数据
  Rx<Tuple2<String, String>> selectedProvince =
      const Tuple2("", "").obs; // 当前选中的省份
  Rx<Tuple2<String, String>> selectedCity = const Tuple2("", "").obs; // 当前选中的城市

  Tuple4<String, String, String, String> result = const Tuple4("", "", "", "");

  @override
  void initState() {
    super.initState();
    initData();
  }

  // 初始化数据
  initData() async {
    String provinceCityJson = await DefaultAssetBundle.of(Get.context!)
        .loadString("assets/json/province_city_json.json");
    List provincesCityList = json.decode(provinceCityJson);

    // 处理省和城市数据
    for (var provinces in provincesCityList) {
      Tuple3 provinceTuple = Tuple3("", provinces["code"], provinces["name"]);
      provincesDatas.add(provinceTuple);
      List cityList = provinces["cityList"];

      for (var city in cityList) {
        Tuple3 cityTuple =
            Tuple3(provinces["code"], city["code"], city["name"]);
        cityDatas.add(cityTuple);

        // 如果locationCode与当前省匹配，则添加该省的城市到当前城市数据
        if (widget.locationCode == provinces["code"]) {
          currentCityDatas.add(cityTuple);
        }
      }
    }

    // 设置默认选中的省份
    for (var province in provincesDatas) {
      if (province.item2 == widget.locationCode) {
        selectedProvince.value = Tuple2(province.item2, province.item3);
      }
    }

    // 更新城市列表
    updateCityList(widget.locationCode);

    // 默认选中的省市
    result = Tuple4(
        selectedProvince.value.item1,
        selectedProvince.value.item2,
        currentCityDatas.isNotEmpty ? currentCityDatas.first.item2 : "",
        currentCityDatas.isNotEmpty ? currentCityDatas.first.item3 : "");
  }

  // 更新城市列表
  void updateCityList(String provinceCode) {
    currentCityDatas.clear(); // 清空当前城市数据
    for (var city in cityDatas) {
      if (city.item1 == provinceCode) {
        currentCityDatas.add(city);
      }
    }

    // 更新默认选择的城市（如果有的话）
    if (currentCityDatas.isNotEmpty) {
      selectedCity.value =
          Tuple2(currentCityDatas.first.item2, currentCityDatas.first.item3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 310.w,
      height: widget.height,
      decoration: BoxDecoration(
        color: COLOR.color_111,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.isAlert
              ? SizedBox(
                  height: 50.w,
                  child: Center(
                    child: Text(
                      "城市",
                      style: TextStyle(
                        color: COLOR.white,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: 50.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      15.horizontalSpace,
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          widget.cancel.call();
                        },
                        child: Text(
                          "取消",
                          style: TextStyle(
                            color: COLOR.white,
                            fontSize: 14.w,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        height: 50.w,
                        alignment: Alignment.center,
                        child: Center(
                          child: Text(
                            "城市",
                            style: TextStyle(
                              color: COLOR.white,
                              fontSize: 16.w,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          result = Tuple4(
                              selectedProvince.value.item1,
                              selectedProvince.value.item2,
                              selectedCity.value.item1,
                              selectedCity.value.item2);
                          widget.confirm.call(result);
                        },
                        child: Text(
                          "确定",
                          style: TextStyle(
                            color: COLOR.white,
                            fontSize: 14.w,
                          ),
                        ),
                      ),
                      15.horizontalSpace,
                    ],
                  ),
                ),
          Container(
            color: COLOR.color_CD73FB,
            height: 1.w,
          ),
          SizedBox(
            height: 170.w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: SizedBox(
                  height: 170.w,
                  child: Obx(() =>
                      _provincesCityListView(provincesDatas, (Tuple3 province) {
                        selectedProvince.value =
                            Tuple2(province.item2, province.item3);
                        updateCityList(province.item2);
                      })),
                )),
                Expanded(
                    child: SizedBox(
                  height: 170.w,
                  child: Obx(() =>
                      _provincesCityListView(currentCityDatas, (Tuple3 city) {
                        selectedCity.value = Tuple2(city.item2, city.item3);
                      })),
                )),
              ],
            ),
          ),
          20.verticalSpace,
          widget.isAlert
              ? Divider(
                  color: COLOR.color_F0F0F0.withOpacity(0.8),
                  height: 0.5.w,
                  thickness: 0,
                )
              : const SizedBox.shrink(),
          widget.isAlert
              ? SizedBox(
                  height: 50.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          widget.cancel.call();
                        },
                        child: Text(
                          "取消",
                          style: TextStyle(
                            color: COLOR.color_CD73FB,
                            fontSize: 14.w,
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          result = Tuple4(
                              selectedProvince.value.item1,
                              selectedProvince.value.item2,
                              selectedCity.value.item1,
                              selectedCity.value.item2);
                          widget.confirm.call(result);
                        },
                        child: Text(
                          "确定",
                          style: TextStyle(
                            color: COLOR.color_CD73FB,
                            fontSize: 14.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  // 自定义列表组件
  _provincesCityListView(List<Tuple3> provinceCitys,
      Function(Tuple3 tuple3) onSelectedItemChanged) {
    return CupertinoPicker.builder(
      itemExtent: 50.w,
      useMagnifier: false,
      onSelectedItemChanged: (index) {
        final item = provinceCitys[index];
        Tuple3 tuple3 = Tuple3(item.item1, item.item2, item.item3);
        onSelectedItemChanged(tuple3); // 传递 code 和 name
      },
      childCount: provinceCitys.length,
      // selectionOverlay: Container(
      //   margin: EdgeInsets.symmetric(horizontal: 45.w),
      //   decoration: BoxDecoration(
      //       border: Border(
      //     top: BorderSide(color: AppColor.color_CD73FB, width: 1.w),
      //     bottom: BorderSide(color: AppColor.color_CD73FB, width: 1.w),
      //   )),
      // ),
      itemBuilder: (context, index) {
        final item = provinceCitys[index];
        return Center(
          child: Text(
            item.item3, // 显示名称
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(color: COLOR.white, fontSize: 14.w),
          ),
        );
      },
    );
  }
}
