import 'package:ssis/handlers/file_handler.dart';

class StudentService{
  init() async{
    FileHandler handler = FileHandler();
    List<List<String>> studentsData = [
      ["IDNum", "FirstN", "MI", "LastN", "Age", "Sex", "Courses", "Year Level"],
    ];
    handler.initCSVFile(studentsData, "students");
  }
}