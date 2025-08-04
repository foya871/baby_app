import 'package:baby_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

// ignore: avoid_web_libraries_in_flutter
import 'package:universal_html/html.dart' as html;

class H5WebViewPage extends StatefulWidget {
  final String url;
  const H5WebViewPage({
    super.key,
    required this.url,
  });
  @override
  State<H5WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<H5WebViewPage> {
  late WebViewXController _controller;
  void initWebMessage(v) {
    String message = v.data;
    if (message == 'vip') {
      Get.toVip();
    }
    if (message == 'wallet') {
      Get.toWallet();
    }
  }

  @override
  void initState() {
    super.initState();
    html.window.addEventListener('message', initWebMessage);
  }

  @override
  void dispose() {
    _controller.dispose();
    html.window.removeEventListener('message', initWebMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: WebViewX(
        initialSourceType: SourceType.urlBypass,
        width: screenWidth,
        height: screenHeight,
        initialContent: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
      ),
    );
  }
}
