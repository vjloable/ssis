import 'package:ssis/handlers/file_handler.dart';

class StudentRepository{
  void init() async{
    FileHandler handler = FileHandler();
    List<List<String>> studentsData = [
      ["IDNum", "FirstN", "MI", "LastN", "Age", "Sex", "Courses", "Year Level"],
      // ["2021-1910", "Vince Japheth", "F.", "Loable", "21", "Male", "BS Computer Science", "2nd Year"],
    ];
    handler.initData(studentsData, "students");
  }

  Future<List<List<dynamic>>> getList() async {
    FileHandler handler = FileHandler();
    return handler.loadCSVFile("students");
  }

  Future<bool> add(String idNum, String firstName, String mi, String lastName, String age, String sex, String course, String yearLevel) async{
    bool isSuccess = false;
    List<List<dynamic>> dataList = await getList();
    List<List<String>> studentsData = [];
    bool passed = false;
    if (dataList.length > 1){
      int index = 0;
      for (final dataItem in dataList){
        String idNumSrc = idNum.toString().trim();
        String idNumDes = dataItem.elementAt(0).toString().trim();
        if(index > 0){
          if (idNumSrc == idNumDes){
            passed = false;
            break;
          }else{
            passed = true;
          }
        }
        index++;
      }
    }else{
      passed = true;
    }
    if(passed){
      FileHandler handler = FileHandler();
      for (final dataItem in dataList) {
        studentsData.add([
          dataItem.elementAt(0).toString(),
          dataItem.elementAt(1).toString(),
          dataItem.elementAt(2).toString(),
          dataItem.elementAt(3).toString(),
          dataItem.elementAt(4).toString(),
          dataItem.elementAt(5).toString(),
          dataItem.elementAt(6).toString(),
          dataItem.elementAt(7).toString(),
        ]);
      }
      studentsData.add([idNum.trim(), firstName.trim(), mi.trim(), lastName.trim(), age.trim(), sex.trim(), course.trim(), '${yearLevel.trim()} Year']);
      handler.appendData(studentsData, "students");
      isSuccess = true;
      print('Appended student of id ${idNum.trim()}');
    }else{
      isSuccess = false;
      print('Student already exists.');
    }
    return isSuccess;
  }

  Future<bool> edit(String prevID, String idNum, String firstName, String mi, String lastName, String age, String sex, String course, String yearLevel) async{
    bool isSuccess = false;
    List<List<dynamic>> dataList = await getList();
    List<List<String>> studentsData = [];
    bool passed = false;
    int index = 0;
    if (dataList.length > 1){
      for (final dataItem in dataList){
        String idNumSrc = prevID;
        String idNumDes = dataItem.elementAt(0).toString().trim();
        if(index > 0){
          print('src: $idNumSrc, des: $idNumDes');
          if (idNumSrc == idNumDes){
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
        studentsData.add([
          dataItem.elementAt(0).toString(),
          dataItem.elementAt(1).toString(),
          dataItem.elementAt(2).toString(),
          dataItem.elementAt(3).toString(),
          dataItem.elementAt(4).toString(),
          dataItem.elementAt(5).toString(),
          dataItem.elementAt(6).toString(),
          dataItem.elementAt(7).toString(),
        ]);
      }
      studentsData.insert(index, [idNum.trim(), firstName.trim(), mi.trim(), lastName.trim(), age.trim(), sex.trim(), course.trim(), '${yearLevel.trim()} Year']);
      studentsData.removeAt(index+1);
      handler.appendData(studentsData, "students");
      isSuccess = true;
      print('Edited student of id ${prevID.trim()} to ${idNum.trim()}');
    }else{
      isSuccess = false;
      print('Unable to edit.');
    }
    return isSuccess;
  }

  Future<bool> delete(List<List<dynamic>> listData) async {
    bool isSuccess = false;
    List<List<dynamic>> dataList = await getList();
    List<List<String>> studentsData = [];
    for (final listItem in listData) {
      dataList.removeWhere((element) => element.first == listItem.first);
    }
    FileHandler handler = FileHandler();
    for (final dataItem in dataList) {
      studentsData.add([
        dataItem.elementAt(0).toString(),
        dataItem.elementAt(1).toString(),
        dataItem.elementAt(2).toString(),
        dataItem.elementAt(3).toString(),
        dataItem.elementAt(4).toString(),
        dataItem.elementAt(5).toString(),
        dataItem.elementAt(6).toString(),
        dataItem.elementAt(7).toString(),
      ]);
    }
    handler.appendData(studentsData, "students");
    isSuccess = true;
    return isSuccess;
  }
}