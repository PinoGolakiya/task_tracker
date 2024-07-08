import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/common/app_strings.dart';
import 'package:task_tracker/main_controller.dart';
import 'package:task_tracker/view/change_theme/settings_screen.dart';
import 'package:task_tracker/view/create_board/create_board_screen.dart';

import '../../common/app_color.dart';
import '../../common/text_size.dart';
import '../../local_database/locoal_datbase_screen.dart';
import '../../task_board/board_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final mainController = Get.put<MainController>(MainController());
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MainController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: mainController.selectedPrimaryColor,
              title: Text(
                AppStrings.board,
                style: TextStyle(
                    fontSize: TextSize.titleSize,
                    fontWeight: FontWeight.w500,
                    color: mainController.selectedPrimaryColor ==
                            const Color(0xffffffff)
                        ? AppColors.blackColor
                        : AppColors.whiteColor),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.to(const SettingsScreen());
                    },
                    icon: Icon(Icons.settings,
                        color: mainController.selectedPrimaryColor ==
                                const Color(0xffffffff)
                            ? AppColors.blackColor
                            : AppColors.whiteColor))
              ],
            ),
            floatingActionButton: GestureDetector(
              onTap: () {
                Get.to( CreateBoardScreen(createTaskScreen: ''));
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: mainController.selectedPrimaryColor),
                child: Icon(
                  Icons.add,
                  color: mainController.selectedPrimaryColor ==
                          const Color(0xffffffff)
                      ? AppColors.blackColor
                      : AppColors.whiteColor,
                ),
              ),
            ),
            body: SafeArea(
                top: false,
                bottom: false,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    StreamBuilder<List<Map<String, dynamic>>>(
                      stream: databaseHelper.boardListStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text(AppStrings.noboard));
                        }
                        return Expanded(
                          child: GridView.builder(
                            itemCount: snapshot.data!.length,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 4.3),
                            itemBuilder: (context, index) {
                              var board = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(BardViewScreen());
                                },
                                child: Card(
                                  color: AppColors.cardSecondColor
                                      .withOpacity(0.4),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 60,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              board['boardName'],
                                              softWrap: true,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: TextSize.titleSize,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.whiteColor),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.cardColor,
                                          ),
                                          child: Text(
                                            board['description'],
                                            softWrap: true,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: TextSize.mediumSize,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.splashColor),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: AppColors.cardColor,
                                            ),
                                            child: Text(
                                              "${AppStrings.toDo} - 0",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize:
                                                      TextSize.mediumSmallSize,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.splashColor),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: AppColors.cardColor,
                                            ),
                                            child: Text(
                                              "${AppStrings.inProgress} - 0",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize:
                                                      TextSize.mediumSmallSize,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.splashColor),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: AppColors.cardColor,
                                            ),
                                            child: Text(
                                              "${AppStrings.done} - 0",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize:
                                                      TextSize.mediumSmallSize,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.splashColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                )),
          );
        });
  }
}
