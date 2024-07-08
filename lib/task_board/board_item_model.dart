import 'dart:math';

class BoardItemModel {
  final String title;
  final String subtitle;
  final String description;

  BoardItemModel({
    required this.title,
    required this.subtitle,
    required this.description,
  });

  // Factory constructor for stub items
  factory BoardItemModel.stub() {
    return BoardItemModel(
      title: "Task #${Random().nextInt(100)}",
      subtitle: "Subtitle of task",
      description: "Description of task",
    );
  }

  // Constructor for adding new items dynamically
  BoardItemModel.newItem( {
    required this.title,
    required this.subtitle,
    required this.description,
  });
}
