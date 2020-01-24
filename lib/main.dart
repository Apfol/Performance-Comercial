import 'package:comercial_performance/pages/consultores.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Performance Comercial',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: ConsultoresList(),
    );
  }
}
