// import 'package:ssis/handlers/file_handler.dart';
import 'package:ssis/misc/scope.dart';
import 'package:ssis/models/course_model.dart';
import 'package:ssis/services/database_service.dart';

class CourseRepository{
  // void init() async{
  //   FileHandler handler = FileHandler();
  //   List<List<String>> coursesData = [
  //     ["CourseCode", "Course"],
  //   ];
  //   handler.initData(coursesData, "courses");
  //   print('Course Service initialized!');
  // }
  
  Future<List<CourseModel>> getList() async {
    DatabaseService dbService = DatabaseService();
    List<Map<String, Object?>> maplistCourses = await dbService.query('courses');
    List<CourseModel> listCourseModel = [];
    listCourseModel.add(CourseModel(courseCode: 'COURSE CODE', course: 'AVAILABLE COURSE'));
    if (maplistCourses.isEmpty) {
      listCourseModel.add(CourseModel(courseCode: '-', course: '-'));
    } else {
      for (Map<String, Object?> mapCourses in maplistCourses) {
        listCourseModel.add(CourseModel.fromMap(mapCourses));
      }
    }
    return listCourseModel;
  }

  Future<bool> add(String courseCode, String course) async {
    bool isSuccess = false;
    DatabaseService dbService = DatabaseService();
    CourseModel submission = CourseModel(courseCode: courseCode.trim(), course: course.trim());
    isSuccess = await dbService.insert(submission, Scope.course);
    return isSuccess;
  }

  Future<bool> update(String prevCourseCode, CourseModel newCourse) async {
    bool isSuccess = false;
    DatabaseService dbService = DatabaseService();
    isSuccess = await dbService.update(prevCourseCode, newCourse, Scope.course);
    return isSuccess;
  }

  Future<bool> delete(List<CourseModel> listData) async {
    bool isSuccess = false;
    DatabaseService dbService = DatabaseService();
    for (final listItem in listData) {
      isSuccess = await dbService.delete(listItem.courseCode, Scope.course);
    }
    return isSuccess;
  }

  /*Future<bool> add(String courseCode, String course) async{
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
  }*/

  /*Future<bool> edit(String prevCourseCode, String courseCode, String course) async{
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
  }*/

  /*Future<bool> delete(List<List<dynamic>> listData) async {
    bool isSuccess = false;
    List<List<dynamic>> dataList = await getList();
    List<List<String>> coursesData = [];
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
    isSuccess = true;
    return isSuccess;
  }*/
}