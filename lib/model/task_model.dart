class Task {
  String title;
  String description;
  final String? createdTime;
  List<Comment> comments; // List to hold comments

  Task({
    required this.title,
    required this.description,
    this.createdTime,
    this.comments = const [], // Initialize with an empty list of comments
  });
}

class Comment {
  final String content;
  final String? createdTime;

  Comment({
    required this.content,
    required this.createdTime,
  });
}
