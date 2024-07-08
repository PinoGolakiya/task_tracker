import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/common/common_widget.dart';
import 'package:task_tracker/task_board/task_board_controller.dart';
import 'package:task_tracker/view/create_board/create_board_controller.dart';

import '../../common/app_color.dart';
import '../../common/app_strings.dart';
import '../../common/text_size.dart';
import '../../main_controller.dart';

class CreateBoardScreen extends StatefulWidget {
  String createTaskScreen = '';

  CreateBoardScreen({super.key, required this.createTaskScreen});

  @override
  State<CreateBoardScreen> createState() => _CreateBoardScreenState();
}

class _CreateBoardScreenState extends State<CreateBoardScreen> {
  final mainController = Get.put<MainController>(MainController());
  final taskController = Get.put<TaskBoardController>(TaskBoardController());
  final createBoardController =
      Get.put<CreateBoardController>(CreateBoardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MainController(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
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
                          : AppColors.whiteColor)),
              title: Text(
                  widget.createTaskScreen == "Yes"
                      ? AppStrings.createTask
                      : AppStrings.createBoard,
                  style: TextStyle(
                      fontSize: TextSize.titleSize,
                      fontWeight: FontWeight.w500,
                      color: mainController.selectedPrimaryColor ==
                              const Color(0xffffffff)
                          ? AppColors.blackColor
                          : AppColors.whiteColor)),
            ),
            floatingActionButton: ElevatedButton(
                onPressed: () async {
                  if (widget.createTaskScreen == "") {
                    Map<String, dynamic> board = {
                      'boardName': createBoardController.boardName.text,
                      'description': createBoardController.discription.text,
                    };
                    await createBoardController.databaseHelper
                        .insertBoard(board);
                    createBoardController.update();
                  } else {
                    taskController.addCardItem(createBoardController.title.text,
                        createBoardController.createTaskDiscription.text);
                  }
                  Get.back();
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        mainController.selectedPrimaryColor)),
                child: Text("+ ${AppStrings.create}",
                    style: TextStyle(
                      fontSize: TextSize.mediumSize,
                      fontWeight: FontWeight.w500,
                      color: mainController.selectedPrimaryColor ==
                              const Color(0xffffffff)
                          ? AppColors.blackColor
                          : AppColors.whiteColor,
                    ))),
            body: GetBuilder(
                init: CreateBoardController(),
                builder: (controller) {
                  return SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        CommonTextField(
                          controller: widget.createTaskScreen == "Yes"
                              ? controller.title
                              : controller.boardName,
                          isTitle: true,
                          titleName: widget.createTaskScreen == "Yes"
                              ? AppStrings.title
                              : AppStrings.boardName,
                          hintText: widget.createTaskScreen == "Yes"
                              ? AppStrings.title
                              : AppStrings.boardName,
                        ),
                        const SizedBox(height: 20),
                        CommonTextField(
                          controller: widget.createTaskScreen == "Yes"
                              ? controller.createTaskDiscription
                              : controller.discription,
                          isTitle: true,
                          titleName: AppStrings.discription,
                          hintText: AppStrings.discription,
                        ),
                      ],
                    ),
                  ));
                }),
          );
        });
  }
}
