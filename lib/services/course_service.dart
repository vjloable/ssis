import 'package:ssis/handlers/file_handler.dart';

class CourseService{
  void init() async{
    FileHandler handler = FileHandler();
    List<List<String>> coursesData = [
      ["BachType", "Course", "College"],
      // ["Arts", "Psychology", "CASS"],
    ];
    handler.initCSVFile(coursesData, "courses");
    print('Course Service initialized!');
  }
  
  Future<List<List<dynamic>>> getList() async{
    FileHandler handler = FileHandler();
    return  handler.loadCSVFile("courses");
  }


  void append() async{
    FileHandler handler = FileHandler();
    List<List<String>> coursesData = [
      ["BachType", "Course", "College"],
    ];
    handler.initCSVFile(coursesData, "courses");
  }
}