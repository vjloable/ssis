import 'package:flutter/material.dart';

class CardRow extends StatelessWidget {
  final Color color;
  final Color colorText;
  final double height;
  final double? width;
  final double fontSize;
  final Widget? child;
  final List<dynamic> data;
  final String header;
  final String Function(List<dynamic>, String) formatter;
  final ScrollController scrollController;

  const CardRow({
    Key? key,
    required this.data,
    required this.header,
    required this.formatter,
    required this.scrollController,
    this.color = Colors.white,
    this.colorText = Colors.black,
    this.height = 25.0,
    this.width,
    this.child,
    this.fontSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return formatter(data, header) != header
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
              child: RawScrollbar(
                controller: scrollController,
                thickness: 2,
                thumbColor: Colors.deepPurpleAccent,
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    formatter(data, header),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: colorText, fontSize: fontSize),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )
        : Card(
      color: const Color(0x55FFFFFF),
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
                child: Text(
                  formatter(data, header),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: colorText, fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
