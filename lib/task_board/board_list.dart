import 'package:flutter_boardview/board_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'board_item_model.dart';

class BoardListModel {
  int count;
  List<BoardItemModel> items;
  String name;
  PagingController<int, BoardItem>? pagingController;

  BoardListModel({required this.count, required this.name, required this.items, this.pagingController});
}