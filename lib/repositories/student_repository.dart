import 'package:ssis/handlers/file_handler.dart';

class StudentRepository{
  void init() async{
    FileHandler handler = FileHandler();
    List<List<String>> studentsData = [
      ["IDNum", "FirstN", "MI", "LastN", "Age", "Sex", "Courses", "Year Level"],
      ["2021-1910", "Vince Japheth", "F.", "Loable", "21", "Male", "BS Computer Science", "2nd Year"],
      ["2019-0900", "John", "A.", "Doe", "23", "Male", "BA Psychology", "4th Year"],
      ["2021-1910", "Vince Japheth", "F.", "Loable", "21", "Male", "BS Computer Science", "2nd Year"],
      ["2019-0900", "John", "A.", "Doe", "23", "Male", "BA Psychology", "4th Year"],
      ["2021-1910", "Vince Japheth", "F.", "Loable", "21", "Male", "BS Computer Science", "2nd Year"],
      ["2019-0900", "John", "A.", "Doe", "23", "Male", "BA Psychology", "4th Year"],
      ["2021-1910", "Vince Japheth", "F.", "Loable", "21", "Male", "BS Computer Science", "2nd Year"],
      ["2019-0900", "John", "A.", "Doe", "23", "Male", "BA Psychology", "4th Year"],
      ["2021-1910", "Vince Japheth", "F.", "Loable", "21", "Male", "BS Computer Science", "2nd Year"],
      ["2019-0900", "John", "A.", "Doe", "23", "Male", "BA Psychology", "4th Year"],
      ["2021-1910", "Vince Japheth", "F.", "Loable", "21", "Male", "BS Computer Science", "2nd Year"],
      ["2019-0900", "John", "A.", "Doe", "23", "Male", "BA Psychology", "4th Year"],
      ["2021-1910", "Vince Japheth", "F.", "Loable", "21", "Male", "BS Computer Science", "2nd Year"],
      ["2019-0900", "John", "A.", "Doe", "23", "Male", "BA Psychology", "4th Year"],
      ["2021-1910", "Vince Japheth", "F.", "Loable", "21", "Male", "BS Computer Science", "2nd Year"],
      ["2019-0900", "John", "A.", "Doe", "23", "Male", "BA Psychology", "4th Year"],
      ["2021-1910", "Vince Japheth", "F.", "Loable", "21", "Male", "BS Computer Science", "2nd Year"],
      ["2019-0900", "John", "A.", "Doe", "23", "Male", "BA Psychology", "4th Year"],
    ];
    handler.initCSVFile(studentsData, "students");
  }

  Future<List<List<dynamic>>> getList() async {
    FileHandler handler = FileHandler();
    return handler.loadCSVFile("students");
  }
}