import 'package:ssis/misc/scope.dart';
import 'package:ssis/models/course_model.dart';
import 'package:ssis/services/database_service.dart';

class CourseRepository{
  Future<List<CourseModel>> getList() async {
    DatabaseService dbService = DatabaseService();
    List<Map<String, Object?>> mapListCourses = await dbService.query('courses');
    List<CourseModel> listCourseModel = [];
    listCourseModel.add(CourseModel(courseCode: 'COURSE CODE', course: 'AVAILABLE COURSE'));
    if (mapListCourses.isNotEmpty) {
      for (Map<String, Object?> mapCourses in mapListCourses) {
        listCourseModel.add(CourseModel.fromMap(mapCourses));
      }
    }
    return listCourseModel;
  }

  Future<bool> add(String courseCode, String course) async {
    bool isSuccess = false;
    DatabaseService dbService = DatabaseService();
    CourseModel submission = CourseModel(courseCode: courseCode.trim(), course: course.trim());
    isSuccess = await dbService.insert(submission, Scope.course);
    return isSuccess;
  }

  Future<bool> update(String prevCourseCode, CourseModel newCourse) async {
    bool isSuccess = false;
    DatabaseService dbService = DatabaseService();
    isSuccess = await dbService.update(prevCourseCode, newCourse, Scope.course);
    return isSuccess;
  }

  Future<bool> delete(List<CourseModel> listData) async {
    bool isSuccess = false;
    DatabaseService dbService = DatabaseService();
    for (final listItem in listData) {
      isSuccess = await dbService.delete(listItem.courseCode, Scope.course);
    }
    return isSuccess;
  }
}