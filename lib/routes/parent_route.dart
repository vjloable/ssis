import 'dart:async';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:ssis/controllers/card_check_controller.dart';
import 'package:ssis/controllers/progressbar_controller.dart';
import 'package:ssis/handlers/course_handler.dart';
import 'package:ssis/handlers/search_handler.dart';
import 'package:ssis/handlers/student_handler.dart';
import 'package:ssis/misc/progressbar_states.dart';
import 'package:ssis/misc/scope.dart';
import 'package:ssis/repositories/course_repository.dart';
import 'package:ssis/repositories/student_repository.dart';
import 'package:ssis/routes/add_route.dart';
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
  SearchHandler searchHandler = SearchHandler();
  TextEditingController textControllerCourse = TextEditingController();
  TextEditingController textControllerCourseCode = TextEditingController();
  TextEditingController textControllerStudentID = TextEditingController();
  TextEditingController textControllerStudentName = TextEditingController();
  TextEditingController searchControllerStudent = TextEditingController();
  TextEditingController searchControllerCourse = TextEditingController();
  CardCheckController cardCheckControllerStudent = CardCheckController();
  CardCheckController cardCheckControllerCourse = CardCheckController();
  ProgressBarController progressBarControllerStudent = ProgressBarController();
  ProgressBarController progressBarControllerCourse = ProgressBarController();

  late Future<List<List<dynamic>>> listCourses = [[]] as Future<List<List<dynamic>>>;
  late Future<List<List<dynamic>>> listStudents = [[]] as Future<List<List<dynamic>>>;
  late List<String> listFormattedCourseCodes = [];
  late List<String> listFormattedCourses = [];

  String buildVersion = '1.0.0';

  Future<void> coursesUpdateFormattedList() async {
    Map<String,String> rawMap = await courseHandler.formattedCoursesMap(courseRepository.getList());
    setState(() {
      listFormattedCourseCodes = rawMap.keys.toList();
      listFormattedCourses = rawMap.values.toList();
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

  void clearCoursePanel() {
    setState(() {
      textControllerCourseCode.clear();
      textControllerCourse.clear();
    });
  }

  void clearStudentPanel() {
    setState(() {
      studentHandler.addGender(null);
      studentHandler.addYearLevel(null);
      studentHandler.addCourseCode(null);
      textControllerStudentID.clear();
      textControllerStudentName.clear();
    });
  }

  void update() {
    cardCheckControllerStudent.uncheckAll();
    cardCheckControllerStudent.resetSubmission();
    cardCheckControllerCourse.uncheckAll();
    cardCheckControllerCourse.resetSubmission();
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        studentGetList();
        coursesGetList();
      });
    });
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
                child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                            width: 20,
                            child: MoveWindow(
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Simple Student Information System',
                                    style: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),
                      const SizedBox(width: 100, height: 30, child: WindowButtons())
                    ]
                ),
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
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        width: 740,
                        headHeight: 40,
                        bodyHeight: 410,
                        headerColor: const Color(0xFF6325E8),
                        bodyColor: const Color(0xFF303134),
                        headerChild: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Form(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50),
                                    ),
                                    color: Color(0xFF202124),
                                  ),
                                  child: AnimatedBuilder(
                                    animation: progressBarControllerStudent,
                                    builder: (context, child) {
                                      switch (progressBarControllerStudent.getState()) {
                                        case ProgressBarStates.idle:
                                          return const Icon(
                                              Icons.search,
                                              size: 16,
                                              color: Colors.white
                                          );
                                        case ProgressBarStates.searching:
                                          return const Padding(
                                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                                            child: SizedBox(
                                              width: 5,
                                              height: 5,
                                              child: CircularProgressIndicator(
                                                value: null,
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          );
                                        case ProgressBarStates.searched:
                                          return const Icon(
                                              Icons.search,
                                              size: 16,
                                              color: Colors.deepPurple
                                          );
                                      }
                                    }
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: SizedBox(
                                    height: 35,
                                    child: TextFormField(
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          listStudents = searchHandler.search(value, Scope.student, progressBarControllerStudent);
                                        });
                                        progressBarControllerStudent.setState(ProgressBarStates.searched);
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          listStudents = searchHandler.search(value, Scope.student, progressBarControllerStudent);
                                        });
                                        progressBarControllerStudent.setState(ProgressBarStates.searching);
                                      },
                                      controller: searchControllerStudent,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.zero),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 1,
                                            ),
                                        ),
                                        contentPadding:
                                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                        filled: true,
                                        fillColor: const Color(0xDE2A2B2E),
                                        hintText: 'Search',
                                        hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.4),
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(Radius.zero),
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
                                GradientButton(
                                  onPressed: () {

                                  },
                                  isEnabled: true,
                                  height: 35,
                                  width: 70,
                                  elevation: 5,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.zero,
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                    bottomLeft: Radius.zero,
                                  ),
                                  colors: const [Color(0xFF202124), Color(0xFF1A1C1E)],
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                                    child: FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Text('Search', style: TextStyle(fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: FutureBuilder(
                            future: listStudents,
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length <= 1) {
                                  snapshot.data.add(['-', '-', '-', '-', '-']);
                                }
                              }
                              return snapshot.hasData
                                  ? snapshot.data.elementAt(1).contains('-')
                                  ? const Column(
                                    children: [
                                      Card(color: Color(0x00FFFFFF), child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Center(child: Text('- Student list is empty -', style: TextStyle(color: Colors.white30, fontSize: 12, fontStyle: FontStyle.italic, letterSpacing: 1.3, fontWeight: FontWeight.w100))),
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
                                              controller: cardCheckControllerStudent,
                                            ),
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 90,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'ID NUMBER',
                                              formatter: StudentHandler().formatter,
                                              scrollController: ScrollController(),
                                              index: 0,
                                            ),
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 200,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'FULL NAME',
                                              formatter: StudentHandler().formatter,
                                              scrollController: ScrollController(),
                                              index: 1,
                                            ),
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 50,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'GENDER',
                                              formatter: StudentHandler().formatter,
                                              scrollController: ScrollController(),
                                              index: 2,
                                            ),
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 70,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'YEAR LEVEL',
                                              formatter: StudentHandler().formatter,
                                              scrollController: ScrollController(),
                                              index: 3,
                                            ),
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 90,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'COURSE CODE',
                                              formatter: StudentHandler().formatter,
                                              scrollController: ScrollController(),
                                              index: 4,
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
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        headHeight: 40,
                        bodyHeight: 410,
                        width: 395,
                        headerColor: const Color(0xff6325e8),
                        bodyColor: const Color(0xFF303134),
                        headerChild: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    bottomLeft: Radius.circular(50),
                                  ),
                                  color: Color(0xFF202124),
                                ),
                                child: AnimatedBuilder(
                                    animation: progressBarControllerCourse,
                                    builder: (context, child) {
                                      switch (progressBarControllerCourse.getState()) {
                                        case ProgressBarStates.idle:
                                          return const Icon(
                                              Icons.search,
                                              size: 16,
                                              color: Colors.white
                                          );
                                        case ProgressBarStates.searching:
                                          return const Padding(
                                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                                            child: SizedBox(
                                              width: 5,
                                              height: 5,
                                              child: CircularProgressIndicator(
                                                value: null,
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          );
                                        case ProgressBarStates.searched:
                                          return const Icon(
                                              Icons.search,
                                              size: 16,
                                              color: Colors.deepPurple
                                          );
                                      }
                                    }
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: SizedBox(
                                  height: 35,
                                  child: TextFormField(
                                    onFieldSubmitted: (value) {
                                      setState(() {
                                        listCourses = searchHandler.search(value, Scope.course, progressBarControllerCourse);
                                      });
                                      progressBarControllerCourse.setState(ProgressBarStates.searched);
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        listCourses = searchHandler.search(value, Scope.course, progressBarControllerCourse);
                                      });
                                      progressBarControllerCourse.setState(ProgressBarStates.searching);
                                    },
                                    controller: searchControllerCourse,
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.zero),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                      filled: true,
                                      fillColor: const Color(0xDE2A2B2E),
                                      hintText: 'Search',
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.4),
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(Radius.zero),
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
                              GradientButton(
                                onPressed: () {

                                },
                                isEnabled: true,
                                height: 35,
                                width: 70,
                                elevation: 5,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.zero,
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                  bottomLeft: Radius.zero,
                                ),
                                colors: const [Color(0xFF202124), Color(0xFF1A1C1E)],
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text('Search', style: TextStyle(fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        child: FutureBuilder(
                            future: listCourses,
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length <= 1) {
                                  snapshot.data.add(['-', '-']);
                                }
                              }
                              return snapshot.hasData
                                  ? snapshot.data.elementAt(1).contains('-')
                                  ? const Column(
                                children: [
                                  Card(color: Color(0x00FFFFFF), child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Center(child: Text('- Courses list is empty -', style: TextStyle(color: Colors.white30, fontSize: 12, fontStyle: FontStyle.italic, letterSpacing: 1.3, fontWeight: FontWeight.w100))),
                                  )),
                                ],
                              )
                                  : ListView.builder(
                                      shrinkWrap: false,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CardCheckRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              colorCheckBox: Colors.white,
                                              width: 18,
                                              height: 18,
                                              index: index,
                                              controller: cardCheckControllerCourse,
                                            ),
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 180,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'AVAILABLE COURSE',
                                              formatter: courseHandler.formatter,
                                              scrollController: ScrollController(),
                                              index: 1,
                                            ),
                                            CardRow(
                                              data: snapshot.data.elementAt(index),
                                              color: const Color(0x00FFFFFF),
                                              width: 90,
                                              height: 18,
                                              colorText: Colors.white,
                                              fontSize: 12,
                                              header: 'COURSE CODE',
                                              formatter: courseHandler.formatter,
                                              scrollController: ScrollController(),
                                              index: 0,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 8,
                      color: const Color(0xFF2F1176),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      child: SizedBox(
                        height: 50,
                        width: 740,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: AnimatedBuilder(
                                    animation: cardCheckControllerStudent,
                                    builder: (context, child) {
                                      return AnimatedCrossFade(
                                        firstChild: SizedBox(
                                            height: 40,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Text(
                                                    cardCheckControllerStudent.countChecks() > 1
                                                        ?
                                                    cardCheckControllerStudent.countChecks() == cardCheckControllerStudent.maxCheck()
                                                        ?  'ALL ITEMS SELECTED'
                                                        : '${cardCheckControllerStudent.countChecks()} ITEMS SELECTED'
                                                        : cardCheckControllerStudent.countChecks() == 1 && cardCheckControllerStudent.maxCheck() == 1
                                                        ? 'ALL ITEMS SELECTED' : '1 ITEM SELECTED',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold)
                                                ),
                                              ),
                                            )
                                        ),
                                        secondChild:  SizedBox(
                                          height: 40,
                                          child: Container(),
                                        ),
                                        crossFadeState: cardCheckControllerStudent.countChecks() > 0
                                            ? CrossFadeState.showFirst
                                            : CrossFadeState.showSecond,
                                        duration: const Duration(milliseconds: 200),
                                        sizeCurve: Curves.fastOutSlowIn,
                                      );
                                    }),
                                ),
                                GradientButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddRoute(
                                            cardCheckController: cardCheckControllerStudent,
                                            callbackFunction: update,
                                            scope: Scope.student,
                                          ),
                                        )
                                    );
                                  },
                                  isEnabled: true,
                                  height: 35,
                                  width: 70,
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(20),
                                  colors: const [Color(0xff6433e8), Color(0xff6325e8)],
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 22,
                                          ),
                                          SizedBox(width: 5),
                                          Text('Add', style: TextStyle(fontWeight: FontWeight.w600))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                AnimatedBuilder(
                                  animation: cardCheckControllerStudent,
                                  builder: (BuildContext context, Widget? child) {
                                    return GradientButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditRoute(
                                                cardCheckController: cardCheckControllerStudent,
                                                callbackFunction: update,
                                                scope: Scope.student,
                                              ),
                                            )
                                        );
                                      },
                                      isEnabled: cardCheckControllerStudent.countChecks() == 1,
                                      height: 35,
                                      width: 70,
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(20),
                                      colors: const [Color(0xff6433e8), Color(0xff6325e8)],
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 17.0),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                size: 18,
                                              ),
                                              SizedBox(width: 5),
                                              Text('Edit', style: TextStyle(fontWeight: FontWeight.w600))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                AnimatedBuilder(
                                  animation: cardCheckControllerStudent,
                                  builder: (BuildContext context, Widget? child) {
                                    return Row(
                                      children: [
                                        GradientButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => DeleteStudentRoute(
                                                    cardCheckController: cardCheckControllerStudent,
                                                    callbackFunction: update,
                                                    scope: Scope.student,
                                                  ),
                                                )
                                            );
                                          },
                                          isEnabled: cardCheckControllerStudent.countChecks() > 0,
                                          height: 35,
                                          width: cardCheckControllerStudent.countChecks() == cardCheckControllerStudent.maxCheck() && cardCheckControllerStudent.countChecks() > 1 ? 80 : 70,
                                          elevation: 5,
                                          borderRadius: BorderRadius.circular(20),
                                          colors: const [Color(0xFFFF0000), Color(0xFFFF2121)],
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.delete_rounded,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      cardCheckControllerStudent.countChecks() == cardCheckControllerStudent.maxCheck() && cardCheckControllerStudent.countChecks() > 1 ?
                                                      'Delete all' : 'Delete',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w600
                                                      )
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: cardCheckControllerStudent.countChecks() == cardCheckControllerStudent.maxCheck() && cardCheckControllerStudent.countChecks() > 1 ? 0 : 10,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Material(
                      elevation: 8,
                      color: const Color(0xFF2F1176),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      child: SizedBox(
                        height: 50,
                        width: 395,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: AnimatedBuilder(
                                      animation: cardCheckControllerCourse,
                                      builder: (context, child) {
                                        return AnimatedCrossFade(
                                          firstChild: SizedBox(
                                              height: 40,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                  child: Text(
                                                      cardCheckControllerCourse.countChecks() > 0
                                                          ?
                                                      cardCheckControllerCourse.countChecks() == cardCheckControllerCourse.maxCheck()
                                                          ?  'ALL ITEMS SELECTED'
                                                          : '${cardCheckControllerCourse.countChecks()} ITEMS SELECTED'
                                                          : cardCheckControllerStudent.countChecks() == 1 && cardCheckControllerStudent.maxCheck() == 1
                                                          ? 'ALL ITEMS SELECTED' : '1 ITEM SELECTED',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold)
                                                  ),
                                                ),
                                              )
                                          ),
                                          secondChild:  SizedBox(
                                            height: 40,
                                            child: Container(),
                                          ),
                                          crossFadeState: cardCheckControllerCourse.countChecks() > 0
                                              ? CrossFadeState.showFirst
                                              : CrossFadeState.showSecond,
                                          duration: const Duration(milliseconds: 200),
                                          sizeCurve: Curves.fastOutSlowIn,
                                        );
                                      }),
                                ),
                                GradientButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddRoute(
                                            cardCheckController: cardCheckControllerCourse,
                                            callbackFunction: update,
                                            scope: Scope.course,
                                          ),
                                        )
                                    );
                                  },
                                  isEnabled: true,
                                  height: 35,
                                  width: 70,
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(20),
                                  colors: const [Color(0xff6433e8), Color(0xff6325e8)],
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 22,
                                          ),
                                          SizedBox(width: 5),
                                          Text('Add', style: TextStyle(fontWeight: FontWeight.w600))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                AnimatedBuilder(
                                  animation: cardCheckControllerCourse,
                                  builder: (BuildContext context, Widget? child) {
                                    return GradientButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditRoute(
                                                cardCheckController: cardCheckControllerCourse,
                                                callbackFunction: update,
                                                scope: Scope.course,
                                              ),
                                            )
                                        );
                                      },
                                      isEnabled: cardCheckControllerCourse.countChecks() == 1,
                                      height: 35,
                                      width: 70,
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(20),
                                      colors: const [Color(0xff6433e8), Color(0xff6325e8)],
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 17.0),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                size: 18,
                                              ),
                                              SizedBox(width: 5),
                                              Text('Edit', style: TextStyle(fontWeight: FontWeight.w600))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                AnimatedBuilder(
                                  animation: cardCheckControllerCourse,
                                  builder: (BuildContext context, Widget? child) {
                                    return Row(
                                      children: [
                                        GradientButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => DeleteStudentRoute(
                                                    cardCheckController: cardCheckControllerCourse,
                                                    callbackFunction: update,
                                                    scope: Scope.course,
                                                  ),
                                                )
                                            );
                                          },
                                          isEnabled: cardCheckControllerCourse.countChecks() > 0,
                                          height: 35,
                                          width: cardCheckControllerCourse.countChecks() == cardCheckControllerCourse.maxCheck() && cardCheckControllerCourse.countChecks() > 1 ? 80 : 70,
                                          elevation: 5,
                                          borderRadius: BorderRadius.circular(20),
                                          colors: const [Color(0xFFFF0000), Color(0xFFFF2121)],
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.delete_rounded,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      cardCheckControllerCourse.countChecks() == cardCheckControllerCourse.maxCheck() && cardCheckControllerCourse.countChecks() > 1 ?
                                                      'Delete all' : 'Delete',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w600
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: cardCheckControllerCourse.countChecks() == cardCheckControllerCourse.maxCheck() && cardCheckControllerCourse.countChecks() > 1 ? 0 : 10,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 90, top: 15),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                    'v$buildVersion build',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                    ),
                )
            ),
          )
        ]));
  }

  @override
  void initState() {
    super.initState();
    studentRepository.init();
    courseRepository.init();
    coursesGetList();
    studentGetList();
    coursesUpdateFormattedList();
  }

  @override
  void dispose() {
    textControllerCourse.dispose();
    textControllerStudentID.dispose();
    textControllerStudentName.dispose();
    cardCheckControllerStudent.dispose();
    cardCheckControllerCourse.dispose();
    super.dispose();
  }
}
