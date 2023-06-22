import 'package:ssis/repositories/course_repository.dart';
import 'package:ssis/models/course_model.dart';

class CourseHandler{
  String? _validatorCourseCode;
  String? _validatorCourse;
  List<String> comparisonList = ['CourseCode','Course'];

  String? getCourseCode(){
    return _validatorCourseCode;
  }

  void addCourseCode(String? courseCode){
    _validatorCourseCode = courseCode;
  }

  void addCourse(String? course){
    _validatorCourse = course;
  }

  Future<bool> submitAdd() async {
    bool isSuccess = true;
    CourseRepository courseRepository = CourseRepository();
    if(_validatorCourseCode != null && _validatorCourse != null){
      if(_validatorCourse.toString().trim() != ''){
        isSuccess = await courseRepository.add(_validatorCourseCode.toString(), _validatorCourse.toString());
      }else{
        isSuccess = false;
      }
    }else{
      isSuccess = false;
    }
    return isSuccess;
  }

  Future<bool> submitEdit(String prevCourseCode) async {
    bool isSuccess = false;
    CourseRepository courseRepository = CourseRepository();
    if(_validatorCourseCode != null && _validatorCourse != null){
      if(_validatorCourseCode.toString().trim() != '' && _validatorCourse.toString().trim() != ''){
        CourseModel newCourse = CourseModel(courseCode: _validatorCourseCode.toString().trim(), course: _validatorCourse.toString().trim());
        isSuccess = await courseRepository.update(prevCourseCode, newCourse);
      }else{
        isSuccess = false;
      }
    }else{
      isSuccess = false;
    }
    return isSuccess;
  }

  Future<bool> submitDelete(List<dynamic> listData) async {
    bool isSuccess = false;
    CourseRepository courseRepository = CourseRepository();
    List<CourseModel> listCourses = listData.map((e) => e as CourseModel).toList();
    isSuccess = await courseRepository.delete(listCourses);
    return isSuccess;
  }

  // Future<bool> submitEdit(String prevCourseCode) async {
  //   bool isSuccess = false;
  //   CourseRepository courseRepository = CourseRepository();
  //   if(_validatorCourseCode != null && _validatorCourse != null){
  //     if(_validatorCourseCode.toString().trim() != '' && _validatorCourse.toString().trim() != ''){
  //       isSuccess = await courseRepository.edit(
  //           prevCourseCode.trim(),
  //           _validatorCourseCode.toString(),
  //           _validatorCourse.toString()
  //       );
  //     }else{
  //       isSuccess = false;
  //     }
  //   }else{
  //     isSuccess = false;
  //   }
  //   return isSuccess;
  // }

  // String formatter(List<dynamic> data, String header, int index){
  //   String returnString = header;
  //   if(data.elementAt(index) != comparisonList[index]){
  //     returnString = data.elementAt(index).toString().trim();
  //   }
  //   return returnString;
  // }

  Future<List<String>> formattedCoursesMap(List<CourseModel> listCourses) async {
    List<String> formattedListCourses = [];
    if(listCourses.length > 1){
      for(var i = 1 ; i < listCourses.length; i++) {
        formattedListCourses.add(listCourses[i].courseCode);
      }
    }
    return formattedListCourses;
  }

  // Future<Map<String, String>> formattedCoursesMapInverted(Future<List<List<dynamic>>> futureList) async {
  //   List<List<dynamic>> rawList = await futureList;
  //   Map<String, String> filteredMap = {};
  //   if(rawList.length > 1){
  //     for(var i = 1 ; i < rawList.length; i++) {
  //       filteredMap[rawList.elementAt(i).elementAt(1)] = rawList.elementAt(i).elementAt(0);
  //     }
  //   }else{
  //     filteredMap = {};
  //   }
  //   return filteredMap;
  // }
}