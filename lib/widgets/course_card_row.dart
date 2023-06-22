import 'package:flutter/material.dart';
import 'package:ssis/controllers/card_check_controller.dart';
import 'package:ssis/models/course_model.dart';
import 'package:ssis/widgets/card_check_row.dart';

class CourseCardRow extends StatelessWidget {
  final Color color;
  final Color colorText;
  final double height;
  final double? width;
  final double fontSize;
  final CourseModel data;
  final ScrollController scrollController;
  final int index;
  final CardCheckController controller;
  const CourseCardRow({
    Key? key,
    required this.data,
    required this.scrollController,
    required this.index,
    this.color = Colors.white,
    this.colorText = Colors.black,
    this.height = 25.0,
    this.width,
    this.fontSize = 12,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return index > 0
        ?
    Row(mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CardCheckRow(
          data: data,
          color: const Color(0x00FFFFFF),
          colorCheckBox: Colors.white,
          width: 18,
          height: 18,
          index: index,
          controller: controller,
        ),
        Card(
          color: const Color(0x00FFFFFF),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 18,
              width: 90,
              child: Text(
                data.courseCode.toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
        Card(
          color: const Color(0x00FFFFFF),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 18,
              width: 180,
              child: Text(
                data.course.toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ],
    )
        :
    Row(mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CardCheckRow(
          data: data,
          color: const Color(0x00FFFFFF),
          colorCheckBox: Colors.white,
          width: 18,
          height: 18,
          index: index,
          controller: controller,
        ),
        Card(
          color: const Color(0x55FFFFFF),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 18,
              width: 90,
              child: Center(
                child: Text(
                  data.courseCode.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Card(
          color: const Color(0x55FFFFFF),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 18,
              width: 180,
              child: Center(
                child: Text(
                  data.course.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
