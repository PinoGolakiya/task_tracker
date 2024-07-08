import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/common/app_color.dart';
import 'package:task_tracker/common/app_strings.dart';
import 'package:task_tracker/common/text_size.dart';
import 'package:task_tracker/main_controller.dart';
import 'package:task_tracker/view/change_theme/settings_screen.dart';
import 'package:task_tracker/view/dashboard/dashboard_screen.dart';
import 'package:task_tracker/view/splash/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashController = Get.put<SplashController>(SplashController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MainController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: controller.selectedPrimaryColor,
            body: SafeArea(
                top: false,
                bottom: false,
                child: Column(
                  children: [
                    const Spacer(),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          AppStrings.splashImage,
                          height: splashController.responsiveSize.height * 0.25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppStrings.appName,
                      style: TextStyle(
                          fontSize: TextSize.titleSize,
                          color: controller.selectedPrimaryColor ==
                                  const Color(0xffffffff)
                              ? AppColors.blackColor
                              : AppColors.whiteColor),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(DashboardScreen());
                      },
                      child: Container(
                        height: splashController.responsiveSize.height * 0.10,
                        width: splashController.responsiveSize.width * 0.10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.selectedPrimaryColor ==
                                    const Color(0xffffffff)
                                ? AppColors.blackColor.withOpacity(0.3)
                                : AppColors.whiteColor.withOpacity(0.3)),
                        child: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
