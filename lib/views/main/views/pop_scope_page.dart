/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-12-21 16:52:04
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2025-01-08 09:07:31
 * @FilePath: /shenshi_app/lib/views/main/views/pop_scope_page.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:baby_app/components/diolog/dialog.dart';

class PopScopePage extends StatefulWidget {
  final Widget child;

  const PopScopePage({
    super.key,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() => _PopScopePage();
}

class _PopScopePage extends State<PopScopePage> {
  DateTime? currentBackPressTime;

  bool closeOnConfirm() {
    DateTime now = DateTime.now();
    // 物理键，两次间隔大于4秒, 退出请求无效
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 4)) {
      currentBackPressTime = now;
      showToast('再次点击关闭应用程序');
      return false;
    }
    currentBackPressTime = null;
    return true;
  }

  @override
  Widget build(Object context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          if (closeOnConfirm()) {
            // 系统级别导航栈 退出程序
            SystemNavigator.pop();
          }
        },
        child: widget.child);
  }
}
