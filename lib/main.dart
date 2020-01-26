import 'package:comercial_performance/pages/consultores-list.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Performance Comercial',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: ConsultoresList(),
    );
  }
}
