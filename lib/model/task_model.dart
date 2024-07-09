class Task {
  String title;
  String description;
  final String? createdTime;

  Task({required this.title, required this.description,this.createdTime});
}
class Comment {
  final String content;
  final DateTime dateTime;

  Comment({
    required this.content,
    required this.dateTime,
  });
}