library;

import 'dart:async';

import 'package:flutter/material.dart';

export 'src/add_remove_continuous_pressure_base.dart';

class AddRemove extends StatefulWidget {
  final int? max;
  final int? min;
  final int data;
  final Axis axis;
  final int speed;
  final bool expanded;
  final double spacing;
  final Function? event;
  final Widget childAdd;
  final Widget childRemove;
  final Function childNumber;
  const AddRemove({
    super.key,
    this.max,
    this.min,
    this.event,
    this.data = 0,
    this.spacing = 8,
    this.expanded = false,
    this.speed = 100 >> 5000,
    this.axis = Axis.horizontal,
    required this.childAdd,
    required this.childRemove,
    required this.childNumber,
  });

  @override
  State<AddRemove> createState() => _PlusMinusState();
}

class _PlusMinusState extends State<AddRemove> {
  int data = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      button(
        isAdd: true,
        child: widget.childAdd,
      ),
      Expanded(
        flex: widget.expanded ? 1 : 0,
        child: Center(
          child: widget.childNumber(data.toString()),
        ),
      ),
      button(
        isAdd: false,
        child: widget.childRemove,
      ),
    ];
    if (widget.axis == Axis.vertical) {
      return Column(
        spacing: widget.spacing,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    } else {
      return Row(
        spacing: widget.spacing,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }

  Widget button({text, required isAdd, required Widget child}) {
    Future event(bool go, bool oneClick) async {
      if (go) {
        int speed = widget.speed;
        if (speed < 100) {
          speed = 100;
        } else if (speed > 5000) {
          speed = 5000;
        }
        timer = Timer.periodic(
          Duration(milliseconds: speed),
          (timer) {
            setState(() {
              if (isAdd) {
                if (widget.max != null) {
                  if (data < widget.max!) {
                    data++;
                  }
                } else {
                  data++;
                }
              } else {
                if (widget.min != null) {
                  if (data > widget.min!) {
                    data--;
                  }
                } else {
                  data--;
                }
              }
            });
          },
        );
      } else {
        if (timer != null) {
          timer!.cancel();
        }
        if (oneClick) {
          setState(() {
            if (isAdd) {
              if (widget.max != null) {
                if (data < widget.max!) {
                  data++;
                }
              } else {
                data++;
              }
            } else {
              if (widget.min != null) {
                if (data > widget.min!) {
                  data--;
                }
              } else {
                data--;
              }
            }
          });
        }
        if (widget.event != null && oneClick) {
          widget.event!(data);
        }
      }
    }

    return InkWell(
      onHighlightChanged: (go) => event(go, false),
      onTap: () => event(false, true),
      child: child,
    );
  }
}
