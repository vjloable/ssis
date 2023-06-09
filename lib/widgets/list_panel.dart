import 'package:flutter/material.dart';

class ListPanel extends StatelessWidget {
  final Color headerColor;
  final double headHeight;
  final double? width;
  final Color bodyColor;
  final double bodyHeight;
  final BorderRadius borderRadius;
  final Widget? child;
  final Widget? headerChild;
  final double elevation;

  const ListPanel({
    Key? key,
    this.headHeight = 44.0,
    this.bodyHeight = 44.0,
    this.width,
    this.child,
    this.headerChild,
    this.borderRadius = BorderRadius.zero,
    this.headerColor = Colors.grey,
    this.bodyColor = Colors.white,
    this.elevation = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Material(
          elevation: elevation,
          color: headerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: borderRadius.topRight,
                topLeft: borderRadius.topLeft,
            ),
          ),
          child: SizedBox(
            height: headHeight,
            width: width,
            child: headerChild,
          ),
        ),
        Material(
          elevation: elevation,
          color: bodyColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: borderRadius.bottomRight,
                bottomLeft: borderRadius.bottomLeft,
            ),
          ),
          child: SizedBox(height: bodyHeight, width: width, child: child),
        ),
      ],
    );
  }
}
