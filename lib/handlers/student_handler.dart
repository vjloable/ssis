import 'package:ssis/repositories/student_repository.dart';

class StudentHandler{
  String? _validatorIDNum;
  String? _validatorFName;
  String? _validatorMInitial;
  String? _validatorLName;
  String? _validatorAge;
  String? _validatorSex;
  String? _validatorCourse;
  String? _validatorYearLevel;

  String? getAge(){
    return _validatorAge;
  }

  String? getSex(){
    return _validatorSex;
  }

  String? getCourse(){
    return _validatorCourse;
  }

  String? getYearLevel(){
    return _validatorYearLevel;
  }

  void addIDNum(String? idNum){
    _validatorIDNum = idNum;
  }

  void addFName(String? firstName){
    _validatorFName = firstName;
  }

  void addMInitial(String? middleInitial){
    _validatorMInitial = middleInitial;
  }

  void addLName(String? lastName){
    _validatorLName = lastName;
  }

  void addAge(String? age){
    _validatorAge = age;
  }

  void addSex(String? sex){
    _validatorSex = sex;
  }

  void addCourse(String? course){
    _validatorCourse = course;
  }

  void addYearLevel(String? yearLevel){
    _validatorYearLevel = yearLevel;
  }

  void submitAdd(){
    StudentRepository studentRepository = StudentRepository();
    if(_validatorIDNum != null && _validatorFName != null && _validatorMInitial != null && _validatorLName != null && _validatorAge != null && _validatorSex != null && _validatorCourse != null && _validatorYearLevel != null){
      if(_validatorIDNum.toString().trim() != '' && _validatorFName.toString().trim() != '' && _validatorMInitial.toString().trim() != '' && _validatorLName.toString().trim() != ''){
        studentRepository.add(
          _validatorIDNum.toString(),
          _validatorFName.toString(),
          _validatorMInitial.toString(),
          _validatorLName.toString(),
          _validatorAge.toString(),
          _validatorSex.toString(),
          _validatorCourse.toString(),
          _validatorYearLevel.toString(),
        );
      }else{
        print("Empty fields");
      }
    }else{
      print("Null values found");
    }
  }

  Future<bool> submitEdit(String prevID) async {
    bool isSuccess = false;
    StudentRepository studentRepository = StudentRepository();
    if(_validatorIDNum != null && _validatorFName != null && _validatorMInitial != null && _validatorLName != null && _validatorAge != null && _validatorSex != null && _validatorCourse != null && _validatorYearLevel != null){
      if(_validatorIDNum.toString().trim() != '' && _validatorFName.toString().trim() != '' && _validatorMInitial.toString().trim() != '' && _validatorLName.toString().trim() != ''){
        isSuccess = await studentRepository.edit(
          prevID.trim(),
          _validatorIDNum.toString(),
          _validatorFName.toString(),
          _validatorMInitial.toString(),
          _validatorLName.toString(),
          _validatorAge.toString(),
          _validatorSex.toString(),
          _validatorCourse.toString(),
          _validatorYearLevel.toString(),
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

  String formatterFullName(List<dynamic> data, String header){
    String returnString = header;
    if(data.elementAt(1) == '-'){
      returnString = '-';
    }else if(data.elementAt(1) == 'FirstN'){
      returnString = header;
    }else{
      returnString = '${data.elementAt(1).toString().trim()} ${data.elementAt(2).toString().trim()} ${data.elementAt(3).toString().trim()}';
    }
    return returnString;
  }

  String formatterIDNum(List<dynamic> data, String header){
    List<String> comparisonList = ["IDNum", "FirstN", "MI", "LastN", "Age", "Sex", "Courses", "Year Level"];
    int index = 0;
    String returnString = header;
    if(data.elementAt(index) != comparisonList[index]){
      returnString = data.elementAt(index).toString().trim();
    }
    return returnString;
  }

  String formatterAge(List<dynamic> data, String header){
    List<String> comparisonList = ["IDNum", "FirstN", "MI", "LastN", "Age", "Sex", "Courses", "Year Level"];
    int index = 4;
    String returnString = header;
    if(data.elementAt(index) != comparisonList[index]){
      returnString = data.elementAt(index).toString().trim();
    }
    return returnString;
  }

  String formatterSex(List<dynamic> data, String header){
    List<String> comparisonList = ["IDNum", "FirstN", "MI", "LastN", "Age", "Sex", "Courses", "Year Level"];
    int index = 5;
    String returnString = header;
    if(data.elementAt(index) != comparisonList[index]){
      returnString = data.elementAt(index).toString().trim();
    }
    return returnString;
  }

  String formatterCourse(List<dynamic> data, String header){
    List<String> comparisonList = ["IDNum", "FirstN", "MI", "LastN", "Age", "Sex", "Courses", "Year Level"];
    int index = 6;
    String returnString = header;
    if(data.elementAt(index) != comparisonList[index]){
      returnString = data.elementAt(index).toString().trim();
    }
    return returnString;
  }

  String formatterYearLevel(List<dynamic> data, String header){
    List<String> comparisonList = ["IDNum", "FirstN", "MI", "LastN", "Age", "Sex", "Courses", "Year Level"];
    int index = 7;
    String returnString = header;
    if(data.elementAt(index) != comparisonList[index]){
      returnString = data.elementAt(index).toString().trim();
    }
    return returnString;
  }

}