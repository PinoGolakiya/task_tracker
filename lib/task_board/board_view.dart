import 'package:flutter/material.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:get/get.dart';
import 'package:task_tracker/common/app_strings.dart';
import 'package:task_tracker/task_board/task_board_controller.dart';

import '../common/app_color.dart';
import '../common/text_size.dart';
import '../main_controller.dart';
import 'board_card.dart';
import 'board_item_model.dart';
import 'board_list.dart';

class BardViewScreen extends StatefulWidget {
  const BardViewScreen({Key? key}) : super(key: key);

  @override
  State<BardViewScreen> createState() => _BardViewScreenState();
}

class _BardViewScreenState extends State<BardViewScreen> {

final taskBoardController=Get.put<TaskBoardController>(TaskBoardController());
  void _handleCardTap() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Item tap')));
  }

  void _addNewCardToToDoList() {
    _showAddCardDialog();
  }

  void _showAddCardDialog() {
    String title = '';
    String subtitle = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Card'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) => title = value,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (value) => subtitle = value,
                decoration: InputDecoration(labelText: 'Subtitle'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                setState(() {
                  taskBoardController.listData[0].items.add(
                        BoardItemModel.newItem(
                          title: title,
                          subtitle: subtitle,
                          description: "Description of task",
                        ),
                      );
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainController = Get.put<MainController>(MainController());

    List<BoardList> lists = [];
    for (int i = 0; i < taskBoardController.listData.length; i++) {
      lists.add(_createBoardList(taskBoardController.listData[i]));
    }
    return GetBuilder(
        init: MainController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: mainController.selectedPrimaryColor,
              leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: mainController.selectedPrimaryColor ==
                            const Color(0xffffffff)
                        ? AppColors.blackColor
                        : AppColors.whiteColor,
                  )),
              title: Text(
                AppStrings.taskBoardApp,
                style: TextStyle(
                    fontSize: TextSize.titleSize,
                    fontWeight: FontWeight.w500,
                    color: mainController.selectedPrimaryColor ==
                            const Color(0xffffffff)
                        ? AppColors.blackColor
                        : AppColors.whiteColor),
              ),
            ),
            body: BoardView(
              lists: lists,
              boardViewController: taskBoardController.boardViewController,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _addNewCardToToDoList,
              tooltip: 'Add Card',
              child: Icon(Icons.add),
            ),
          );
        });
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
              Badge(
                offset: const Offset(12, -4),
                label: Text("${list.count}"),
                child: Text(
                  list.name,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              if (list.name == AppStrings.toDo)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: _addNewCardToToDoList,
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
      onDropItem: (
        int? listIndex,
        int? itemIndex,
        int? oldListIndex,
        int? oldItemIndex,
        BoardItemState? state,
      ) {
        var item = taskBoardController.listData[oldListIndex!].items[oldItemIndex!];
        taskBoardController.listData[oldListIndex].items.removeAt(oldItemIndex);
        taskBoardController.listData[listIndex!].items.insert(itemIndex!, item);
      },
      onTapItem: (
        int? listIndex,
        int? itemIndex,
        BoardItemState? state,
      ) async {},
      item: BoardCard(item: itemObject, onTap: _handleCardTap),
    );
  }
}
