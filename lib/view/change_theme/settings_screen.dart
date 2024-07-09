import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/common/app_strings.dart';

import '../../common/app_color.dart';
import '../../common/text_size.dart';
import '../../main_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final mainController = Get.put<MainController>(MainController());

  final List<Map<String, dynamic>> languages = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'German', 'locale': Locale('de', 'DE')},
    {'name': 'French', 'locale': Locale('fr', 'FR')},
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: mainController.selectedPrimaryColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_rounded,
                color: mainController.selectedPrimaryColor == const Color(0xffffffff)
                    ? AppColors.blackColor
                    : AppColors.whiteColor),
          ),
          title: Text(
            'settings'.tr,
            style: TextStyle(
              fontSize: TextSize.titleSize,
              fontWeight: FontWeight.w500,
              color: mainController.selectedPrimaryColor == const Color(0xffffffff)
                  ? AppColors.blackColor
                  : AppColors.whiteColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'selectLanguage'.tr,
                style: TextStyle(
                  fontSize: TextSize.mediumSize,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton<Map<String, dynamic>>(
                isExpanded: true,
                value: languages.firstWhere(
                        (lang) => lang['locale'] == Get.locale,
                    orElse: () => languages[0]),
                onChanged: (value) {
                  Get.updateLocale(value!['locale']);
                },
                items: languages.map<DropdownMenuItem<Map<String, dynamic>>>((lang) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: lang,
                    child: Text(lang['name']),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              Text(
                'changeTheme'.tr,
                style: TextStyle(
                  fontSize: TextSize.mediumSize,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: GridView.builder(
                  itemCount: AppColors.primaryColors.length,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2 / 1,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    bool isSelectedColor =
                        AppColors.primaryColors[index] == controller.selectedPrimaryColor;
                    return GestureDetector(
                      onTap: isSelectedColor
                          ? null
                          : () => controller.setSelectedPrimaryColor(AppColors.primaryColors[index]),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColors[index],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isSelectedColor ? 1 : 0,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Theme.of(context).cardColor.withOpacity(0.5),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
