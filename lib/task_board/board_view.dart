import 'package:flutter/material.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker/task_board/task_board_controller.dart';
import 'package:task_tracker/view/create_board/create_board_controller.dart';
import 'package:task_tracker/view/task/task_screen.dart';

import '../common/app_color.dart';
import '../common/app_strings.dart';
import '../common/text_size.dart';
import '../main_controller.dart';
import '../model/task_model.dart';
import '../view/create_board/create_board_screen.dart';
import 'board_card.dart';
import 'board_item_model.dart';
import 'board_list.dart';

class BardViewScreen extends StatelessWidget {
  final Map<String, dynamic> boardData;

  BardViewScreen({required this.boardData});

  final TaskBoardController taskBoardController =
      Get.put<TaskBoardController>(TaskBoardController());
  final createBoardController =
      Get.put<CreateBoardController>(CreateBoardController());

  void _handleCardTap(BoardItemModel item) {
    String formattedDateTime =
        DateFormat('hh:mm a, dd-MM-yyyy').format(DateTime.now());

    Get.to(TaskScreen(
      title: createBoardController.title.text,
      discription: createBoardController.createTaskDiscription.text,
      createdTime: item.createdTime ?? formattedDateTime,
    ));
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      const SnackBar(content: Text('Item tap')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainController = Get.put<MainController>(MainController());
    // Initialize tasks based on boardData when the screen builds
    taskBoardController.initBoardTasks(boardData);
    return GetBuilder<TaskBoardController>(
      init: taskBoardController,
      builder: (controller) {
        List<BoardList> lists = taskBoardController.listData
            .map((list) => _createBoardList(list))
            .toList();

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: mainController.selectedPrimaryColor,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Container(
                color: Colors.transparent,
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: mainController.selectedPrimaryColor ==
                          const Color(0xffffffff)
                      ? AppColors.blackColor
                      : AppColors.whiteColor,
                ),
              ),
            ),
            title: Text(
              'taskBoardApp'.tr,
              style: TextStyle(
                fontSize: TextSize.titleSize,
                fontWeight: FontWeight.w500,
                color: mainController.selectedPrimaryColor ==
                        const Color(0xffffffff)
                    ? AppColors.blackColor
                    : AppColors.whiteColor,
              ),
            ),
          ),
          body: BoardView(
            lists: lists,
            boardViewController: controller.boardViewController,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: mainController.selectedPrimaryColor,
            onPressed: () {
              Get.to(CreateBoardScreen(createTaskScreen: "Yes"));
            },
            tooltip: 'Add Card',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  BoardList _createBoardList(BoardListModel list) {
    List<BoardItem> items =
        list.items.map((item) => buildBoardItem(item)).toList();
    return BoardList(
      draggable: true,
      onDropList: taskBoardController.handleDropList,
      header: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Obx(
                () {
                  return Badge(
                    offset: const Offset(12, -4),
                    label: Text("${list.count.value}"),
                    // Display count of items in the list
                    child: Text(
                      list.name,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  );
                },
              ),
              if (list.name == AppStrings.toDo)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: () {
                      Get.to(CreateBoardScreen(createTaskScreen: "Yes"));
                    },
                    icon: Icon(Icons.add_circle),
                  ),
                ),
            ],
          ),
        ),
      ],
      items: items,
    );
  }

  BoardItem buildBoardItem(BoardItemModel itemObject) {
    return BoardItem(
      draggable: true,
      onStartDragItem:
          (int? listIndex, int? itemIndex, BoardItemState? state) {},
      onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
          int? oldItemIndex, BoardItemState? state) {
        var item = taskBoardController.listData[oldListIndex!].items.removeAt(
          oldItemIndex!,
        );
        taskBoardController.listData[listIndex!].items.insert(
          itemIndex!,
          item,
        );

        // Update corresponding task list in TaskBoardController
        switch (oldListIndex) {
          case 0: // From ToDo
            taskBoardController.todoTasks.removeAt(oldItemIndex);
            break;
          case 1: // From InProgress
            taskBoardController.inProgressTasks.removeAt(oldItemIndex);
            break;
          case 2: // From Done
            taskBoardController.doneTasks.removeAt(oldItemIndex);
            break;
        }

        // Add to the new list in TaskBoardController
        switch (listIndex) {
          case 0: // To ToDo
            taskBoardController.todoTasks.insert(
              itemIndex,
              Task(
                title: item.title,
                description: item.subtitle,
              ),
            );
            break;
          case 1: // To InProgress
            taskBoardController.inProgressTasks.insert(
              itemIndex,
              Task(
                title: item.title,
                description: item.subtitle,
              ),
            );
            break;
          case 2: // To Done
            taskBoardController.doneTasks.insert(
              itemIndex,
              Task(
                title: item.title,
                description: item.subtitle,
              ),
            );
            break;
        }

        taskBoardController.updateCounts(); // Update counts after item movement
      },
      onTapItem:
          (int? listIndex, int? itemIndex, BoardItemState? state) async {},
      item: BoardCard(item: itemObject, onTap: _handleCardTap),
    );
  }
}
