import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ssis/controllers/card_check_controller.dart';
import 'package:ssis/handlers/course_handler.dart';
import 'package:ssis/handlers/student_handler.dart';
import 'package:ssis/misc/scope.dart';
import 'package:ssis/repositories/course_repository.dart';
import 'package:ssis/widgets/gradient_button.dart';
import 'package:ssis/widgets/window_button.dart';

class AddRoute extends StatefulWidget {
  final CardCheckController cardCheckController;
  final Function callbackFunction;
  final Scope scope;
  const AddRoute({
    Key? key,
    required this.cardCheckController,
    required this.callbackFunction,
    required this.scope,
  }) : super(key: key);

  @override
  State<AddRoute> createState() => _AddRouteState();
}

class _AddRouteState extends State<AddRoute> {
  final _addFormKey = GlobalKey<FormState>();
  CourseRepository courseRepository = CourseRepository();
  CourseHandler courseHandler = CourseHandler();
  StudentHandler studentHandler = StudentHandler();
  TextEditingController textControllerStudentID = TextEditingController();
  TextEditingController textControllerStudentFullName = TextEditingController();
  TextEditingController textControllerStudentName = TextEditingController();
  TextEditingController textControllerCourse = TextEditingController();
  TextEditingController textControllerCourseCode = TextEditingController();

  late List<String> listFormattedCourses = [];
  late List<String> listFormattedCourseCodes = [];

  bool enablerCancelButton = true;
  bool enablerEditButton = true;


  // Future<void> coursesUpdateFormattedList() async {
  //   Map<String,String> rawMap = await courseHandler.formattedCoursesMap(courseRepository.getList());
  //   setState(() {
  //     listFormattedCourseCodes = rawMap.keys.toList();
  //     listFormattedCourses = rawMap.values.toList();
  //   });
  //   print('listFormattedCourses: $listFormattedCourses');
  // }

  void clearStudentPanel() {
    setState(() {
      studentHandler.addGender(null);
      studentHandler.addYearLevel(null);
      studentHandler.addCourseCode(null);
      textControllerStudentID.clear();
      textControllerStudentName.clear();
    });
  }

  void setEditButton(bool toggle) {
    setState(() {
      enablerEditButton = toggle;
    });
  }

  @override
  void initState() {
    // coursesUpdateFormattedList();
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
          SizedBox(height: widget.scope == Scope.student ? 60 : widget.scope == Scope.course ? 140 : 0),
          Form(
            key: _addFormKey,
            child: Material(
              elevation: 8,
              color: const Color(0xFF2F1176),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: SizedBox(
                width: 550,
                height: widget.scope == Scope.student ? 530 : widget.scope == Scope.course ? 360 : 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      widget.scope == Scope.student
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 30),
                          const Center(
                            child: Text(
                              'ADD STUDENT DETAILS',
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
                          const SizedBox(height: 0),
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
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(height: 0),
                                  errorBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      )),
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
                          Flexible(
                            fit: FlexFit.loose,
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                onFieldSubmitted: (value) {
                                  studentHandler.addFullName(value);
                                },
                                onChanged: (value) {
                                  studentHandler.addFullName(value);
                                },
                                controller: textControllerStudentFullName,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(height: 0),
                                  errorBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      )),
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
                                  hintText: 'Full Name',
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
                                  'GENDER :',
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
                                child: DropdownButtonFormField2(
                                  value: studentHandler.getGender(),
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(height: 0),
                                    errorBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1,
                                        )),
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
                                      'Gender',
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
                                  items: ['Male', 'Female', 'Non-Binary']
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
                                      return '';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    studentHandler.addGender(value.toString());
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
                                ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: SizedBox(
                                        height: 30,
                                        child: Text(
                                          'COURSE CODE:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: 40,
                                        child: DropdownButtonFormField2(
                                          value: studentHandler.getCourseCode(),
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                            errorStyle: const TextStyle(height: 0),
                                            errorBorder: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 1,
                                                )),
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
                                              'Course Code',
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
                                          items: listFormattedCourseCodes
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
                                              return '';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            studentHandler.addCourseCode(value.toString());
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
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15),
                              SizedBox(
                                width: 170,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: SizedBox(
                                        height: 30,
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
                                    SizedBox(
                                      height: 40,
                                      child: DropdownButtonFormField2(
                                        value: studentHandler.getYearLevel(),
                                        decoration: InputDecoration(
                                          errorStyle: const TextStyle(height: 0),
                                          errorBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1,
                                              )),
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
                                            return '';
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
                          const SizedBox(height: 10),
                          Divider(color: Colors.white.withOpacity(0.3)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GradientButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                isEnabled: enablerCancelButton,
                                height: 40,
                                width: 90,
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                colors: const [Color(0xff6433e8), Color(0xff6325e8)],
                                child: const Center(
                                  child: Text(
                                    'BACK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GradientButton(
                                onPressed: () {
                                  if (_addFormKey.currentState!.validate()) {
                                    setEditButton(false);
                                    studentHandler.submitAdd().then((value) {
                                      if(value){
                                        setEditButton(true);
                                        clearStudentPanel();
                                        widget.callbackFunction();
                                        Navigator.pop(context);
                                      }
                                    });
                                  }
                                },
                                isEnabled: enablerEditButton,
                                height: 40,
                                width: 140,
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                colors: const [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                                child: const Center(
                                  child: Text(
                                    'SUBMIT',
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
                      ) :
                      widget.scope == Scope.course
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 30),
                          const Center(
                            child: Text(
                              'ADD COURSE DETAILS',
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
                          const SizedBox(height: 0),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              height: 30,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'COURSE CODE :',
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
                                  courseHandler.addCourseCode(value);
                                },
                                onChanged: (value) {
                                  courseHandler.addCourseCode(value);
                                },
                                controller: textControllerCourseCode,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(height: 0),
                                  errorBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      )),
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
                                  hintText: 'Course Code',
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
                          Flexible(
                            fit: FlexFit.loose,
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                onFieldSubmitted: (value) {
                                  courseHandler.addCourse(value);
                                },
                                onChanged: (value) {
                                  courseHandler.addCourse(value);
                                },
                                controller: textControllerCourse,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(height: 0),
                                  errorBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      )),
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
                          ),
                          const SizedBox(height: 10),
                          Divider(color: Colors.white.withOpacity(0.3)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GradientButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                isEnabled: enablerCancelButton,
                                height: 40,
                                width: 90,
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                colors: const [Color(0xff6433e8), Color(0xff6325e8)],
                                child: const Center(
                                  child: Text(
                                    'BACK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GradientButton(
                                onPressed: () {
                                  if (_addFormKey.currentState!.validate()) {
                                    setEditButton(false);
                                    courseHandler.submitAdd().then((value) {
                                      if(value){
                                        setEditButton(true);
                                        clearStudentPanel();
                                        widget.callbackFunction();
                                        Navigator.pop(context);
                                      }else{
                                        print('STUCK');
                                      }
                                    });
                                  }
                                },
                                isEnabled: enablerEditButton,
                                height: 40,
                                width: 140,
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                colors: const [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                                child: const Center(
                                  child: Text(
                                    'SUBMIT',
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
                      )
                          : Container(),
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
