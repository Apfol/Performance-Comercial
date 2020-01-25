import 'package:comercial_performance/pages/consultores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:comercial_performance/utils/utils.dart' as utils;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Performance Comercial',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(body: ConsultoresList()),
    );
  }
}
