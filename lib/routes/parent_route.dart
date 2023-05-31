import 'dart:async';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ssis/controllers/card_check_controller.dart';
import 'package:ssis/handlers/course_handler.dart';
import 'package:ssis/handlers/student_handler.dart';
import 'package:ssis/repositories/course_repository.dart';
import 'package:ssis/repositories/student_repository.dart';
import 'package:ssis/routes/delete_route.dart';
import 'package:ssis/routes/edit_route.dart';
import 'package:ssis/widgets/card_check_row.dart';
import 'package:ssis/widgets/card_row.dart';
import 'package:ssis/widgets/gradient_button.dart';
import 'package:ssis/widgets/list_panel.dart';
import 'package:ssis/widgets/window_button.dart';

class ParentRoute extends StatefulWidget {
  const ParentRoute({Key? key}) : super(key: key);

  @override
  State<ParentRoute> createState() => _ParentRouteState();
}

class _ParentRouteState extends State<ParentRoute> {
  StudentRepository studentRepository = StudentRepository();
  CourseRepository courseRepository = CourseRepository();
  CourseHandler courseHandler = CourseHandler();
  StudentHandler studentHandler = StudentHandler();
  TextEditingController textControllerCourse = TextEditingController();
  TextEditingController textControllerStudentID = TextEditingController();
  TextEditingController textControllerStudentFirstName = TextEditingController();
  TextEditingController textControllerStudentMiddleInitial = TextEditingController();
  TextEditingController textControllerStudentLastName = TextEditingController();
  CardCheckController cardCheckController = CardCheckController();

  late Future<List<List<dynamic>>> listCourses = [[]] as Future<List<List<dynamic>>>;
  late Future<List<List<dynamic>>> listStudents = [[]] as Future<List<List<dynamic>>>;
  late List<String> listFormattedCourses = [];

  bool enablerCourseButton = true;
  bool enablerStudentButton = true;

  Future<void> coursesUpdateFormattedList() async {
    List<String> rawList = await courseHandler.formattedCoursesList(courseRepository.getList());
    setState(() {
      listFormattedCourses = rawList;
    });
  }

  void coursesGetList() {
    setState(() {
      listCourses = courseRepository.getList();
    });
  }

  void studentGetList() {
    setState(() {
      listStudents = studentRepository.getList();
    });
  }


  void setCourseButton(bool toggle) {
    setState(() {
      enablerCourseButton = toggle;
    });
  }

  void setStudentButton(bool toggle) {
    setState(() {
      enablerStudentButton = toggle;
    });
  }

  void clearCoursePanel() {
    setState(() {
      courseHandler.addBachType(null);
      textControllerCourse.clear();
    });
  }

  void clearStudentPanel() {
    setState(() {
      studentHandler.addAge(null);
      studentHandler.addSex(null);
      studentHandler.addYearLevel(null);
      studentHandler.addCourse(null);
      textControllerStudentID.clear();
      textControllerStudentFirstName.clear();
      textControllerStudentMiddleInitial.clear();
      textControllerStudentLastName.clear();
    });
  }

  void update() {
    cardCheckController.uncheckAll();
    cardCheckController.resetSubmission();
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        studentGetList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    studentRepository.init();
    courseRepository.init();
    print('init');
    coursesGetList();
    studentGetList();
    coursesUpdateFormattedList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFF202124),
        ),
        child: Column(children: [
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
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: 1200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListPanel(
                        elevation: 6,
                        borderRadius: 5,
                        width: 880,
                        headHeight: 40,
                        bodyHeight: 360,
                        headerColor: const Color(0xFF6325E8),
                        bodyColor: const Color(0xFF303134),
                        headerChild: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedBuilder(
                                  animation: cardCheckController,
                                  builder: (context, child) {
                                    return AnimatedCrossFade(
                                      firstChild: SizedBox(
                                          height: 40,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => EditRoute(
                                                        cardCheckController: cardCheckController,
                                                        callbackFunction: update,
                                                      ),
                                                  )
                                                );
                                              },
                                              style: ButtonStyle(
                                                  padding: const MaterialStatePropertyAll(
                                                      EdgeInsets.zero),
                                                  backgroundColor:
                                                  const MaterialStatePropertyAll(Color(0xFF202124)),
                                                  shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          side: const BorderSide(
                                                              color: Color(0xFF202124))))),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.edit,
                                                      size: 19,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Flexible(
                                                      fit: FlexFit.loose,
                                                      child: Text(
                                                          'EDIT SELECTED ITEM',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w500)),
                                                    ),
                                                  ],
                                                ),
                                              ))),
                                      secondChild: SizedBox(
                                          height: 40,
                                          child: ElevatedButton(
                                              onPressed: null,
                                              style: ButtonStyle(
                                                  padding: const MaterialStatePropertyAll(
                                                      EdgeInsets.zero),
                                                  backgroundColor:
                                                  MaterialStatePropertyAll(const Color(0xFF221C49).withOpacity(0.3)),
                                                  shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          side: const BorderSide(
                                                              color: Color(0xFF221C49))))),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 19,
                                                  color: Color(0xFF221C49),
                                                ),
                                              ))),
                                      crossFadeState: cardCheckController.countChecks() == 1
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      duration: const Duration(milliseconds: 200),
                                      sizeCurve: Curves.fastOutSlowIn,
                                    );
                                  }),
                              const SizedBox(width: 10),
                              AnimatedBuilder(
                                  animation: cardCheckController,
                                  builder: (context, child) {
                                    return AnimatedCrossFade(
                                      firstChild: SizedBox(
                                          height: 40,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => DeleteRoute(
                                                        cardCheckController: cardCheckController,
                                                        callbackFunction: update,
                                                      ),
                                                    )
                                                );
                                              },
                                              style: ButtonStyle(
                                                  padding: const MaterialStatePropertyAll(
                                                      EdgeInsets.zero),
                                                  backgroundColor:
                                                      const MaterialStatePropertyAll(Colors.red),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          side: const BorderSide(
                                                              color: Colors.red)))),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Icon(
                                                      Icons.delete_rounded,
                                                      size: 19,
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Flexible(
                                                      fit: FlexFit.loose,
                                                      child: Text(
                                                          cardCheckController.countChecks() > 1
                                                              ? 'DELETE ${cardCheckController.countChecks()} SELECTED ITEMS'
                                                              : 'DELETE SELECTED ITEM',
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w500)),
                                                    ),
                                                  ],
                                                ),
                                              ))),
                                      secondChild: SizedBox(
                                          height: 40,
                                          child: ElevatedButton(
                                              onPressed: null,
                                              style: ButtonStyle(
                                                  padding: const MaterialStatePropertyAll(
                                                      EdgeInsets.zero),
                                                  backgroundColor:
                                                  MaterialStatePropertyAll(const Color(0xFF221C49).withOpacity(0.3)),
                                                  shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          side: const BorderSide(
                                                              color: Color(0xFF221C49))))),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: Icon(
                                                  Icons.delete_rounded,
                                                  size: 19,
                                                  color: Color(0xFF221C49),
                                                ),
                                              ))),
                                      crossFadeState: cardCheckController.countChecks() > 0
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      duration: const Duration(milliseconds: 200),
                                      sizeCurve: Curves.fastOutSlowIn,
                                    );
                                  }),
                            ],
                          ),
                        ),
                        child: FutureBuilder(
                            future: listStudents,
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length <= 1) {
                                  snapshot.data.add(['-', '-', '-', '-', '-', '-', '-', '-']);
                                }
                              }
                              return snapshot.hasData
                                  ? snapshot.data.elementAt(1).contains('-')
                                  ? const Column(
                                    children: [
                                      Card(color: Color(0x00FFFFFF), child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Center(child: Text('< List is empty >', style: TextStyle(color: Colors.white))),
                                      )),
                                    ],
                                  )
                                  : ListView.builder(
                                      shrinkWrap: false,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CardCheckRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              colorCheckBox: Colors.white,
                                              width: 18,
                                              height: 18,
                                              index: index,
                                              controller: cardCheckController,
                                            ),
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 80,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'ID NUMBER',
                                              formatter: StudentHandler().formatterIDNum,
                                              scrollController: ScrollController(),
                                            ),
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 160,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'FULL NAME',
                                              formatter: StudentHandler().formatterFullName,
                                              scrollController: ScrollController(),
                                            ),
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 30,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'AGE',
                                              formatter: StudentHandler().formatterAge,
                                              scrollController: ScrollController(),
                                            ),
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 50,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'SEX',
                                              formatter: StudentHandler().formatterSex,
                                              scrollController: ScrollController(),
                                            ),
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 160,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'COURSES',
                                              formatter: StudentHandler().formatterCourse,
                                              scrollController: ScrollController(),
                                            ),
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 70,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'YEAR LEVEL',
                                              formatter: StudentHandler().formatterYearLevel,
                                              scrollController: ScrollController(),
                                            ),
                                          ],
                                        );
                                      })
                                  : Container();
                            }),
                      ),
                      const SizedBox(width: 10),
                      ListPanel(
                        elevation: 6,
                        borderRadius: 5,
                        headHeight: 40,
                        bodyHeight: 360,
                        width: 200,
                        headerColor: const Color(0xff6325e8),
                        bodyColor: const Color(0xFF303134),
                        child: FutureBuilder(
                            future: listCourses,
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length <= 1) {
                                  snapshot.data.add(['-', '-']);
                                }
                              }
                              return snapshot.hasData
                                  ? ListView.builder(
                                      shrinkWrap: false,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 150,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'AVAILABLE COURSES',
                                              formatter: courseHandler.formatter,
                                              scrollController: ScrollController(),
                                            ),
                                          ],
                                        );
                                      })
                                  : Container();
                            }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Material(
                  elevation: 8,
                  color: const Color(0xFF2F1176),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: SizedBox(
                    height: 50,
                    width: 1090,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 35,
                              width: 100,
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
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 35,
                              width: 130,
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
                            SizedBox(
                              height: 35,
                              width: 52,
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
                            SizedBox(
                              height: 35,
                              width: 160,
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
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 35,
                              width: 80,
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
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 35,
                              width: 100,
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
                            const SizedBox(width: 8),
                            SizedBox(
                                height: 35,
                                width: 170,
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
                                    width: 170,
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
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 35,
                              width: 110,
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
                            const SizedBox(width: 8),
                            GradientButton(
                              onPressed: () {
                                setStudentButton(false);
                                studentHandler.submitAdd();
                                Timer(const Duration(milliseconds: 300), () {
                                  clearStudentPanel();
                                  studentGetList();
                                  setStudentButton(true);
                                });
                              },
                              isEnabled: enablerStudentButton,
                              height: 35,
                              width: 120,
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              colors: const [Color(0xff6433e8), Color(0xff6325e8)],
                              child: const Center(
                                child: Text(
                                  'ADD STUDENT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Material(
                  elevation: 8,
                  color: const Color(0xFF2F1176),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: SizedBox(
                    height: 50,
                    width: 1090,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Center(
                        child: SizedBox(
                          width: 1090,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Bachelor of',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                                width: 130,
                                child: DropdownButtonFormField2(
                                  value: courseHandler.getBachType(),
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
                                      'Bachelor Type',
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
                                  items: ['Arts', 'Science']
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
                                      return 'Bachelor Type';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    courseHandler.addBachType(value);
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
                              const SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'in',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                                width: 700,
                                child: TextFormField(
                                  onFieldSubmitted: (value) {
                                    courseHandler.addCourse(value);
                                  },
                                  onChanged: (value) {
                                    courseHandler.addCourse(value);
                                  },
                                  controller: textControllerCourse,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Course';
                                    }
                                    return null;
                                  },
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
                                    hintText: 'Course',
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
                              const SizedBox(width: 8),
                              GradientButton(
                                onPressed: () {
                                  setCourseButton(false);
                                  courseHandler.submit();
                                  Timer(const Duration(milliseconds: 300), () {
                                    clearCoursePanel();
                                    coursesGetList();
                                    coursesUpdateFormattedList();
                                    setStudentButton(true);
                                    setCourseButton(true);
                                  });
                                },
                                isEnabled: enablerCourseButton,
                                height: 35,
                                width: 120,
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                colors: const [Color(0xff6433e8), Color(0xff6325e8)],
                                child: const Center(
                                  child: Text(
                                    'ADD COURSE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 90, top: 15),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                    'v0.2.0 build',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                    ),
                )
            ),
          )
        ]));
  }

  @override
  void dispose() {
    textControllerCourse.dispose();
    textControllerStudentID.dispose();
    textControllerStudentFirstName.dispose();
    textControllerStudentMiddleInitial.dispose();
    textControllerStudentLastName.dispose();
    cardCheckController.dispose();
    super.dispose();
  }
}
