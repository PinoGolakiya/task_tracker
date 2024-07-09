import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_tracker/view/splash/splash_screen.dart';

import 'common/app_color.dart';
import 'language/app_translation.dart';
import 'main_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mainController = Get.put<MainController>(MainController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: mainController.selectedThemeMode,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: AppColors.getMaterialColorFromColor(
          mainController.selectedPrimaryColor,
        ),
        primaryColor: mainController.selectedPrimaryColor,
      ),
      home: const SplashScreen(),
      translations: AppTranslations(), // Your translations class
      locale: Get.locale ?? Locale('en', 'US'), // Set initial locale
      fallbackLocale: const Locale('en', 'US'), // Set fallback locale in case locale isn't found
    );
  }
}
