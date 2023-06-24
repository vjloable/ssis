import 'dart:async';

import 'package:ssis/models/student_model.dart';
import 'package:ssis/repositories/student_repository.dart';

class StudentHandler{
  String? _validatorIDNum;
  String? _validatorFullName;
  String? _validatorGender;
  String? _validatorCourseCode;
  String? _validatorYearLevel;
  List<String> comparisonList = ["IDNum", "FullN", "Gender", "Year Level",  "CourseCode"];

  String? getStudentId() {
    return _validatorIDNum;
  }

  String? getGender() {
    return _validatorGender;
  }

  String? getCourseCode() {
    return _validatorCourseCode.toString().trim() == '' ? null : _validatorCourseCode;
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
    print('StudentHandler: $isSuccess');
    return isSuccess;
  }

  Future<bool> submitEdit(String prevID) async {
    bool isSuccess = false;
    StudentRepository studentRepository = StudentRepository();
    if(_validatorIDNum != null && _validatorFullName != null && _validatorGender != null && _validatorCourseCode != null && _validatorYearLevel != null){
      if(_validatorIDNum.toString().trim() != '' && _validatorFullName.toString().trim() != ''){
        StudentModel newStudent = StudentModel(studentId: _validatorIDNum.toString(), name: _validatorFullName.toString(), gender: _validatorGender.toString(), yearLevel: _validatorYearLevel.toString(), courseCode: _validatorCourseCode.toString());
        isSuccess = await studentRepository.update(prevID, newStudent);
      }else{
        isSuccess = false;
        print("Empty fields");
      }
    }else{
      isSuccess = false;
      print("Null values found");
    }
    print('sh: $isSuccess');
    return isSuccess;
  }

  Future<bool> submitDelete(List<dynamic> listData) async {
    bool isSuccess = false;
    StudentRepository studentRepository = StudentRepository();
    List<StudentModel> listCourses = listData.map((e) => e as StudentModel).toList();
    isSuccess = await studentRepository.delete(listCourses);
    return isSuccess;
  }
}