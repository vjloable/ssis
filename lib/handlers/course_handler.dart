class CourseHandler{
  String formatter(List<dynamic> data, String header){
    String returnString = header;
    if(data.elementAt(1) != 'Course'){
      returnString = data.elementAt(0) == 'Arts'? 'BA' : 'BS';
      returnString += ' ${data.elementAt(1)} (${data.elementAt(2)})';
    }
    return returnString;
  }

  Future<List<String>> formattedCoursesList(Future<List<List<dynamic>>> futureList) async {
    List<List<dynamic>> rawList = await futureList;
    List<String> filteredList = [];
    if(rawList.length > 1){
      for (var row in rawList) {
        if(row.elementAt(0) != "BachType") {
          filteredList.add("B${row.elementAt(0).toString().substring(0,1)} ${row.elementAt(1).toString()}");
        }
      }
    }else{
      filteredList = [''];
    }
    return filteredList.toSet().toList();
  }

}