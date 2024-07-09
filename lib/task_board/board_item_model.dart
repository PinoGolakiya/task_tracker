// board_item_model.dart

import 'package:intl/intl.dart';

class BoardItemModel {
  final String title;
  final String subtitle;
  final String? createdTime; // Updated to String for formatted time

  BoardItemModel({
    required this.title,
    required this.subtitle,
     this.createdTime,
  });

  // Factory method to create a new item with current time
  factory BoardItemModel.newItem({
    required String title,
    required String subtitle,
  }) {
    String formattedDateTime = DateFormat('hh:mm a, dd-MM-yyyy').format(DateTime.now());
    return BoardItemModel(
      title: title,
      subtitle: subtitle,
      createdTime: formattedDateTime,
    );
  }
}
