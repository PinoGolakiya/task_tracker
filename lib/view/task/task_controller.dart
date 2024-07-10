import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/task_model.dart';

class TaskController extends GetxController {
  TextEditingController comment=TextEditingController();
  List<Comment> comments = []; // List to hold comments

  var timerRunning = false.obs;
  var timerText = '00:00'.obs;
  Timer? _timer;
  int _secondsElapsed = 0;
  void addComment(String commentText) {
    String formattedDateTime = DateFormat('hh:mm a, dd-MM-yyyy').format(DateTime.now());

    Comment newComment = Comment(content: commentText, createdTime: formattedDateTime);
    comments.add(newComment);
    update();
  }
  void updateTimer(Timer timer) {
    _secondsElapsed++;
    int minutes = _secondsElapsed ~/ 60;
    int seconds = _secondsElapsed % 60;
    timerText.value = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void toggleTimer() {
    if (timerRunning.value) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), updateTimer);
    }
    timerRunning.toggle();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
