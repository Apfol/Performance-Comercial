import 'package:comercial_performance/entities/consultor.dart';
import 'package:comercial_performance/utils/utils.dart' as utils;
import 'package:flutter/material.dart';

class PieChartPage extends StatelessWidget {
  final Set<Consultor> consultores;

  PieChartPage({this.consultores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gráfico de torta"),
        backgroundColor: utils.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
