import 'dart:convert';

import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../utils/color.dart';
import '../dialog.dart';
import 'provinces_city_bottom_view.dart';
import 'provinces_city_view.dart';

///默认城市选择器
showDefaultProvincesCityPicker({
  TextStyle? cancelTextStyle,
  TextStyle? confirmTextStyle,
  String locationCode = "110000",
  required Function(Tuple4 tuple) callback,
}) async {
  TextStyle textStyle = TextStyle(
    fontSize: 18.w,
    color: COLOR.color_333333,
    fontWeight: FontWeight.w500,
  );
  Result? result = await CityPickers.showCityPicker(
    context: Get.context!,
    showType: ShowType.pc,
    theme: ThemeData(),
    locationCode: locationCode,
    cancelWidget: Text(
      "取消",
      style: cancelTextStyle ?? textStyle,
    ),
    confirmWidget: Text(
      "确定",
      style: confirmTextStyle ?? textStyle,
    ),
  );
  Tuple4 tuple = Tuple4(
    result?.provinceId ?? "",
    result?.provinceName ?? "",
    result?.cityId ?? "",
    result?.cityName ?? "",
  );
  callback.call(tuple);
}

///自定义 城市选择器
showCustomizeProvincesCityPicker({
  TextStyle? cancelTextStyle,
  TextStyle? confirmTextStyle,
  String locationCode = "110000",
  required Function(Tuple4) callback,
}) async {
  // 默认文本样式
  TextStyle textStyle = TextStyle(
    fontSize: 18.w,
    color: COLOR.color_333333,
    fontWeight: FontWeight.w500,
  );

  // 用于存储省和市的数据
  Map<String, String> provincesData = {};
  Map<String, dynamic> citiesData = {};

  // 从 assets 文件加载省市数据
  String data = await DefaultAssetBundle.of(Get.context!)
      .loadString("assets/json/province_city_json.json");

  List list = json.decode(data);

  for (var provinces in list) {
    String provincesCode = provinces["code"];
    provincesData[provincesCode] = provinces["name"];
    List cityList = provinces["cityList"];
    for (var city in cityList) {
      citiesData[provincesCode] = {city["code"]: city["name"]};
    }
  }

  // 调用 CityPickers 显示城市选择器
  Result? result = await CityPickers.showCityPicker(
    context: Get.context!,
    showType: ShowType.pc,
    theme: ThemeData(),
    provincesData: provincesData,
    // citiesData: citiesData,
    locationCode: locationCode,
    cancelWidget: Text(
      "取消",
      style: cancelTextStyle ?? textStyle,
    ),
    confirmWidget: Text(
      "确定",
      style: confirmTextStyle ?? textStyle,
    ),
  );

  Tuple4 tuple = Tuple4(
    result?.provinceId ?? "",
    result?.provinceName ?? "",
    result?.cityId ?? "",
    result?.cityName ?? "",
  );
  callback.call(tuple);
}

showAlertCityPicker(
  BuildContext context, {
  double? height,
  bool clickMaskDismiss = false,
  VoidCallback? onMask,
  String locationCode = "110000",
  Function()? cancel,
  required Function(Tuple4 result) confirm,
}) async {
  SmartDialog.show(
    clickMaskDismiss: clickMaskDismiss,
    onMask: onMask,
    builder: (context) {
      return ProvincesCityView(
        height: height,
        locationCode: locationCode,
        cancel: () {
          dismiss();
          cancel?.call();
        },
        confirm: (Tuple4 result) {
          dismiss();
          confirm.call(result);
        },
      );
    },
  );
}

showBottomSheetCityPicker({
  List<Tuple4<String, String, String, String>>? provincesCityData,
  String locationCode = "110000",
  Function()? cancel,
  required Function(Tuple4 result) confirm,
}) {
  Get.bottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProvincesCityBottomView(
            provincesCityData: provincesCityData,
            locationCode: locationCode,
            cancel: () {
              dismiss();
              cancel?.call();
            },
            confirm: (Tuple4 result) {
              dismiss();
              confirm.call(result);
            },
          ),
        ],
      ));
}
