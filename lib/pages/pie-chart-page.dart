import 'package:comercial_performance/entities/consultor.dart';
import 'package:comercial_performance/entities/report.dart';
import 'package:comercial_performance/requests/requests.dart';
import 'package:comercial_performance/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChartPage extends StatefulWidget {
  final Set<Consultor> consultores;

  PieChartPage({this.consultores});

  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  Future<List<Report>> reports;

  @override
  void initState() {
    super.initState();
    reports = fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gráfico de torta"),
        backgroundColor: utils.primaryColor,
      ),
      body: Center(
        child: FutureBuilder(
            future: reports,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                getConsultorReports(snapshot.data, widget.consultores);
                setMonthyReportsConsultorsChecked(widget.consultores);
                getSeriePieChart(widget.consultores);
                return buildView(widget.consultores);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  Widget buildView(Set<Consultor> consultores) {
    if (consultores.first.monthlyReports.isEmpty && consultores.length == 1) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  consultores.first.noUsuario,
                  style: TextStyle(
                      color: utils.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
            ),
            Divider(
              height: 40,
              thickness: 2,
            ),
            Center(
              child: Text(
                "No tiene reportes",
                style: TextStyle(color: utils.primaryColor, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: new charts.PieChart(
        createChartData(widget.consultores),
        animate: true,
        behaviors: [
          new charts.DatumLegend(
              horizontalFirst: false, position: charts.BehaviorPosition.bottom)
        ],
        defaultRenderer: new charts.ArcRendererConfig(
          arcWidth: 100,
          arcRendererDecorators: [new charts.ArcLabelDecorator()],
        ),
      ),
    );
  }

  List<SeriePieChart> getSeriePieChart(Set<Consultor> consultores) {
    List<SeriePieChart> seriePieChart = new List();
    for (var c in consultores) {
      seriePieChart.add(new SeriePieChart(c.noUsuario, getTotalNetEarnings(c)));
    }
    return seriePieChart;
  }

  List<charts.Series<SeriePieChart, String>> createChartData(
      Set<Consultor> consultores) {
    List<charts.Series<SeriePieChart, String>> chartData = new List();
    chartData.add(
      new charts.Series<SeriePieChart, String>(
        id: "Pie Chart",
        domainFn: (SeriePieChart pieChart, _) => pieChart.noUsuario,
        measureFn: (SeriePieChart pieChart, _) => pieChart.netEarning,
        data: getSeriePieChart(consultores),
        labelAccessorFn: (SeriePieChart row, _) => '${row.netEarning}',
      ),
    );
    return chartData;
  }

  getConsultorReports(List<Report> reports, Set<Consultor> consultores) {
    for (var c in consultores) {
      for (var r in reports) {
        if (c.coUsuario == r.coUsuario) {
          c.reports.add(r);
        }
      }
    }
  }

  double getTotalNetEarnings(Consultor consultor) {
    double totalNetEarnings = 0;
    for (var mr in consultor.monthlyReports) {
      totalNetEarnings += mr.netEarning;
    }
    return totalNetEarnings;
  }

  setMonthyReportsConsultorsChecked(Set<Consultor> consultores) {
    for (var c in consultores) {
      c.setMonthlyReports();
    }
  }
}

class SeriePieChart {
  String noUsuario;
  double netEarning;

  SeriePieChart(this.noUsuario, this.netEarning);
}
