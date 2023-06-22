import 'package:ssis/misc/scope.dart';
import 'package:ssis/models/student_model.dart';
import 'package:ssis/services/database_service.dart';

class StudentRepository {
  Future<List<StudentModel>> getList() async {
    DatabaseService dbService = DatabaseService();
    List<Map<String, Object?>> mapListStudents = await dbService.query('students');
    List<StudentModel> listStudentModel = [];
    listStudentModel.add(StudentModel(studentId: 'ID NUMBER', name: 'FULL NAME', gender: 'GENDER', yearLevel: 'YEAR LEVEL', courseCode: 'COURSE CODE'));
    if (mapListStudents.isNotEmpty) {
      for (Map<String, Object?> mapStudents in mapListStudents) {
        listStudentModel.add(StudentModel.fromMap(mapStudents));
      }
    }
    return listStudentModel;
  }

  Future<List<StudentModel>> searchList(String search) async {
    DatabaseService dbService = DatabaseService();
    List<Map<String, Object?>> mapListStudents = await dbService.search(search, Scope.student);
    List<StudentModel> listStudentModel = [];
    listStudentModel.add(StudentModel(studentId: 'ID NUMBER', name: 'FULL NAME', gender: 'GENDER', yearLevel: 'YEAR LEVEL', courseCode: 'COURSE CODE'));
    if (mapListStudents.isNotEmpty) {
      for (Map<String, Object?> mapStudents in mapListStudents) {
        listStudentModel.add(StudentModel.fromMap(mapStudents));
      }
    }
    return listStudentModel;
  }

  Future<bool> add(String studentId, String name, String gender, String yearLevel, String courseCode) async {
    bool isSuccess = false;
    DatabaseService dbService = DatabaseService();
    StudentModel submission = StudentModel(studentId: studentId.trim(), name: name.trim(), gender: gender.trim(), yearLevel: yearLevel.trim(), courseCode: courseCode.trim());
    isSuccess = await dbService.insert(submission, Scope.student);
    print('StudentRepository: $isSuccess');
    return isSuccess;
  }

  Future<bool> update(String prevStudentID, StudentModel newStudent) async {
    bool isSuccess = false;
    DatabaseService dbService = DatabaseService();
    isSuccess = await dbService.update(prevStudentID, newStudent, Scope.student);
    print('sr: $isSuccess');
    return isSuccess;
  }

  Future<bool> delete(List<StudentModel> listData) async {
    bool isSuccess = false;
    DatabaseService dbService = DatabaseService();
    for (final listItem in listData) {
      isSuccess = await dbService.delete(listItem.studentId, Scope.student);
    }
    return isSuccess;
  }

}