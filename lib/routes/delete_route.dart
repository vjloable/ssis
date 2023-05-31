import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:ssis/controllers/card_check_controller.dart';
import 'package:ssis/handlers/course_handler.dart';
import 'package:ssis/handlers/student_handler.dart';
import 'package:ssis/repositories/course_repository.dart';
import 'package:ssis/widgets/gradient_button.dart';
import 'package:ssis/widgets/window_button.dart';

class DeleteRoute extends StatefulWidget {
  final CardCheckController cardCheckController;
  final Function callbackFunction;
  const DeleteRoute({
    Key? key,
    required this.cardCheckController,
    required this.callbackFunction
  }) : super(key: key);

  @override
  State<DeleteRoute> createState() => _DeleteRouteState();
}

class _DeleteRouteState extends State<DeleteRoute> {
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
              color: const Color(0xFF2F1176),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: SizedBox(
                width: 600,
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
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
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
                            color: Colors.red,
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
                          color: Colors.red,
                          height: 200,
                          child: ListView.builder(
                            itemCount: widget.cardCheckController.getSubmissionListData().length,
                              itemBuilder: (context, index) {
                              ScrollController sc = ScrollController();
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
                                        widget.cardCheckController.getSubmissionListData().elementAt(index).join('   |  '),
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          overflow: TextOverflow.fade,
                                          fontSize: 12,
                                          color: Colors.white,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientButton(
                            onPressed: () {
                              setDeleteButton(false);
                              studentHandler.submitDelete(widget.cardCheckController.getSubmissionListData()).then((value) {
                                if(value){
                                  setDeleteButton(true);
                                  widget.callbackFunction();
                                  Navigator.pop(context);
                                  print('exiting');
                                }else{
                                  print('STUCK');
                                }
                              });
                            },
                            isEnabled: enablerDeleteButton,
                            height: 40,
                            width: 130,
                            elevation: 5,
                            borderRadius: BorderRadius.circular(20),
                            colors: const [Color(0xFFFF0000), Color(0xFFFF2121)],
                            child: const Center(
                              child: Text(
                                'DELETE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 35),
                          GradientButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            isEnabled: enablerCancelButton,
                            height: 40,
                            width: 130,
                            elevation: 5,
                            borderRadius: BorderRadius.circular(20),
                            colors: const [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                            child: const Center(
                              child: Text(
                                'CANCEL',
                                style: TextStyle(
                                  color: Color(0xFFFF0000),
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
