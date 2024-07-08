import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/view/splash/splash_screen.dart';

import 'common/app_color.dart';
import 'main_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mainController = Get.put<MainController>(MainController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: mainController.selectedThemeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: AppColors.getMaterialColorFromColor(
            mainController.selectedPrimaryColor),
        primaryColor: mainController.selectedPrimaryColor,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: AppColors.getMaterialColorFromColor(
            mainController.selectedPrimaryColor),
        primaryColor: mainController.selectedPrimaryColor,
      ),
      home: const SplashScreen(),
    );
  }
}
