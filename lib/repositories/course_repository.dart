import 'package:ssis/handlers/file_handler.dart';

class CourseRepository{
  void init() async{
    FileHandler handler = FileHandler();
    List<List<String>> coursesData = [
      ["BachType", "Course"],
      // ["Science", "Computer Science"],
    ];
    handler.initData(coursesData, "courses");
    print('Course Service initialized!');
  }
  
  Future<List<List<dynamic>>> getList() async {
    FileHandler handler = FileHandler();
    return handler.loadCSVFile("courses");
  }

  void add(String batchType, String course) async{
    List<List<dynamic>> dataList = await getList();
    // List<dynamic> dataHead = dataList.first;
    List<List<String>> coursesData = [];
    bool passed = false;
    int x = 0;
    if (dataList.length > 1){
      int index = 0;
      for (final dataItem in dataList){
        String courseSrc = course.toString().trim().toLowerCase();
        String batchTypeSrc = batchType.toString().trim().toLowerCase();
        String courseDes = dataItem.elementAt(1).toString().trim().toLowerCase();
        String batchTypeDes = dataItem.elementAt(0).toString().trim().toLowerCase();
        if(index > 0){
          if (courseSrc == courseDes){
            if (batchTypeSrc != batchTypeDes) {
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
      print('Appended Bachelor of $batchType in $course');
    }
    if(passed){
      FileHandler handler = FileHandler();
      for (final dataItem in dataList) {
        coursesData.add([
          dataItem.elementAt(0).toString(),
          dataItem.elementAt(1).toString(),
        ]);
      }
      coursesData.add([batchType.trim(),course.trim()]);
      handler.appendData(coursesData, "courses");
      print('Appended Bachelor of $batchType in $course');
      print(x);
    }else{
      print('Course already exists.');
      print(x);
    }
  }
}