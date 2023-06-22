class StudentModel {
  String studentId;
  String name;
  String gender;
  String yearLevel;
  String courseCode;

  StudentModel({
    required this.studentId,
    required this.name,
    required this.gender,
    required this.yearLevel,
    required this.courseCode,
  });

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'student_id': studentId,
      'name': name,
      'gender': gender,
      'year_level': yearLevel,
      'course_code': courseCode,
    };
    return map;
  }

  List<String> toList() {
    var list = [
      studentId.toString(),
      name.toString(),
      gender.toString(),
      yearLevel.toString(),
      courseCode.toString(),
    ];
    return list;
  }

  factory StudentModel.fromMap(Map<String, Object?> map) {
    return StudentModel(
      studentId: map['student_id'].toString(),
      name: map['name'].toString(),
      gender: map['gender'].toString(),
      yearLevel: map['year_level'].toString(),
      courseCode: map['course_code'].toString(),
    );
  }
}