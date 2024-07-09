import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/view/create_board/create_board_controller.dart';
import 'package:task_tracker/view/create_board/create_board_screen.dart';
import 'package:task_tracker/view/task/task_controller.dart';

import '../../common/app_color.dart';
import '../../common/common_widget.dart';
import '../../common/text_size.dart';
import '../../main_controller.dart';

class TaskScreen extends StatefulWidget {
  String title;
  String discription;
  final String createdTime; // Add createdTime as a parameter

  TaskScreen(
      {super.key,
      required this.title,
      required this.discription,
      required this.createdTime});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    final mainController = Get.put<MainController>(MainController());
    final createBoardController =
        Get.put<CreateBoardController>(CreateBoardController());
    return GetBuilder(
        init: TaskController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: mainController.selectedPrimaryColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_rounded,
                    color: mainController.selectedPrimaryColor ==
                            const Color(0xffffffff)
                        ? AppColors.blackColor
                        : AppColors.whiteColor),
              ),
              title: Text('task'.tr,
                  style: TextStyle(
                      fontSize: TextSize.titleSize,
                      fontWeight: FontWeight.w500,
                      color: mainController.selectedPrimaryColor ==
                              const Color(0xffffffff)
                          ? AppColors.blackColor
                          : AppColors.whiteColor)),
            ),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: AppColors.cardSecondColor.withOpacity(0.4),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                formateDescrption('title'.tr, widget.title),
                                IconButton(
                                    onPressed: () {
                                      Get.to(
                                              CreateBoardScreen(
                                                  createTaskScreen: "Yes"),
                                              arguments: [
                                            widget.title,
                                            widget.discription
                                          ])!
                                          .then(
                                        (value) {
                                          widget.title =
                                              createBoardController.title.text;
                                          widget.discription =
                                              createBoardController
                                                  .createTaskDiscription.text;
                                          controller.update();
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.edit)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            formateDescrption(
                                'createdAt'.tr, widget.createdTime),
                            const SizedBox(height: 5),
                            formateDescrption(
                                'description'.tr, widget.discription),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: CommonTextField(
                                  controller: controller.comment,
                                  isTitle: false,
                                  hintText: 'typeComment'.tr,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.send),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          );
        });
  }

  Widget formateDescrption(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: TextSize.mediumSize,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor),
        ),
        const SizedBox(height: 3),
        Text(
          description,
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: TextSize.mediumSize,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor),
        ),
      ],
    );
  }
}
