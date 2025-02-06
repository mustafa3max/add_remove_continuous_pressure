import 'package:add_remove_continuous_pressure/add_remove_continuous_pressure.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Material(
        child: PlusMinus(childAdd: Text("Add"), childRemove: Text("Remove"), childNumber: (data) => Text(data)),
      ),
    ),
  );
}
