class CourseModel {
  String courseCode;
  String course;

  CourseModel({required this.courseCode, required this.course});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'course_code': courseCode,
      'course': course,
    };
    return map;
  }

  List<String> toList() {
    var list = [
      courseCode.toString(),
      course.toString(),
    ];
    return list;
  }

  factory CourseModel.fromMap(Map<String, Object?> map) {
    return CourseModel(
      courseCode: map['course_code'].toString(),
      course: map['course'].toString(),
    );
  }

}