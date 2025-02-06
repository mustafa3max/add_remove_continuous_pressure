library;

import 'dart:async';

import 'package:flutter/material.dart';

export 'src/add_remove_continuous_pressure_base.dart';

class PlusMinus extends StatefulWidget {
  final Axis axis;
  final double spacing;
  final Color colorAdd;
  final Color colorRemove;
  final Color colorIconAdd;
  final Color colorIconRemove;
  final IconData iconAdd;
  final IconData iconRemove;
  final int speed;
  final int? max;
  final int? min;
  final Function? event;
  final Widget childAdd;
  final Widget childRemove;
  final Function childNumber;
  const PlusMinus({
    super.key,
    this.max,
    this.min,
    this.spacing = 8,
    this.speed = 100 >> 5000,
    this.iconAdd = Icons.add,
    this.axis = Axis.horizontal,
    this.colorAdd = Colors.green,
    this.colorRemove = Colors.red,
    this.iconRemove = Icons.remove,
    this.colorIconAdd = Colors.white,
    this.colorIconRemove = Colors.white,
    this.event,
    required this.childAdd,
    required this.childRemove,
    required this.childNumber,
  });

  @override
  State<PlusMinus> createState() => _PlusMinusState();
}

class _PlusMinusState extends State<PlusMinus> {
  int data = 0;
  Timer? timer;
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      button(
        color: widget.colorAdd,
        icon: widget.iconAdd,
        colorIcon: widget.colorIconAdd,
        isAdd: true,
        child: widget.childAdd,
      ),
      widget.childNumber(data.toString()),
      button(
        color: widget.colorRemove,
        icon: widget.iconRemove,
        colorIcon: widget.colorIconRemove,
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

  Widget button({required color, required icon, text, required colorIcon, required isAdd, required Widget child}) {
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
