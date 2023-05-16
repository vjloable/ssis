class CourseHandler{
  String formatter(List<dynamic> data, String header){
    String returnString = header;
    if(data.elementAt(1) != 'Course'){
      returnString = data.elementAt(0) == 'Arts'? 'BA' : 'BS';
      returnString += ' ${data.elementAt(1)} (${data.elementAt(2)})';
    }
    return returnString;
  }
}