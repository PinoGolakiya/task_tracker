import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                            Obx(
                              () {
                                return Row(
                                  children: [
                                    formateDescrption(
                                        'description'.tr, widget.discription),
                                    const Spacer(),
                                    Text(
                                      controller.timerText.value,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    IconButton(
                                      onPressed: () => controller.toggleTimer(),
                                      icon: Icon(controller.timerRunning.value
                                          ? Icons.pause
                                          : Icons.play_arrow),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: controller.comments.length,
                              itemBuilder: (context, index) {
                                String formattedDateTime =
                                    DateFormat('hh:mm a, dd-MM-yyyy')
                                        .format(DateTime.now());

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(0),
                                      ),
                                      color: AppColors.cardColor,
                                    ),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      title: Text(
                                        controller
                                                .comments[index].createdTime ??
                                            formattedDateTime,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: TextSize.mediumSize,
                                            color: AppColors.blackColor),
                                      ),
                                      subtitle: Text(
                                        controller.comments[index].content,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: AppColors.blackColor),
                                      ),
                                      // Add delete functionality if needed
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
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
                              onPressed: () {
                                String commentText = controller.comment.text;
                                controller
                                    .addComment(commentText); // Add comment
                                controller.comment.clear();
                              },
                              icon: const Icon(Icons.send),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
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
