import 'package:get/get.dart';

import 'board_item_model.dart';

class BoardListModel {
  RxInt count;
  List<BoardItemModel> items;
  String name;

  BoardListModel({
    required this.count,
    required this.name,
    required this.items,
  });
}
