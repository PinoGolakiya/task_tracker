import 'package:flutter/material.dart';
import 'package:task_tracker/common/text_size.dart';

import 'app_color.dart';
import 'app_strings.dart';

class CommonTextField extends StatelessWidget {
  String? titleName;
  String? hintText;
  TextEditingController? controller;
  bool? isTitle = false;

  CommonTextField({this.hintText,this.titleName, this.controller, this.isTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isTitle == true
            ? Text(titleName ?? AppStrings.boardName,
                style: TextStyle(
                  fontSize: TextSize.mediumSize,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ))
            : SizedBox(),
        SizedBox(height: isTitle == true ?5:0),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
