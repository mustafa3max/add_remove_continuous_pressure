import 'package:add_remove_continuous_pressure/add_remove_continuous_pressure.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Material(
        child: AddRemove(
          min: 1,
          max: 10,
          speed: 500,
          spacing: 8,
          childAdd: Text("Add"),
          axis: Axis.horizontal,
          childRemove: Text("Remove"),
          event: (data) => print(data),
          childNumber: (data) => Text(data),
        ),
      ),
    ),
  );
}
