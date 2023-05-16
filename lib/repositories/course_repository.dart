import 'package:ssis/handlers/file_handler.dart';

class CourseRepository{
  void init() async{
    FileHandler handler = FileHandler();
    List<List<String>> coursesData = [
      ["BachType", "Course", "College"],
      ["Arts", "Psychology", "CASS"],
      ["Science", "Psychology", "CHS"],
      ["Science", "Statistics", "CSM"],
      ["Science", "Computer Science", "CCS"],
      ["Arts", "Psychology", "CASS"],
      ["Science", "Psychology", "CHS"],
      ["Science", "Statistics", "CSM"],
      ["Science", "Computer Science", "CCS"],
      ["Arts", "Psychology", "CASS"],
      ["Science", "Psychology", "CHS"],
      ["Science", "Statistics", "CSM"],
      ["Science", "Computer Science", "CCS"],
      ["Arts", "Psychology", "CASS"],
      ["Science", "Psychology", "CHS"],
      ["Science", "Statistics", "CSM"],
      ["Science", "Computer Science", "CCS"],
      ["Arts", "Psychology", "CASS"],
      ["Science", "Psychology", "CHS"],
      ["Science", "Statistics", "CSM"],
      ["Science", "Computer Science", "CCS"],
    ];
    handler.initCSVFile(coursesData, "courses");
    print('Course Service initialized!');
  }
  
  Future<List<List<dynamic>>> getList() async {
    FileHandler handler = FileHandler();
    return handler.loadCSVFile("courses");
  }

  // void add(String batchType, String course, String college) async{
  //   List<List<dynamic>> dataList = await getList().then((data) => data);
  //   List<dynamic> dataHead = dataList.first;
  //   if (dataList.length > 1){
  //     int index = 0;
  //     for (final dataItem in dataList){
  //       String courseSrc = course.toString().trim().toLowerCase();
  //       String batchTypeSrc = batchType.toString().trim().toLowerCase();
  //       String collegeSrc = college.toString().trim().toLowerCase();
  //       String courseDes = dataItem.elementAt(1).toString().trim().toLowerCase();
  //       String batchTypeDes = dataItem.elementAt(0).toString().trim().toLowerCase();
  //       String collegeDes = dataItem.elementAt(2).toString().trim().toLowerCase();
  //       if (courseSrc == courseDes){
  //         // if ()
  //         break;
  //       }else{
  //         index++;
  //       }
  //     }
  //     print('Course already exists.');
  //   }else{
  //     FileHandler handler = FileHandler();
  //     List<List<String>> coursesData = [];
  //     handler.initCSVFile(coursesData, "courses");
  //   }
  // }
}