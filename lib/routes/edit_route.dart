import 'dart:async';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ssis/controllers/card_check_controller.dart';
import 'package:ssis/handlers/course_handler.dart';
import 'package:ssis/handlers/student_handler.dart';
import 'package:ssis/repositories/course_repository.dart';
import 'package:ssis/widgets/gradient_button.dart';
import 'package:ssis/widgets/window_button.dart';

class EditRoute extends StatefulWidget {
  final CardCheckController cardCheckController;
  final Function callbackFunction;
  const EditRoute({
    Key? key,
    required this.cardCheckController,
    required this.callbackFunction,
  }) : super(key: key);

  @override
  State<EditRoute> createState() => _EditRouteState();
}

class _EditRouteState extends State<EditRoute> {
  CourseRepository courseRepository = CourseRepository();
  CourseHandler courseHandler = CourseHandler();
  StudentHandler studentHandler = StudentHandler();
  TextEditingController textControllerStudentID = TextEditingController();
  TextEditingController textControllerStudentFirstName = TextEditingController();
  TextEditingController textControllerStudentMiddleInitial = TextEditingController();
  TextEditingController textControllerStudentLastName = TextEditingController();

  late List<String> listFormattedCourses = [];

  bool enablerCancelButton = true;
  bool enablerEditButton = true;

  Future<void> coursesUpdateFormattedList() async {
    List<String> rawList = await courseHandler.formattedCoursesList(courseRepository.getList());
    setState(() {
      listFormattedCourses = rawList;
    });
  }

  void setEditButton(bool toggle) {
    setState(() {
      enablerEditButton = toggle;
    });
  }

  void assignUnedited() {
    textControllerStudentID.text = widget.cardCheckController.getSubmissionData().elementAt(0).toString();
    textControllerStudentFirstName.text = widget.cardCheckController.getSubmissionData().elementAt(1).toString();
    textControllerStudentMiddleInitial.text = widget.cardCheckController.getSubmissionData().elementAt(2).toString();
    textControllerStudentLastName.text = widget.cardCheckController.getSubmissionData().elementAt(3).toString();
    studentHandler.addIDNum(widget.cardCheckController.getSubmissionData().elementAt(0).toString());
    studentHandler.addFName(widget.cardCheckController.getSubmissionData().elementAt(1).toString());
    studentHandler.addMInitial(widget.cardCheckController.getSubmissionData().elementAt(2).toString());
    studentHandler.addLName(widget.cardCheckController.getSubmissionData().elementAt(3).toString());
    studentHandler.addAge(widget.cardCheckController.getSubmissionData().elementAt(4).toString());
    studentHandler.addSex(widget.cardCheckController.getSubmissionData().elementAt(5).toString());
    studentHandler.addCourse(widget.cardCheckController.getSubmissionData().elementAt(6).toString());
    studentHandler.addYearLevel(widget.cardCheckController.getSubmissionData().elementAt(7).toString().split(' ').first.toString());
  }

  @override
  void initState() {
    coursesUpdateFormattedList();
    assignUnedited();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF202124),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(width: 1260, height: 30, color: const Color(0xFF221C49)),
              WindowTitleBarBox(
                child: Row(children: [
                  Expanded(
                    child: SizedBox(width: 20, child: MoveWindow()),
                  ),
                  const SizedBox(width: 100, height: 30, child: WindowButtons())
                ]),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Form(
            child: Material(
              elevation: 8,
              color: const Color(0xFF2F1176),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: SizedBox(
                width: 650,
                height: 530,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 40),
                      const Center(
                        child: Text(
                          'STUDENT INFORMATION',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.3,
                            wordSpacing: 5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Divider(color: Colors.white.withOpacity(0.3)),
                      const SizedBox(height: 15),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          height: 30,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'I.D NUMBER :',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            onFieldSubmitted: (value) {
                              studentHandler.addIDNum(value);
                            },
                            onChanged: (value) {
                              studentHandler.addIDNum(value);
                            },
                            controller: textControllerStudentID,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  )),
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                              filled: true,
                              fillColor: const Color(0xFF202124),
                              hintText: 'I.D Number',
                              hintStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50.0),
                                gapPadding: 0,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        child: SizedBox(
                          height: 30,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'FULL NAME :',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                onFieldSubmitted: (value) {
                                  studentHandler.addFName(value);
                                },
                                onChanged: (value) {
                                  studentHandler.addFName(value);
                                },
                                controller: textControllerStudentFirstName,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                      )),
                                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                  filled: true,
                                  fillColor: Color(0xFF202124),
                                  hintText: 'First Name',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(50),
                                          bottomRight: Radius.circular(10)),
                                      gapPadding: 0),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            height: 40,
                            width: 50,
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                studentHandler.addMInitial(value);
                              },
                              onChanged: (value) {
                                studentHandler.addMInitial(value);
                              },
                              controller: textControllerStudentMiddleInitial,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    )),
                                contentPadding:
                                const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                filled: true,
                                fillColor: const Color(0xFF202124),
                                hintText: 'M.I.',
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(4.0),
                                  gapPadding: 0,
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            height: 40,
                            width: 230,
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                studentHandler.addLName(value);
                              },
                              onChanged: (value) {
                                studentHandler.addLName(value);
                              },
                              controller: textControllerStudentLastName,
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    )),
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                filled: true,
                                fillColor: Color(0xFF202124),
                                hintText: 'Last Name',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(50),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(50)),
                                    gapPadding: 0),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            child: SizedBox(
                              height: 40,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'AGE :',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 40,
                            width: 120,
                            child: Focus(
                              child: DropdownButtonFormField2(
                                value: studentHandler.getAge(),
                                decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        )),
                                    contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                                    isDense: true,
                                    filled: true,
                                    fillColor: const Color(0xFF202124),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(50.0),
                                        gapPadding: 0),
                                    prefixIconColor: const Color(0xFF202124)),
                                hint: const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    'Age',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                                items: List<int>.generate(50, (i) => i + 16)
                                    .toList()
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.toString(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      item.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Age';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  studentHandler.addAge(value);
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 200,
                                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  iconSize: 30,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xFF202124),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 30,
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 70),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            child: SizedBox(
                              height: 40,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'SEX :',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 40,
                            width: 120,
                            child: DropdownButtonFormField2(
                              value: studentHandler.getSex(),
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    )),
                                contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                                isDense: true,
                                filled: true,
                                fillColor: const Color(0xFF202124),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.0),
                                    gapPadding: 0),
                              ),
                              hint: const Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  'Sex',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              items: ['Male', 'Female', 'Intersex']
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Sex';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                studentHandler.addSex(value);
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: 200,
                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                iconSize: 30,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFF202124),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                  child: SizedBox(
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'COURSE :',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: 40,
                                    child: DropdownButtonFormField2(
                                      value: studentHandler.getCourse(),
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 1,
                                            )),
                                        contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                                        isDense: true,
                                        filled: true,
                                        fillColor: const Color(0xFF202124),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(50.0),
                                            gapPadding: 0),
                                      ),
                                      hint: const Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(
                                          'Courses',
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      items: listFormattedCourses
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          child: Text(
                                            item,
                                            overflow: TextOverflow.fade,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ))
                                          .toList(),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Course';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        studentHandler.addCourse(value);
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 50,
                                        width: 200,
                                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        ),
                                        iconSize: 30,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: const Color(0xFF202124),
                                        ),
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: 120,
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                  child: SizedBox(
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'YEAR LEVEL :',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: DropdownButtonFormField2(
                                    value: studentHandler.getYearLevel(),
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          )),
                                      contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                                      isDense: true,
                                      filled: true,
                                      fillColor: const Color(0xFF202124),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(50.0),
                                          gapPadding: 0),
                                    ),
                                    hint: const Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text(
                                        'Year Level',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    items: ['1st', '2nd', '3rd', '4th', '5th']
                                        .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Year Level';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      studentHandler.addYearLevel(value);
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 200,
                                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                      ),
                                      iconSize: 30,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xFF202124),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Divider(color: Colors.white.withOpacity(0.3)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GradientButton(
                            onPressed: () {
                              setEditButton(false);
                              studentHandler.submitEdit(widget.cardCheckController.getSubmissionData().first.toString()).then((value) {
                                if(value){
                                  setEditButton(true);
                                  widget.callbackFunction();
                                  Navigator.pop(context);
                                  print('exiting');
                                }else{
                                  print('STUCK');
                                }
                              });
                            },
                            isEnabled: enablerEditButton,
                            height: 40,
                            width: 140,
                            elevation: 5,
                            borderRadius: BorderRadius.circular(20),
                            colors: const [Color(0xff6433e8), Color(0xff6325e8)],
                            child: const Center(
                              child: Text(
                                'EDIT STUDENT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GradientButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            isEnabled: enablerCancelButton,
                            height: 40,
                            width: 90,
                            elevation: 5,
                            borderRadius: BorderRadius.circular(20),
                            colors: const [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                            child: const Center(
                              child: Text(
                                'CANCEL',
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
