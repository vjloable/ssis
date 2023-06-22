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
  final int length;
  const CourseCardRow({
    Key? key,
    required this.data,
    required this.scrollController,
    required this.index,
    required this.controller,
    required this.length,
    this.color = Colors.white,
    this.colorText = Colors.black,
    this.height = 25.0,
    this.width,
    this.fontSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return length > 1
        ?
      index > 0
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
    )
        :
    Row(mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 48,
          height: 18,
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
