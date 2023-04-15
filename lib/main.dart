import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:ssis/misc/colors.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final window = appWindow;
    const initialSize = Size(860, 575);
    window.minSize = initialSize;
    window.maxSize = initialSize;
    window.size = initialSize;
    window.alignment = Alignment.center;
    window.title = "Simple Student Information System";
    window.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WindowBorder(
          color: CustomColors().borderColor,
          width: 0,
          child: const ParentContainer(),
        ),
      ),
    );
  }
}

class ParentContainer extends StatelessWidget {
  const ParentContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CustomColors().backgroundStartColor,
                CustomColors().backgroundEndColor
              ],
              stops: const [0.0, 1.0]),
        ),
        child: Column(children: [
          Stack(
                children: [
                  Container(
                    width: 860,
                    height: 30,
                    color: const Color(0x9D221C49),
                  ),
                  WindowTitleBarBox(
                    child: Row(children: [
                        Expanded(
                          child: SizedBox(
                              width: 20,
                              child: MoveWindow()
                          ),
                        ),
                        const SizedBox(
                            width: 100,
                            height: 30,
                            child: WindowButtons()
                        )
                      ]),
                  ),
                ],
              ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.all(20)),
              Material(
                elevation: 8,
                // color: Colors.white,
                color: const Color(0xFF2F1176),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: SizedBox(
                  height: 60,
                  width: 650,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 45,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.0),
                                    gapPadding: 0
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'First Name',
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            height: 45,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50.0),
                                      gapPadding: 0
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'First Name',
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            height: 45,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50.0),
                                      gapPadding: 0
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'First Name',
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              const Material(
                elevation: 8,
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3),
                    topRight: Radius.circular(3),
                    bottomLeft: Radius.circular(3),
                    bottomRight: Radius.circular(3),
                ),
                child: SizedBox(
                  height: 390,
                  width: 650,
                ),
              ),
            ],
          )
        ])
    );
  }
}

final buttonColors = WindowButtonColors(
    mouseOver: const Color(0xFF5145BE),
    mouseDown: const Color(0xFF483EAB),
    iconNormal: const Color(0xAAAAAAFF),
    iconMouseOver: const Color(0xFFFFFFFF),
);

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xAAAAAAFF),
    iconMouseOver: const Color(0xFFFFFFFF)
);

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  WindowButtonsState createState() => WindowButtonsState();
}

class WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}