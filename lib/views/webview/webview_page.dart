/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-17 16:14:49
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-08-30 21:34:29
 * @FilePath: /baby_app/lib/src/modules/webview/vebview_page.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/widget_utils.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
// import 'package:universal_html/html.dart' as html;

import 'web_web_view.dart';

class AppWebViewPage extends StatefulWidget {
  final String url;
  const AppWebViewPage({
    super.key,
    required this.url,
  });

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<AppWebViewPage> {
  late InAppWebViewController _webViewController;
  String _title = '';
  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? H5WebViewPage(url: widget.url)
        : Scaffold(
            appBar: WidgetUtils.buildAppBar(_title),
            body: Stack(
              children: [
                Positioned.fill(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                    onTitleChanged: (controller, title) {
                      _title = title ?? '';
                      setState(() {});
                    },
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                      if (kIsWeb) addListeners();
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      final event = consoleMessage.message;
                      if (event == 'vip') {
                        Get.toVip();
                      } else if (event == 'wallet') {
                        Get.toWallet();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
  }

  void addListeners() {
    // _webViewController.addWebMessageListener(WebMessageListener(
    //   jsObjectName: "",
    //   onPostMessage: (message, sourceOrigin, isMainFrame, replyProxy) {
    //     debugger();
    //   },
    // ));
    // _webViewController.addJavaScriptHandler(
    //     handlerName: "vip",
    //     callback: (arr) {
    //       debugger();
    //     });
    // _webViewController.addJavaScriptHandler(
    //     handlerName: "wallet",
    //     callback: (arr) {
    //       debugger();
    //     });
  }
}
