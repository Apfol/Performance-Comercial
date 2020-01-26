import 'package:comercial_performance/entities/consultor.dart';
import 'package:comercial_performance/entities/fixed-cost.dart';
import 'package:comercial_performance/entities/report.dart';
import 'package:comercial_performance/requests/requests.dart';
import 'package:comercial_performance/utils/utils.dart' as utils;
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  final Set<Consultor> consultores;
  ReportPage({this.consultores});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  Future<List<Report>> reports;
  Future<List<FixedCost>> fixedCost;

  @override
  void initState() {
    super.initState();
    fixedCost = fetchFixedCost();
    reports = fetchNetEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informe"),
        backgroundColor: utils.primaryColor,
      ),
      body: Center(
        child: FutureBuilder(
          future: reports,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(snapshot.data[index].valor);
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
