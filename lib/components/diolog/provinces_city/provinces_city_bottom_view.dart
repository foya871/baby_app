import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

enum ProvincesCityTheme {
  white,
  black,
}

class ProvincesCityBottomView extends StatefulWidget {
  final List<Tuple4<String, String, String, String>>? provincesCityData;
  final String locationCode;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final ProvincesCityTheme provincesCityTheme;
  final String title;
  final Function() cancel;
  final Function(Tuple4 result) confirm;

  const ProvincesCityBottomView({
    super.key,
    this.provincesCityData,
    this.width,
    this.height,
    this.backgroundColor,
    this.provincesCityTheme = ProvincesCityTheme.white,
    this.title = "",
    required this.locationCode,
    required this.cancel,
    required this.confirm,
  });

  @override
  State<StatefulWidget> createState() => _ProvincesCityViewState();
}

class _ProvincesCityViewState extends State<ProvincesCityBottomView> {
  RxList<Tuple3<String, String, String>> provincesDatas =
      <Tuple3<String, String, String>>[].obs; // 省数据
  RxList<Tuple3<String, String, String>> cityDatas =
      <Tuple3<String, String, String>>[].obs; // 所有城市数据
  RxList<Tuple3<String, String, String>> currentCityDatas =
      <Tuple3<String, String, String>>[].obs; // 当前城市数据

  Rx<Tuple2<String, String>> selectedProvince = const Tuple2("", "").obs;
  Rx<Tuple2<String, String>> selectedCity = const Tuple2("", "").obs;

  Tuple4<String, String, String, String> result = const Tuple4("", "", "", "");

  ProvincesCityTheme get provincesCityTheme =>
      widget.provincesCityTheme == ProvincesCityTheme.white
          ? ProvincesCityTheme.white
          : ProvincesCityTheme.black;

  @override
  void initState() {
    super.initState();
    initData();
  }

  // 初始化数据
  initData() async {
    if (widget.provincesCityData != null) {
      // 用 Set 存已添加的省 code，避免重复
      final addedProvinceCodes = <String>{};

      if (widget.provincesCityData != null) {
        // Map 用于去重，key 是省code，value 是 Tuple3（空字段，省code，省名）
        final provinceMap = <String, Tuple3<String, String, String>>{};

        for (var tuple in widget.provincesCityData!) {
          // 去重存省份
          provinceMap[tuple.item1] = Tuple3("", tuple.item1, tuple.item2);

          // 添加城市
          cityDatas.add(Tuple3(tuple.item1, tuple.item3, tuple.item4));

          // 初始化当前城市列表
          if (widget.locationCode == tuple.item1) {
            currentCityDatas.add(Tuple3(tuple.item1, tuple.item3, tuple.item4));
          }
        }

        // 按省code排序后填入 provincesDatas
        final sortedProvinces = provinceMap.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));
        provincesDatas.value = sortedProvinces.map((e) => e.value).toList().obs;
      }
    } else {
      // 原来 json 的逻辑可以保持不变（它一般就是无重复结构）
      String jsonStr = await DefaultAssetBundle.of(Get.context!)
          .loadString("assets/json/province_city_json.json");
      List provincesCityList = json.decode(jsonStr);

      for (var provinces in provincesCityList) {
        provincesDatas.add(Tuple3("", provinces["code"], provinces["name"]));
        List cityList = provinces["cityList"];

        for (var city in cityList) {
          cityDatas.add(Tuple3(provinces["code"], city["code"], city["name"]));

          if (widget.locationCode == provinces["code"]) {
            currentCityDatas
                .add(Tuple3(provinces["code"], city["code"], city["name"]));
          }
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

    // 默认结果
    result = Tuple4(
      selectedProvince.value.item1,
      selectedProvince.value.item2,
      currentCityDatas.isNotEmpty ? currentCityDatas.first.item2 : "",
      currentCityDatas.isNotEmpty ? currentCityDatas.first.item3 : "",
    );
  }

  // 根据省份 code 更新当前城市列表
  void updateCityList(String provinceCode) {
    currentCityDatas.clear();
    for (var city in cityDatas) {
      if (city.item1 == provinceCode) {
        currentCityDatas.add(city);
      }
    }

    if (currentCityDatas.isNotEmpty) {
      selectedCity.value =
          Tuple2(currentCityDatas.first.item2, currentCityDatas.first.item3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            (provincesCityTheme == ProvincesCityTheme.white
                ? COLOR.white
                : COLOR.black),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.w),
          topRight: Radius.circular(20.w),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitleView(),
          Container(color: COLOR.color_F5F5F5, height: 1.w),
          SizedBox(
            height: 170.w,
            child: Row(
              children: [
                Expanded(
                  child: Obx(() => _buildPicker(
                        provincesDatas,
                        (Tuple3 item) {
                          selectedProvince.value =
                              Tuple2(item.item2, item.item3);
                          updateCityList(item.item2);
                        },
                      )),
                ),
                Expanded(
                  child: Obx(() => _buildPicker(
                        currentCityDatas,
                        (Tuple3 item) {
                          selectedCity.value = Tuple2(item.item2, item.item3);
                        },
                      )),
                ),
              ],
            ),
          ),
          50.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildTitleView() {
    final titleColor = provincesCityTheme == ProvincesCityTheme.white
        ? COLOR.black
        : COLOR.white;

    return SizedBox(
      height: 50.w,
      child: Row(
        children: [
          15.horizontalSpace,
          Text("取消", style: TextStyle(color: titleColor, fontSize: 14.w))
              .onOpaqueTap(() {
            widget.cancel.call();
          }),
          Expanded(
            child: Center(
              child: Text(
                widget.title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Text("确定", style: TextStyle(color: titleColor, fontSize: 14.w))
              .onOpaqueTap(() {
            result = Tuple4(
              selectedProvince.value.item1,
              selectedProvince.value.item2,
              selectedCity.value.item1,
              selectedCity.value.item2,
            );
            widget.confirm.call(result);
          }),
          15.horizontalSpace,
        ],
      ),
    );
  }

  Widget _buildPicker(List<Tuple3<String, String, String>> data,
      Function(Tuple3) onSelectedItemChanged) {
    return CupertinoPicker.builder(
      itemExtent: 50.w,
      useMagnifier: false,
      childCount: data.length,
      onSelectedItemChanged: (index) => onSelectedItemChanged(data[index]),
      itemBuilder: (context, index) {
        final item = data[index];
        return Center(
          child: Text(
            item.item3,
            style: TextStyle(
              color: provincesCityTheme == ProvincesCityTheme.white
                  ? COLOR.black
                  : COLOR.white,
              fontSize: 14.w,
            ),
          ),
        );
      },
    );
  }
}
