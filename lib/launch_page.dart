import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:baby_app/services/user_service.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import 'app_prepare.dart';
import 'http/service/restart_app_dialog.dart';
import 'env/environment_service.dart';
import 'generate/app_image_path.dart';
import 'http/api/login.dart';
import 'launch_ad_widget.dart';
import 'routes/routes.dart';
import 'services/app_service.dart';
import 'services/storage_service.dart';
import 'utils/color.dart';
import 'utils/utils.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<LaunchPage> {
  String _stepTips = '';
  bool _success = false;

  @override
  void initState() {
    _doLoading();
    super.initState();
  }

  Future<void> _doLoading() async {
    // 检测网络状态
    if (!await _checkNetworkStatus()) {
      await Get.offNamed(Routes.no_net_work);
      RestartAppDialog.show(msg: "没有网络!");
      return;
    }

    // 选线
    if (!await _chooseLine()) {
      RestartAppDialog.show(msg: "选线失败!");
      return;
    }
    // 登陆
    if (!await _login()) {
      RestartAppDialog.show(msg: "登陆失败!");
      return;
    }
    //获取广告
    await fecthAllAds();
    // 一些初始化请求
    Get.find<AppService>().sendNetworkInitReq();
    // logger.d('AppService sendReqs status >>> $_');
    //初始化成功了
    setState(() {
      _success = true;
    });
  }

  Future<bool> _checkNetworkStatus() async {
    if (kIsWeb) return true;
    setState(() {
      _stepTips = '正在检测网络...';
    });
    return Utils.checkNetworkStatus();
  }

  Future<bool> _chooseLine() async {
    if (kIsWeb) return true;
    setState(() {
      _stepTips = '正在选择最佳线路...';
    });
    await AppPrepare.chooseAPILines();
    final ok = Environment.apiLinesOk;
    if (!ok) {
      setState(() {
        _stepTips = '选择线路失败,请检查网络.';
      });
    }
    return ok;
  }

  Future<bool> _login() async {
    setState(() {
      _stepTips = '正在登陆...';
    });

    final localStore = Get.find<StorageService>();
    final token = localStore.token ?? '';
    //本地存储过账号就不用再掉登陆接口了
    if (token.isNotEmpty) {
      ///存储图片域名
      await Get.find<UserService>().updateAPIUserInfo();
      return true;
    }
    final deviceId = localStore.deviceId;
    bool ok = false;
    if (deviceId != null) {
      ok = await login(deviceId);
    }
    if (!ok) {
      setState(() {
        _stepTips = '登陆失败,请检查网络.';
      });
    }
    return ok;
  }

  Widget _buildLoading() => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImagePath.app_default_splash),
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImagePath.player_loading, width: 80.w, height: 80.w),
            10.w.verticalSpaceFromWidth,
            Text(
              _stepTips,
              style: TextStyle(color: COLOR.themeSelectedColor, fontSize: 14.w),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: !_success ? _buildLoading() : const LuanchAdWidget(),
      );
}
