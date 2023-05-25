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

  void add(String idNum, String firstName, String mi, String lastName, String age, String sex, String course, String yearLevel) async{
    List<List<dynamic>> dataList = await getList();
    print(dataList);
    // List<dynamic> dataHead = dataList.first;
    List<List<String>> studentsData = [];
    bool passed = false;
    int x = 0;
    if (dataList.length > 1){
      int index = 0;
      for (final dataItem in dataList){
        print('index: $index');
        String idNumSrc = idNum.toString().trim();
        String idNumDes = dataItem.elementAt(0).toString().trim();
        if(index > 0){
          if (idNumSrc == idNumDes){
            passed = false;
            x = 100;
            break;
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
      print('Appended student of id ${idNum.trim()}');
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
      print('Appended student of id ${idNum.trim()}');
      print(x);
    }else{
      print('Student already exists.');
      print(x);
    }
  }

}