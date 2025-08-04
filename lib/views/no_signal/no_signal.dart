import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/utils/ad_jump.dart';
import 'package:baby_app/utils/app_utils.dart';

import '../../env/environment_service.dart';
import '../../http/api/api.dart';
import '../../services/storage_service.dart';
import '../../utils/color.dart';
import '../../utils/logger.dart';

class NoSignalPage extends StatefulWidget {
  const NoSignalPage({super.key});

  @override
  State<NoSignalPage> createState() => _NoSignalPageState();
}

class _NoSignalPageState extends State<NoSignalPage> {
  RxList<String> domains = <String>[].obs;
  RxString serviceAddress = "".obs;

  @override
  void initState() {
    super.initState();
    initOfficialInfo();
  }

  initOfficialInfo() {
    getJsonInOfficialAddress();
    getCustomerService();
  }

  getJsonInOfficialAddress() async {
    try {
      final option = BaseOptions(connectTimeout: const Duration(seconds: 30));
      final response =
          await Dio(option).get(Environment.backupOfficialAddressJson);
      if (response.data != null) {
        List<String> items = List<String>.from(response.data);
        domains.assignAll(items);
      }
    } catch (e) {
      logger.e(e);
    }
  }

  //客服
  getCustomerService() async {
    final storageService = Get.find<StorageService>();
    String domain = storageService.getLastSuccessDomain;
    if (domain == "" || domain.isEmpty) {
      return;
    }
    String deviceId = storageService.deviceId ?? "";
    if (deviceId == "" || deviceId.isEmpty) {
      return;
    }
    final response = await Api.getNewCustomerService(domain, deviceId);
    if (response == "" || response.isEmpty) {
      return;
    }
    final signUrl =
        domain.replaceAll("api/", "") + response.replaceAll("//", "/");
    serviceAddress.value = signUrl;
  }

  @override
  Widget build(BuildContext context) {
    return newBodyView();
  }

  newBodyView() {
    return Scaffold(
      backgroundColor: COLOR.color_F5F5F5,
      body: Center(
        child: Obx(() => showLineFailureDialog(
            Environment.backupOfficialEmail, serviceAddress.value, domains)),
      ),
    );
  }

  showLineFailureDialog(
      String email, String customerServiceAddress, List<String> domain) {
    return Container(
      width: 286.w,
      height: 385.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.w),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(height: 15.w),
          Text(
            "温馨提示",
            style: TextStyle(
              color: COLOR.black,
              fontSize: 18.w,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 30.w),
          Expanded(
            child: SingleChildScrollView(
              child: Text.rich(
                TextSpan(
                  text: 'APP线路检测失败\n\n',
                  style: TextStyle(fontSize: 15.w, color: COLOR.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: '解决方案：\n'
                          '1.请检测您的网络是否正常，手机是否开了VPN或3分钟后再尝试访问；\n'
                          '2.请联系在线客服或发送任意消息到邮箱获取最新地址，邮箱：',
                      style: TextStyle(
                        fontSize: 14.w,
                        color: COLOR.black,
                      ),
                    ),
                    TextSpan(
                      text: email,
                      style: TextStyle(
                        fontSize: 14.w,
                        color: COLOR.hexColor("#DD001B"),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          AppUtils.copyToClipboard(email);
                        },
                    ),
                    TextSpan(
                      text: '\n3.请到官网下载最新版，官网地址：',
                      style: TextStyle(
                        fontSize: 14.w,
                        color: COLOR.black,
                      ),
                    ),
                    if (domain.isNotEmpty)
                      TextSpan(
                        text: domain[0] ?? "",
                        style: TextStyle(
                          fontSize: 14.w,
                          color: COLOR.hexColor("#DD001B"),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            jumpExternalURL(domain[0]);
                          },
                      ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    kOnLineService(onLineServiceUrl: customerServiceAddress);
                  },
                  child: _buildButton("联系客服"),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    if (domain.isEmpty) {
                      return;
                    }
                    if (domain.length > 1) {
                      jumpExternalURL(domain[1]);
                    } else {
                      jumpExternalURL(domain[0]);
                    }
                  },
                  child: _buildButton("前往官网"),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.w),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      width: double.infinity,
      height: 37,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19.w),
        color: COLOR.hexColor("#F52443"),
        border: Border.all(color: COLOR.hexColor("#F52443"), width: 1.w),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: COLOR.white,
          fontSize: 16.w,
        ),
        maxLines: 1,
      ),
    );
  }
}
