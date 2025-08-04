import 'package:get/get.dart';
import 'package:http_service/http_service.dart';

import '../../components/diolog/dialog.dart';
import '../../env/environment_service.dart';
import '../../generate/app_build_config.dart';
import '../../services/storage_service.dart';
import '../api/login.dart';
import 'restart_app_dialog.dart';

class _ApiCrypto extends IApiCrypto {
  @override
  String get decryptKeySource => Get.find<StorageService>().token ?? '';
}

class ApiSettings extends IApiSettings {
  ApiSettings()
      : super(
          crypto: _ApiCrypto(),
          appName: AppBuildConfig.appName,
          appVersion: AppBuildConfig.appVersion,
        );

  final _storage = Get.find<StorageService>();

  @override
  String get baseUrl => Environment.kbaseAPI;

  @override
  String get deviceId => _storage.deviceId ?? '';

  @override
  String get deviceInfo => _storage.deviceInfo ?? '';

  @override
  ApiSpCodeHandler get spCodeHandler => ApiSpCodeHandlers.makeDefault(
        handleTokenError: (_) => login(deviceId),
        handleDefault: (code, resp) => RestartAppDialog.show(
          url: resp.realUri.path,
          code: code,
        ),
        handleRefreshAuthorization:
            ApiSpCodeHandlers.makeRefreshAuthorizationHandler(
                _storage.setToken),
      );

  @override
  void toast(String msg) => showToast(msg);

  @override
  List<ApiRequestHeadersBuilder> get requestHeadersBuilders => [
        ApiRequestInterceptor.makeBaseHeadersBuilder(),
        ApiRequestInterceptor.makeTokenHeadersBuilder(
          tokenGetter: () => _storage.token ?? '',
        )
      ];
}
