import 'package:flutter/material.dart';

class CardRow extends StatelessWidget {
  final Color color;
  final Color colorText;
  final double height;
  final double? width;
  final double fontSize;
  final Widget? child;
  final List<dynamic> data;
  final int dataLength;

  const CardRow({
    Key? key,
    required this.data,
    required this.dataLength,
    this.color = Colors.white,
    this.colorText = Colors.black,
    this.height = 25.0,
    this.width,
    this.child,
    this.fontSize = 12,
  }) : super(key: key);

  String sorter(List<dynamic> data){
    String returnString = '';
    if(data.elementAt(1) != 'Course'){
      returnString += data.elementAt(0) == 'Arts'? 'BA' : 'BS';
      returnString += ' ${data.elementAt(1)} (${data.elementAt(2)})';
    }else{
      returnString = 'COURSES';
    }
    return returnString;
  }

  @override
  Widget build(BuildContext context) {
    return sorter(data) != 'COURSES'
        ? Card(
      color: color,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            child: Container(
              alignment: Alignment.centerLeft,
              height: height,
              width: width,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  sorter(data),
                  style: TextStyle(color: colorText, fontSize: fontSize),
                ),
              ),
            ),
          ),
        ],
      ),
    )
        : Card(
      color: Color(0xFF202124),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            child: Container(
              alignment: Alignment.centerLeft,
              height: height,
              width: width,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    sorter(data),
                    style: TextStyle(color: colorText, fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
