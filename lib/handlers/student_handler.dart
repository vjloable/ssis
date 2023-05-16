class StudentHandler{
  String formatterFullName(List<dynamic> data, String header){
    String returnString = header;
    if(data.elementAt(1) != 'FirstN'){
      returnString = '${data.elementAt(1).toString().trim()} ${data.elementAt(2).toString().trim()} ${data.elementAt(3).toString().trim()}';
    }
    return returnString;
  }

  String formatterIDNum(List<dynamic> data, String header){
    List<String> comparisonList = ["IDNum", "FirstN", "MI", "LastN", "Age", "Sex", "Courses", "Year Level"];
    int index = 0;
    String returnString = header;
    if(data.elementAt(index) != comparisonList[index]){
      returnString = data.elementAt(index).toString().trim();
    }
    return returnString;
  }

  String formatterAge(List<dynamic> data, String header){
    List<String> comparisonList = ["IDNum", "FirstN", "MI", "LastN", "Age", "Sex", "Courses", "Year Level"];
    int index = 4;
    String returnString = header;
    if(data.elementAt(index) != comparisonList[index]){
      returnString = data.elementAt(index).toString().trim();
    }
    return returnString;
  }

  String formatterSex(List<dynamic> data, String header){
    List<String> comparisonList = ["IDNum", "FirstN", "MI", "LastN", "Age", "Sex", "Courses", "Year Level"];
    int index = 5;
    String returnString = header;
    if(data.elementAt(index) != comparisonList[index]){
      returnString = data.elementAt(index).toString().trim();
    }
    return returnString;
  }

  String formatterCourse(List<dynamic> data, String header){
    List<String> comparisonList = ["IDNum", "FirstN", "MI", "LastN", "Age", "Sex", "Courses", "Year Level"];
    int index = 6;
    String returnString = header;
    if(data.elementAt(index) != comparisonList[index]){
      returnString = data.elementAt(index).toString().trim();
    }
    return returnString;
  }

  String formatterYearLevel(List<dynamic> data, String header){
    List<String> comparisonList = ["IDNum", "FirstN", "MI", "LastN", "Age", "Sex", "Courses", "Year Level"];
    int index = 7;
    String returnString = header;
    if(data.elementAt(index) != comparisonList[index]){
      returnString = data.elementAt(index).toString().trim();
    }
    return returnString;
  }

}