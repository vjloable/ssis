import 'dart:async';

import 'package:ssis/repositories/student_repository.dart';

class StudentHandler{
  String? _validatorIDNum;
  String? _validatorFullName;
  String? _validatorGender;
  String? _validatorCourseCode;
  String? _validatorYearLevel;
  List<String> comparisonList = ["IDNum", "FullN", "Gender", "Year Level",  "CourseCode"];


  String? getGender() {
    return _validatorGender;
  }

  String? getCourseCode() {
    return _validatorCourseCode;
  }

  String? getYearLevel() {
    return _validatorYearLevel;
  }

  void addIDNum(String? idNum) {
    print(idNum);
    _validatorIDNum = idNum;
  }

  void addFullName(String? fullName) {
    print(fullName);
    _validatorFullName = fullName;
  }

  void addGender(String? gender) {
    print(gender);
    _validatorGender = gender;
  }

  void addCourseCode(String? courseCode){
    print(courseCode);
    _validatorCourseCode = courseCode;
  }

  void addYearLevel(String? yearLevel) {
    print(yearLevel);
    _validatorYearLevel = yearLevel;
  }

  Future<bool> submitAdd() async {
    bool isSuccess = false;
    StudentRepository studentRepository = StudentRepository();
    print('_validatorIDNum != null && _validatorFullName != null = ${_validatorIDNum != null && _validatorFullName != null}');
    print('_validatorGender != null && _validatorCourseCode != null = ${_validatorGender != null && _validatorCourseCode != null}');
    print(_validatorGender);
    print('_validatorYearLevel != null = ${_validatorYearLevel != null}');
    if(_validatorIDNum != null && _validatorFullName != null && _validatorGender != null && _validatorCourseCode != null && _validatorYearLevel != null){
      if(_validatorIDNum.toString().trim() != '' && _validatorFullName.toString().trim() != ''){
        isSuccess = await studentRepository.add(
          _validatorIDNum.toString(),
          _validatorFullName.toString(),
          _validatorGender.toString(),
          _validatorYearLevel.toString(),
          _validatorCourseCode.toString(),
        );
      }else{
        isSuccess = false;
        print("Empty fields");
      }
    }else{
      isSuccess = false;
      print("Null values found");
    }
    return isSuccess;
  }

  Future<bool> submitEdit(String prevID) async {
    bool isSuccess = false;
    StudentRepository studentRepository = StudentRepository();
    if(_validatorIDNum != null && _validatorGender != null && _validatorCourseCode != null && _validatorYearLevel != null){
      if(_validatorIDNum.toString().trim() != ''){
        isSuccess = await studentRepository.edit(
          prevID.trim(),
          _validatorIDNum.toString(),
          _validatorFullName.toString(),
          _validatorGender.toString(),
          _validatorYearLevel.toString(),
          _validatorCourseCode.toString(),
        );
      }else{
        isSuccess = false;
        print("Empty fields");
      }
    }else{
      isSuccess = false;
      print("Null values found");
    }
    return isSuccess;
  }

  Future<bool> submitDelete(List<List<dynamic>> listData) async {
    bool isSuccess = false;
    StudentRepository studentRepository = StudentRepository();
    isSuccess = await studentRepository.delete(listData);
    return isSuccess;
  }

  String formatter(List<dynamic> data, String header, int index){
    String returnString = header;
    if(data.elementAt(index) != comparisonList[index]){
      returnString = data.elementAt(index).toString().trim();
    }
    return returnString;
  }
}