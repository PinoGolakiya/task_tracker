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
  BoardViewController boardViewController = BoardViewController();

  // Initialize board tasks based on board data
  void initBoardTasks(Map<String, dynamic>? boardData) {
    // Check if boardData is null or if 'tasks' key is absent
    if (boardData == null || boardData['tasks'] == null) {
      // Handle the case where boardData or tasks are null
      return;
    }

    // Clear existing tasks
    todoTasks.clear();
    inProgressTasks.clear();
    doneTasks.clear();

    // Safely access 'tasks' from boardData
    List<dynamic> tasks = boardData['tasks'];

    // Iterate through tasks and add them to appropriate lists
    tasks.forEach((task) {
      if (task is Map<String, dynamic>) {
        Task newTask = Task(
          title: task['title'] ?? '',
          description: task['description'] ?? '',
        );

        // Determine which list (ToDo, InProgress, Done) to add the task to
        switch (task['status']) {
          case AppStrings.toDo:
            todoTasks.add(newTask);
            break;
          case AppStrings.inProgress:
            inProgressTasks.add(newTask);
            break;
          case AppStrings.done:
            doneTasks.add(newTask);
            break;
          default:
            // Handle unexpected status if needed
            break;
        }
      }
    });

    updateCounts(); // Update counts after initializing tasks
  }

  final List<BoardListModel> listData = [
    BoardListModel(count: RxInt(0), name: AppStrings.toDo, items: []),
    BoardListModel(count: RxInt(0), name: AppStrings.taskBoardApp, items: []),
    BoardListModel(count: RxInt(0), name: AppStrings.done, items: []),
  ];

  void updateCounts() {
    listData[0].count.value = todoTasks.length;
    listData[1].count.value = inProgressTasks.length;
    listData[2].count.value = doneTasks.length;
    update(); // Notify GetX to update the UI
  }

  void handleDropList(int? listIndex, int? oldListIndex) {
    var list = listData.removeAt(oldListIndex!);
    listData.insert(listIndex!, list);
    updateCounts(); // Update counts after reordering lists
    update();
  }

  void addCardItem(String title, String subtitle) {
    listData[0].items.add(
          BoardItemModel.newItem(
            title: title,
            subtitle: subtitle,
          ),
        );
    todoTasks.add(
      Task(title: title, description: subtitle),
    ); // Add task to todoTasks
    updateCounts(); // Update counts after adding a new item
    update();
  }
  void updateCardItem(String oldTitle, String oldDescription, String newTitle, String newDescription) {
    listData.forEach((list) {
      int index = list.items.indexWhere((item) => item.title == oldTitle && item.subtitle == oldDescription);
      if (index != -1) {
        // Update the BoardItemModel instance in listData
        list.items[index] = BoardItemModel(
          title: newTitle,
          subtitle: newDescription,
        );
      }
    });

    // Update corresponding task in todoTasks
    Task? taskToUpdate;
    for (int i = 0; i < todoTasks.length; i++) {
      if (todoTasks[i].title == oldTitle && todoTasks[i].description == oldDescription) {
        taskToUpdate = todoTasks[i];
        taskToUpdate.title = newTitle;
        taskToUpdate.description = newDescription;
        break; // Exit the loop once task is updated
      }
    }

    updateCounts(); // Update counts after updating item
    update();
  }







}
