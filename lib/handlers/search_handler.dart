import 'package:ssis/controllers/progressbar_controller.dart';
import 'package:ssis/misc/progressbar_states.dart';
import 'package:ssis/misc/scope.dart';
import 'package:ssis/repositories/course_repository.dart';
import 'package:ssis/repositories/student_repository.dart';

class SearchHandler {
  String? _searchStudentData;
  String? _searchCourseData;

  void set(String? value, Scope scope) async {
    switch (scope) {
      case Scope.course:
        _searchStudentData = value?.trim();
        break;
      case Scope.student:
        _searchCourseData = value?.trim();
        break;
    }
  }

  String? get(Scope scope) {
    switch (scope) {
      case Scope.course:
        return _searchStudentData;
      case Scope.student:
        return _searchCourseData;
    }
  }

  Future<List<dynamic>> search(String? value, Scope scope, ProgressBarController controller) async {
    print('value: $value');
    List<dynamic> searchedList = [];
    switch (scope) {
      case Scope.course:
        searchedList = await CourseRepository().searchList(value ?? '');
        break;
      case Scope.student:
        searchedList = await StudentRepository().searchList(value ?? '');
        break;
    }
    if (value == null || value.trim() == '') {
      controller.setState(ProgressBarStates.idle);
    }
    // }
    return searchedList;
  }

}