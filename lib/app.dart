import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import 'assets/styles.dart';
import 'routes/pages.dart';
import 'routes/routes.dart';
import 'services/user_service.dart';
import 'utils/color.dart';
import 'utils/logger.dart';
import 'views/main/controllers/main_controller.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    ///入口路由
    const entranceRoute = Routes.launch;
    const defaultTextStyle = TextStyle(color: COLOR.primaryText);
    return ScreenUtilInit(
      designSize: const Size(375, 800),
      child: ToastificationWrapper(
        child: GetMaterialApp(
          theme: ThemeData(
            primaryColor: COLOR.themColor,
            scaffoldBackgroundColor: COLOR.scaffoldBg,
            textTheme: const TextTheme(
              displayLarge: defaultTextStyle,
              displayMedium: defaultTextStyle,
              displaySmall: defaultTextStyle,
              headlineLarge: defaultTextStyle,
              headlineMedium: defaultTextStyle,
              headlineSmall: defaultTextStyle,
              titleLarge: defaultTextStyle,
              titleMedium: defaultTextStyle,
              titleSmall: defaultTextStyle,
              bodyLarge: defaultTextStyle,
              bodyMedium: defaultTextStyle,
              bodySmall: defaultTextStyle,
              labelLarge: defaultTextStyle,
              labelMedium: defaultTextStyle,
              labelSmall: defaultTextStyle,
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: COLOR.themeSelectedColor, // 光标颜色
            ),
            tabBarTheme: const TabBarTheme(
              labelStyle: defaultTextStyle,
              dividerColor: COLOR.transparent,
            ),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              scrolledUnderElevation: 0.0,
              backgroundColor: COLOR.scaffoldBg,
              titleTextStyle: const TextStyle(
                fontSize: 18,
                color: COLOR.white,
                fontWeight: FontWeight.w500,
              ),
              elevation: 0,
              iconTheme: const IconThemeData(color: COLOR.white),
              surfaceTintColor: COLOR.hexColor('#ffffff'),
              actionsIconTheme:
                  IconThemeData(color: Styles.color.appBarIconColor),
              toolbarTextStyle: TextStyle(color: Styles.color.primaryText),
            ),
          ),
          initialRoute: entranceRoute,
          getPages: Pages.pages,
          navigatorObservers: [
            FlutterSmartDialog.observer,
            GetObserver(),
            CustomNavigatorObserver()
          ],
          builder: FlutterSmartDialog.init(),
        ),
      ),
    );
  }
}

class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    MainController? mainvc;
    try {
      // web页面刷新会丢失MainController
      mainvc = Get.find<MainController>();
    } catch (e) {
      logger.i(
          'didPop route:${route.settings.name},prev:${previousRoute?.settings.name}, $e');
    }

    final index = mainvc?.currentIndex.value;
    if (index == MainController.mine &&
        previousRoute != null &&
        (previousRoute.settings.name ?? '').startsWith("/home/")) {
      Get.find<UserService>().updateAll();
    }
    super.didPop(route, previousRoute);
  }
}
