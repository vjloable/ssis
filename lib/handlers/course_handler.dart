import 'package:ssis/repositories/course_repository.dart';

class CourseHandler{
  String? _validatorBachType;
  String? _validatorCourse;

  String? getBachType(){
    return _validatorBachType;
  }

  void addBachType(String? bachType){
    _validatorBachType = bachType;
  }

  void addCourse(String? course){
    _validatorCourse = course;
  }

  void submit(){
    CourseRepository courseRepository = CourseRepository();
    if(_validatorBachType != null && _validatorCourse != null){
      if(_validatorCourse.toString().trim() != ''){
        courseRepository.add(_validatorBachType.toString(), _validatorCourse.toString());
      }else{
        print("Empty fields");
      }
    }else{
      print("Null values found");
    }
  }

  String formatter(List<dynamic> data, String header){
    String returnString = header;
    if(data.elementAt(1) == '-'){
      returnString = '-';
    }else if(data.elementAt(1) == 'Course'){
      returnString = header;
    }else{
      returnString = data.elementAt(0) == 'Arts'? 'BA' : 'BS';
      returnString += ' ${data.elementAt(1)}';
    }
    return returnString;
  }

  Future<List<String>> formattedCoursesList(Future<List<List<dynamic>>> futureList) async {
    List<List<dynamic>> rawList = await futureList;
    List<String> filteredList = [];
    if(rawList.length > 1){
      for (var row in rawList) {
        if(row.elementAt(0) != "BachType") {
          filteredList.add("B${row.elementAt(0).toString().substring(0,1)} ${row.elementAt(1).toString()}");
        }
      }
    }else{
      filteredList = [];
    }
    return filteredList.toSet().toList();
  }

}