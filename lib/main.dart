import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:ssis/misc/colors.dart';
import 'package:ssis/routes/parent_route.dart';
import 'package:ssis/services/database_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  await DatabaseService().open();
  runApp(const MyApp());
  doWhenWindowReady(() {
    final window = appWindow;
    const initialSize = Size(1260, 675);
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
          child: const ParentRoute(),
        ),
      ),
    );
  }
}