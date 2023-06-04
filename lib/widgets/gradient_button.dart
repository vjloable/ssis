import 'dart:math';

import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final VoidCallback? onPressed;
  final Widget child;
  final double elevation;
  final List<Color> colors;
  final bool isEnabled;

  const GradientButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.colors,
    this.isEnabled = true,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.elevation = 0.0,
  }) : super(key: key);

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26, offset: const Offset(0, 6), blurRadius: widget.elevation * log(widget.elevation) + 3, spreadRadius: widget.elevation
          )
        ],
        gradient: widget.isEnabled ? LinearGradient(colors: widget.colors) : LinearGradient(colors: [widget.colors.first.withOpacity(0.4),widget.colors.first.withOpacity(0.4)]),
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: widget.isEnabled ? widget.onPressed : null ,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.grey,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: widget.child,
      ),
    );
  }
}