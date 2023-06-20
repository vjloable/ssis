import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:csv/csv.dart';

class FileHandler{
  Future<List<List<dynamic>>> loadCSVFile(String filename) async {
    Directory dir = Directory.fromUri(Uri.directory('userdata'));
    dir.createSync(recursive: true);
    File file = File('${dir.absolute.path}$filename.csv');
    // print('loading: ${file.absolute.path}');
    return await file.openRead().transform(utf8.decoder).transform(const CsvToListConverter()).toList();
  }

  void initData(List<List<String>> data, String filename) async{
    String csvData = const ListToCsvConverter().convert(data);
    Directory dir = Directory.fromUri(Uri.directory('userdata'));
    dir.createSync(recursive: true);
    File file = File('${dir.absolute.path}$filename.csv');
    if(file.existsSync()){
      if (kDebugMode) {
        // print('The specified file in the ${file.absolute.path} already exists');
      }
    }else{
      if (kDebugMode) {
        // print('initializing: ${file.absolute.path}');
      }
      file.writeAsStringSync(csvData);
    }
  }

  void appendData(List<List<String>> data, String filename) async{
    String csvData = const ListToCsvConverter().convert(data);
    Directory dir = Directory.fromUri(Uri.directory('userdata'));
    dir.createSync(recursive: true);
    File file = File('${dir.absolute.path}$filename.csv');
    print('appending: ${file.absolute.path}');
    file.writeAsStringSync(csvData);
  }

  editData(List<List<String>> data) async{

  }

  removeData(List<List<String>> data) async{

  }

}