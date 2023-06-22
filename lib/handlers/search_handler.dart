import 'package:ssis/controllers/progressbar_controller.dart';
import 'package:ssis/misc/progressbar_states.dart';
import 'package:ssis/misc/scope.dart';
// import 'package:ssis/repositories/course_repository.dart';
// import 'package:ssis/repositories/student_repository.dart';

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

  Future<List<List<dynamic>>> search(String? value, Scope scope, ProgressBarController controller) async {
    print('value: $value');
    List<List<dynamic>> rawList = [['-']];
    switch (scope) {
      case Scope.course:
        // rawList = await CourseRepository().getList();
        break;
      case Scope.student:
        // rawList = await StudentRepository().getList();
        break;
    }
    if (value == null || value.trim() == '') {
      controller.setState(ProgressBarStates.idle);
      return rawList;
    }
    List<List<dynamic>> searchedList = [];
    for (var i = 1; i < rawList.length; i++) {
      for (var rawItem in rawList[i]) {
        if (rawItem.toString().trim().toLowerCase().contains(
            value.trim().toLowerCase())
        ) {
          searchedList.add(rawList[i]);
        }
      }
    }
    print('searchedList: $searchedList');
    searchedList = searchedList.toSet().toList();
    searchedList.sort((a, b) => a.first.toString().compareTo(b.first.toString()));
    searchedList.insert(0, rawList.first);
    return searchedList;
  }

}