import 'package:flutter_boardview/boardview_controller.dart';
import 'package:get/get.dart';

import '../common/app_strings.dart';
import '../model/task_model.dart';
import 'board_item_model.dart';
import 'board_list.dart';

class TaskBoardController extends GetxController {
  var todoTasks = <Task>[].obs;
  var inProgressTasks = <Task>[].obs;
  var doneTasks = <Task>[].obs;

  void addTask(Task task) {
    todoTasks.add(task);
    update();
  }

  void moveTaskToInProgress(Task task) {
    todoTasks.remove(task);
    inProgressTasks.add(task);
    update();
  }

  void moveTaskToDone(Task task) {
    inProgressTasks.remove(task);
    doneTasks.add(task);
    update();
  }

  final List<BoardListModel> listData = [
    BoardListModel(count: 11, name: AppStrings.toDo, items: []),
    BoardListModel(count: 4, name: AppStrings.taskBoardApp, items: []),
    BoardListModel(count: 1, name: AppStrings.done, items: []),
  ];

  BoardViewController boardViewController = BoardViewController();

  void handleDropList(int? listIndex, int? oldListIndex) {
    var list = listData[oldListIndex!];
    listData.removeAt(oldListIndex);
    listData.insert(listIndex!, list);
  }
  addCardItem(String title,String subtitle) {
    listData[0].items.add(
      BoardItemModel.newItem(
        title: title,
        subtitle: subtitle,
        description: "Description of task",
      ),
    );
    update();
  }
}
