import 'package:ssis/handlers/file_handler.dart';
import 'package:ssis/repositories/student_repository.dart';

class CourseRepository{
  void init() async{
    FileHandler handler = FileHandler();
    List<List<String>> coursesData = [
      ["CourseCode", "Course"],
    ];
    handler.initData(coursesData, "courses");
    print('Course Service initialized!');
  }
  
  Future<List<List<dynamic>>> getList() async {
    FileHandler handler = FileHandler();
    return await handler.loadCSVFile("courses");
  }

  Future<bool> add(String courseCode, String course) async{
    bool isSuccess = false;
    List<List<dynamic>> dataList = await getList();
    List<List<String>> coursesData = [];
    bool passed = false;
    int x = 0;
    if (dataList.length > 1){
      int index = 0;
      for (final dataItem in dataList){
        String courseSrc = course.toString().trim().toLowerCase();
        String courseCodeSrc = courseCode.toString().trim().toLowerCase();
        String courseDes = dataItem.elementAt(1).toString().trim().toLowerCase();
        String courseCodeDes = dataItem.elementAt(0).toString().trim().toLowerCase();
        if(index > 0){
          if (courseSrc == courseDes){
            if (courseCodeSrc != courseCodeDes) {
              passed = true;
              x = 2;
            }else{
              passed = false;
              x = 100;
              break;
            }
          }else{
            passed = true;
            x = 3;
          }
        }
        index++;
      }
    }else{
      passed = true;
      x = 4;
    }
    if(passed){
      FileHandler handler = FileHandler();
      for (final dataItem in dataList) {
        coursesData.add([
          dataItem.elementAt(0).toString(),
          dataItem.elementAt(1).toString(),
        ]);
      }
      coursesData.add([courseCode.trim(),course.trim()]);
      handler.appendData(coursesData, "courses");
      isSuccess = true;
      print('Appended [$courseCode] $course');
      print(x);
    }else{
      isSuccess = false;
      print('Course already exists.');
      print(x);
    }
    return isSuccess;
  }

  Future<bool> edit(String prevCourseCode, String courseCode, String course) async{
    bool isSuccess = false;
    List<List<dynamic>> dataList = await getList();
    List<List<String>> coursesData = [];
    bool passed = false;
    int index = 0;
    if (dataList.length > 1){
      for (final dataItem in dataList){
        String courseCodeSrc = prevCourseCode;
        String courseCodeDes = dataItem.elementAt(0).toString().trim();
        if(index > 0){
          print('src: $courseCodeSrc, des: $courseCodeDes');
          if (courseCodeSrc == courseCodeDes){
            passed = true;
            break;
          }else{
            passed = false;
          }
        }
        index++;
      }
    }
    if(passed){
      FileHandler handler = FileHandler();
      for (final dataItem in dataList) {
        coursesData.add([
          dataItem.elementAt(0).toString(),
          dataItem.elementAt(1).toString(),
        ]);
      }
      coursesData.insert(index, [courseCode.trim(), course.trim()]);
      coursesData.removeAt(index+1);
      handler.appendData(coursesData, "courses");
      isSuccess = true;
      print('Edited course of code ${courseCode.trim()} to ${course.trim()}');
    }else{
      isSuccess = false;
      print('Unable to edit.');
    }
    return isSuccess;
  }

  Future<bool> delete(List<List<dynamic>> listData) async {
    StudentRepository studentRepository = StudentRepository();
    bool isSuccess = false;
    List<List<dynamic>> dataList = await getList();
    List<List<dynamic>> studentDataList = await studentRepository.getList();
    List<List<String>> coursesData = [];
    List<List<String>> studentsData = [];
    for (final studentData in studentDataList) {
      print('1st Loop: $studentData');
      List<String> replacement = studentData.map((e) => e.toString()).toList();
      if (studentData.first != 'IDNum') {
        print('-   : ${studentData.first != 'IDNum'}');
        for (var listItem in listData) {
          print('2nd Loop: $listItem');
          if(studentData.elementAt(4) == listItem.first) {
            print('--   : ${studentData.elementAt(4)}');
            replacement = [studentData[0].toString(),studentData[1].toString(),studentData[2].toString(),studentData[3].toString(),'NO COURSE'];
            break;
          } else {
            replacement = studentData.map((e) => e.toString()).toList();
            // else if (studentData.elementAt(4) != 'NO COURSE') {
          }
        }
      }
      print(replacement);
      studentsData.add(replacement);
    }
    for (final listItem in listData) {
      dataList.removeWhere((element) => element.first == listItem.first);
    }
    FileHandler handler = FileHandler();
    for (final dataItem in dataList) {
      coursesData.add([
        dataItem.elementAt(0).toString(),
        dataItem.elementAt(1).toString(),
      ]);
    }
    handler.appendData(coursesData, "courses");
    handler.appendData(studentsData, "students");
    isSuccess = true;
    return isSuccess;
  }
}