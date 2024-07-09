import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/view/dashboard/dashboard_screen.dart';

import 'common/app_color.dart';

class MainController extends GetxController {
  Color selectedPrimaryColor = AppColors.primaryColors[0];

  setSelectedPrimaryColor(Color _color) {
    selectedPrimaryColor = _color;
    update();
  }

  ThemeMode selectedThemeMode = ThemeMode.system;

  setSelectedThemeMode(ThemeMode _themeMode) {
    selectedThemeMode = _themeMode;
    update();
  }

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.to( DashboardScreen());
    });
    // TODO: implement onInit
    super.onInit();
  }
}
