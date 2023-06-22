import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:ssis/controllers/card_check_controller.dart';
import 'package:ssis/handlers/course_handler.dart';
import 'package:ssis/handlers/student_handler.dart';
import 'package:ssis/misc/scope.dart';
import 'package:ssis/repositories/course_repository.dart';
import 'package:ssis/widgets/gradient_button.dart';
import 'package:ssis/widgets/window_button.dart';

class DeleteStudentRoute extends StatefulWidget {
  final CardCheckController cardCheckController;
  final Function callbackFunction;
  final Scope scope;
  const DeleteStudentRoute({
    Key? key,
    required this.cardCheckController,
    required this.callbackFunction,
    required this.scope
  }) : super(key: key);

  @override
  State<DeleteStudentRoute> createState() => _DeleteStudentRouteState();
}

class _DeleteStudentRouteState extends State<DeleteStudentRoute> {
  CourseRepository courseRepository = CourseRepository();
  CourseHandler courseHandler = CourseHandler();
  StudentHandler studentHandler = StudentHandler();

  bool enablerDeleteButton = true;
  bool enablerCancelButton = true;

  void setDeleteButton(bool toggle) {
    setState(() {
      enablerDeleteButton = toggle;
    });
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
          const SizedBox(height: 120),
          Form(
            child: Material(
              elevation: 8,
              // color: const Color(0xFF2F1176),
              color: Colors.red,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: SizedBox(
                width: 550,
                height: 430,
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
                          'SELECTED ROWS WILL BE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff444444),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            wordSpacing: 5,
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'PERMANENTLY DELETED',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff444444),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            wordSpacing: 5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Divider(color: Colors.white.withOpacity(0.3)),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          color: const Color(0xffFF9999),
                          height: 200,
                          child: ListView.builder(
                            itemCount: widget.cardCheckController.getSubmissionListData().length,
                              itemBuilder: (context, index) {
                              ScrollController sc = ScrollController();
                              var submission = widget.cardCheckController.getSubmissionListData().elementAt(index);
                              return ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title: RawScrollbar(
                                  controller: sc,
                                  child: SingleChildScrollView(
                                    controller: sc,
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20, bottom: 10),
                                      child: Text(
                                        '[ ${submission.toList().join("   |   ")} ]',
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          overflow: TextOverflow.fade,
                                          fontSize: 12,
                                          color: Colors.black,
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              },
                          ),
                        ),
                      ),
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
                            colors: const [Color(0xff444444), Color(0xff333333)],
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
                              setDeleteButton(false);
                              if (widget.scope == Scope.student) {
                                studentHandler.submitDelete(widget.cardCheckController.getSubmissionListData()).then((value) {
                                  if (value) {
                                    setDeleteButton(true);
                                    widget.callbackFunction();
                                    Navigator.pop(context);
                                    print('exiting');
                                  } else {
                                    print('STUCK');
                                  }
                                });
                              } else if (widget.scope == Scope.course) {
                                courseHandler.submitDelete(widget.cardCheckController.getSubmissionListData()).then((value) {
                                  if (value) {
                                    setDeleteButton(true);
                                    widget.callbackFunction();
                                    Navigator.pop(context);
                                    print('exiting');
                                  } else {
                                    print('STUCK');
                                  }
                                });
                              }
                            },
                            isEnabled: enablerDeleteButton,
                            height: 40,
                            width: 140,
                            elevation: 5,
                            borderRadius: BorderRadius.circular(20),
                            colors: const [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                            child: const Center(
                              child: Text(
                                'SUBMIT',
                                style: TextStyle(
                                  color: Color(0xff444444),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
