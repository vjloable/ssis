import 'package:flutter/material.dart';
import 'package:ssis/controllers/card_check_controller.dart';

class CardCheckRow extends StatefulWidget {
  final Color color;
  final Color colorCheckBox;
  final double height;
  final double? width;
  final List<dynamic> data;
  final int index;
  final CardCheckController controller;

  const CardCheckRow({
    Key? key,
    required this.data,
    required this.index,
    required this.controller,
    this.color = Colors.white,
    this.colorCheckBox = Colors.black,
    this.height = 25.0,
    this.width,
  }) : super(key: key);

  @override
  State<CardCheckRow> createState() => _CardCheckRowState();
}

class _CardCheckRowState extends State<CardCheckRow> {
  bool checkState = false;

  void _onChanged(bool value) {
    setState(() {
      checkState = value;
      if (checkState) {
        widget.controller.set(widget.index, true, widget.data);
      } else {
        widget.controller.set(widget.index, false, widget.data);
      }
    });
  }

  @override
  void didUpdateWidget(covariant CardCheckRow oldWidget) {
    widget.controller.initInstance(widget.index, widget.data);
    // widget.controller.setNoNotify(widget.index, false, widget.data);
    print('updated: ${oldWidget.controller.hashCode} =>\n${oldWidget.index}');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    print('init: ${widget.controller.hashCode} =>\n${widget.index}');
    widget.controller.initInstance(widget.index, widget.data);
    super.initState();
  }

  @override
  void dispose() {
    print('${widget.hashCode}\n   => ${widget.data}');
    widget.controller.disposeInstance(widget.index);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.elementAt(widget.index) == '-') {
      return widget.index > 0
          ? Card(
              color: widget.color,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: widget.height,
                  width: widget.width,
                ),
              ),
            )
          : Card(
              color: const Color(0x55FFFFFF),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: widget.height,
                  width: widget.width,
                ),
              ),
            );
    } else {
      return widget.index > 0
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Container(
                alignment: Alignment.centerLeft,
                height: widget.height,
                width: widget.width,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: AnimatedBuilder(
                    animation: widget.controller,
                    builder: (context, child) {
                      checkState = widget.controller.get(widget.index);
                      return Checkbox(
                        checkColor: Colors.deepPurpleAccent,
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return Colors.black45;
                          }
                          return Colors.white;
                        }),
                        value: checkState,
                        onChanged: (value) {
                          _onChanged(value!);
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Container(
                alignment: Alignment.centerLeft,
                height: widget.height,
                width: widget.width,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: AnimatedBuilder(
                      animation: widget.controller,
                      builder: (context, child) {
                        checkState = widget.controller.get(widget.index);
                        return Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.deepPurpleAccent;
                            }
                            return Colors.white;
                          }),
                          value: checkState,
                          onChanged: (value) {
                            _onChanged(value!);
                          },
                        );
                      }),
                ),
              ),
            );
    }
  }
}
