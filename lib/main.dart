import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:ssis/elements/parent_container.dart';
import 'package:ssis/misc/colors.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final window = appWindow;
    const initialSize = Size(1060, 575);
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