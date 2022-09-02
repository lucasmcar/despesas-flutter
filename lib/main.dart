import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      primarySwatch: Colors.red,
      accentColor: Colors.deepOrangeAccent,
    ),
  ));
}
