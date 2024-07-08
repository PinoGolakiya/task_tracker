import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_tracker/local_database/locoal_datbase_screen.dart';

class CreateBoardController extends GetxController {
  TextEditingController boardName = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController createTaskDiscription = TextEditingController();

  final DatabaseHelper databaseHelper = DatabaseHelper();
}
