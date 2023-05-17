import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

class FileHandler{
  void initCSVFile(List<List<String>> data, String filename) async{
    String csvData = const ListToCsvConverter().convert(data);
    // String directory = (await getApplicationSupportDirectory()).path;
    Directory dir = Directory.fromUri(Uri.directory('userdata'));
    dir.createSync(recursive: true);
    File file = File('${dir.absolute.path}$filename.csv');
    print('initializing: ${file.absolute.path}');
    file.writeAsStringSync(csvData);
    // if(File(filePath).existsSync()){
    //   if (kDebugMode) {
    //     print('The specified file in the $filePath already exists');
    //   }
    // }else{
    //   if (kDebugMode) {
    //     print('The specified file in the $filePath does not yet exists');
    //   }
    //   File file = File(filePath);
    //   await file.writeAsString(csvData);
    // }
  }

  Future<List<List<dynamic>>> loadCSVFile(String filename) async {
    // String directory = (await getApplicationDocumentsDirectory()).path;
    Directory dir = Directory.fromUri(Uri.directory('userdata'));
    dir.createSync(recursive: true);
    File file = File('${dir.absolute.path}$filename.csv');
    print('loading: ${file.absolute.path}');
    return await file.openRead().transform(utf8.decoder).transform(const CsvToListConverter()).toList();
  }

  insertData(List<List<String>> data, String filename) async{
    String csvData = const ListToCsvConverter().convert(data);
    String directory = (await getApplicationDocumentsDirectory()).path;
    String filePath = "$directory\\$filename.csv";
    File file = File(filePath);
    await file.writeAsString(csvData);
  }

  editData(List<List<String>> data) async{

  }

  removeData(List<List<String>> data) async{

  }

}