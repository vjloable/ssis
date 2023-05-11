import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

class FileHandler{
  void initCSVFile(List<List<String>> data, String filename) async{
    String csvData = const ListToCsvConverter().convert(data);
    String directory = (await getApplicationSupportDirectory()).path;
    String filePath = "$directory/$filename.csv";
    if(File(filePath).existsSync()){
      if (kDebugMode) {
        print('The specified file in the $filePath does not exists');
      }
    }else{
      File file = File(filePath);
      await file.writeAsString(csvData);
    }
  }

  Future<List<List<dynamic>>> loadCSVFile(String filename) async {
    String directory = (await getApplicationSupportDirectory()).path;
    String filePath = "$directory/$filename.csv";
    final file = File(filePath).openRead();
    return await file
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
  }

  insertData(List<List<String>> data, ) async{

  }

  editData(List<List<String>> data) async{

  }

  removeData(List<List<String>> data) async{

  }

}