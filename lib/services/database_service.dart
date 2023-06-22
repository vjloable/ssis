import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:ssis/misc/scope.dart';
import 'package:ssis/models/course_model.dart';
import 'package:ssis/models/student_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  late DatabaseFactory _databaseFactory;
  late Database _database;

  factory DatabaseService() {
    databaseFactory = databaseFactoryFfi;
    _instance._databaseFactory = databaseFactory;
    print('----initialize');
    return _instance;
  }

  DatabaseService._internal();

  Future<void> open() async {
    print('----open');
    Directory dir = Directory.fromUri(Uri.directory('userdata'));
    dir.createSync(recursive: true);
    String path = join(dir.absolute.path, 'ssis.db');

    _instance._database = await _databaseFactory.openDatabase(path, options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
        '''
        PRAGMA foreign_keys = ON;
        PRAGMA encoding = "UTF-8";
        CREATE TABLE courses(
          course_code TEXT PRIMARY KEY ON CONFLICT IGNORE,
          course TEXT NOT NULL
        );
        CREATE TABLE students(
          student_id TEXT PRIMARY KEY ON CONFLICT IGNORE,
          name TEXT NOT NULL, 
          gender TEXT NOT NULL,
          year_level TEXT NOT NULL,
          course_code TEXT REFERENCES courses(course_code) ON DELETE SET NULL ON UPDATE CASCADE 
        );
        '''
        );
      },
    ));
    print('open database: ${_instance._database.hashCode}');
  }

  Future<void> close() async {
    print('----close');
    print('close database: ${_instance._database.hashCode}');
    await _instance._database.close();
  }

  Future<bool> insert(dynamic data, Scope scope) async {
    print('----insert');
    bool isSuccess = true;
    try {
      if (scope == Scope.course) {
        CourseModel courseModel = data as CourseModel;
        await _instance._database.rawInsert(
          '''
          INSERT OR FAIL INTO courses(course_code, course) VALUES (
          "${courseModel.courseCode}", 
          "${courseModel.course}"
          );
          '''
        );
      } else if (scope == Scope.student) {
        StudentModel studentModel = data as StudentModel;
        // print('${studentModel.studentId} ${studentModel.name} ${studentModel.gender} ${studentModel.yearLevel} ${studentModel.courseCode}');
        await _instance._database.rawInsert(
          '''
          INSERT OR FAIL INTO students(student_id, name, gender, year_level, course_code) VALUES (
          "${studentModel.studentId}", 
          "${studentModel.name}", 
          "${studentModel.gender}", 
          "${studentModel.yearLevel}", 
          "${studentModel.courseCode}"
          );
          '''
        );
      }
      // await _instance._database.insert(table, data.toMap(), conflictAlgorithm: ConflictAlgorithm.fail);
    } on Exception catch (_) {
      isSuccess = false;
    }
    print('DBService: $isSuccess');
    return isSuccess;
  }

  Future<int> count() async {
    return await _instance._database.rawUpdate(
        '''
        SELECT COUNT(*)
        FROM courses
        WHERE course_code = "";
        '''
    );
  }

  Future<bool> update(String prevId, dynamic submission, Scope scope) async {
    print('----update');
    bool isSuccess = true;
    try {
      if (scope == Scope.course) {
        CourseModel newCourse = submission as CourseModel;
        await _instance._database.rawUpdate(
            '''
            UPDATE courses SET 
            course_code = "${newCourse.courseCode}", 
            course = "${newCourse.course}"
            WHERE course_code = "$prevId";
            '''
        );
      } else if (scope == Scope.student) {
        StudentModel newStudent = submission as StudentModel;
        await _instance._database.rawUpdate(
            '''
            UPDATE students SET 
            student_id = "${newStudent.studentId}",
            name = "${newStudent.name}",
            gender = "${newStudent.gender}",
            year_level = "${newStudent.yearLevel}",
            course_code = "${newStudent.courseCode}"
            WHERE student_id = "$prevId";
            '''
        );
      }
    } on Exception catch (_) {
      isSuccess = false;
    }
    return isSuccess;
  }

  Future<bool> delete(String id, Scope scope) async {
    print('----delete');
    bool isSuccess = true;
    try {
      if (scope == Scope.course) {
        await _instance._database.rawDelete(
            '''
            PRAGMA foreign_keys = ON;
            DELETE FROM courses WHERE course_code = "$id";
            '''
        );
      } else if (scope == Scope.student) {
        await _instance._database.rawDelete(
            '''
            PRAGMA foreign_keys = ON;
            DELETE FROM students WHERE student_id = "$id";
            '''
        );
      }
    } on Exception catch (_) {
      isSuccess = false;
    }
    return isSuccess;
  }

  Future<List<Map<String, Object?>>> query(String table) async {
    print('----query');
    List<Map<String, Object?>> returnable = await _instance._database.query(table);
    print('----end query');
    return returnable;
  }

  Future<List<Map<String, Object?>>> search(String search, Scope scope) async {
    print('----search');
    List<Map<String, Object?>> returnable = [];
    if (scope == Scope.course) {
      returnable = await _instance._database.rawQuery(
          '''
          SELECT * FROM courses
          WHERE course_code LIKE '%$search%' 
          OR course LIKE '%$search%' 
          ORDER BY course_code;
          '''
      );
    } else if (scope == Scope.student) {
      returnable = await _instance._database.rawQuery(
          '''
          SELECT * FROM students 
          WHERE student_id LIKE '%$search%'
          OR name LIKE '%$search%'
          OR gender LIKE '%$search%'
          OR year_level LIKE '%$search%'
          OR course_code LIKE '%$search%'
          ORDER BY student_id;
          '''
      );
    }
    print('----end search');
    return returnable;
  }
}