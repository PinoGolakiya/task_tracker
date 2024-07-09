import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/common/common_widget.dart';
import 'package:task_tracker/task_board/task_board_controller.dart';

import '../../common/app_color.dart';
import '../../common/app_strings.dart';
import '../../common/text_size.dart';
import '../../main_controller.dart';
import 'create_board_controller.dart';

class CreateBoardScreen extends StatefulWidget {
  final String createTaskScreen;

  CreateBoardScreen({required this.createTaskScreen});

  @override
  State<CreateBoardScreen> createState() => _CreateBoardScreenState();
}

class _CreateBoardScreenState extends State<CreateBoardScreen> {
  final mainController = Get.put<MainController>(MainController());
  final taskController = Get.put<TaskBoardController>(TaskBoardController());
  final createBoardController =
      Get.put<CreateBoardController>(CreateBoardController());

  @override
  void initState() {
    if (Get.arguments != null) {
      createBoardController.title.text = Get.arguments[0];
      createBoardController.createTaskDiscription.text = Get.arguments[1];
    } else {
      createBoardController.clearAllController();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              color:
                  mainController.selectedPrimaryColor == const Color(0xffffffff)
                      ? AppColors.blackColor
                      : AppColors.whiteColor),
        ),
        title: Text(
            widget.createTaskScreen == "Yes"
                ? 'createTask'.tr
                : 'createBoard'.tr,
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
              if (createBoardController.boardName.text.isEmpty) {
                Get.snackbar('', AppStrings.enterBoardName);
              } else if (createBoardController.discription.text.isEmpty) {
                Get.snackbar('', AppStrings.enterDiscription);
              } else {
                Map<String, dynamic> board = {
                  'boardName': createBoardController.boardName.text,
                  'description': createBoardController.discription.text,
                };
                await createBoardController.databaseHelper.insertBoard(board);
                taskController.update();
                Get.back();
              }
            } else if ((widget.createTaskScreen == "Yes")) {
              if (createBoardController.title.text.isEmpty) {
                Get.snackbar('', AppStrings.enterTitle);
              } else if (createBoardController
                  .createTaskDiscription.text.isEmpty) {
                Get.snackbar('', AppStrings.enterDiscription);
              } else {
                if (Get.arguments != null) {
                  // Update existing card item
                  // Assuming you have a method to update the card in your taskController
                 setState(() {

                  taskController.updateCardItem(
                    Get.arguments[0], // Title to update
                    Get.arguments[1], // Description to update
                    createBoardController.title.text,
                    createBoardController.createTaskDiscription.text,
                  );
                 });
                } else {
                  // Add new card item
                  taskController.addCardItem(
                    createBoardController.title.text,
                    createBoardController.createTaskDiscription.text,
                  );
                }
                Get.back();
              }
            }
          },
          style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all(mainController.selectedPrimaryColor)),
          child: Text("+ ${'create'.tr}",
              style: TextStyle(
                fontSize: TextSize.mediumSize,
                fontWeight: FontWeight.w500,
                color: mainController.selectedPrimaryColor ==
                        const Color(0xffffffff)
                    ? AppColors.blackColor
                    : AppColors.whiteColor,
              ))),
      body: GetBuilder<CreateBoardController>(
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
                        ? 'title'.tr
                        : 'boardName'.tr,
                    hintText: widget.createTaskScreen == "Yes"
                        ? 'title'.tr
                        : 'boardName'.tr,
                  ),
                  const SizedBox(height: 20),
                  CommonTextField(
                    controller: widget.createTaskScreen == "Yes"
                        ? controller.createTaskDiscription
                        : controller.discription,
                    isTitle: true,
                    titleName: 'description'.tr,
                    hintText: 'description'.tr,
                  ),
                ],
              ),
            ));
          }),
    );
  }
}
