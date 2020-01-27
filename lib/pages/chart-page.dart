import 'package:comercial_performance/entities/consultor.dart';
import 'package:comercial_performance/entities/report.dart';
import 'package:comercial_performance/requests/requests.dart';
import 'package:comercial_performance/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartPage extends StatefulWidget {
  final Set<Consultor> consultores;

  ChartPage({this.consultores});

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
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
        title: Text("Gráfico"),
        backgroundColor: utils.primaryColor,
      ),
      body: Center(
        child: FutureBuilder(
          future: reports,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              getConsultorReports(snapshot.data, widget.consultores);
              setMonthyReportsConsultorsChecked(widget.consultores);
              setSerieChart(widget.consultores);
              List<charts.Series<SerieChart, String>> chartData =
                  createChartData(widget.consultores);
              return buildView(chartData, widget.consultores);
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

  Widget buildView(List<charts.Series<SerieChart, String>> chartData,
      Set<Consultor> consultores) {
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
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: charts.BarChart(
        chartData,
        animate: true,
        barGroupingType: charts.BarGroupingType.grouped,
        behaviors: [
          new charts.SeriesLegend(
              position: charts.BehaviorPosition.bottom, horizontalFirst: false)
        ],
        customSeriesRenderers: [
          new charts.LineRendererConfig(
              // ID used to link series to this renderer.
              customRendererId: 'customLine')
        ],
      ),
    );
  }

  setSerieChart(Set<Consultor> consultores) {
    for (var c in consultores) {
      for (var mr in c.monthlyReports) {
        c.serieChart.add(new SerieChart(c.noUsuario, mr.netEarning,
            mr.month.split(" ")[0].substring(0, 3)));
      }
    }
  }

  List<charts.Series<SerieChart, String>> createChartData(
      Set<Consultor> consultores) {
    List<charts.Series<SerieChart, String>> chartData = new List();
    for (var c in consultores) {
      chartData.add(
        new charts.Series<SerieChart, String>(
          id: c.noUsuario,
          domainFn: (SerieChart consultor, _) => consultor.month,
          measureFn: (SerieChart consultor, _) => consultor.netEarning,
          data: c.serieChart,
        ),
      );
    }
    chartData.add(getFixedCostAvgSerie(consultores));
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

  setMonthyReportsConsultorsChecked(Set<Consultor> consultores) {
    for (var c in consultores) {
      c.setMonthlyReports();
    }
  }

  charts.Series<SerieChart, String> getFixedCostAvgSerie(
      Set<Consultor> consultores) {
    double fixedCost = 0;

    for (var c in consultores) {
      for (var mr in c.monthlyReports) {
        fixedCost += mr.fixedCost;
      }
    }

    fixedCost = fixedCost / consultores.length;

    List<SerieChart> series = new List();

    series.add(new SerieChart("avg", fixedCost, "Ene"));
    series.add(new SerieChart("avg", fixedCost, "Dec"));

    charts.Series<SerieChart, String> serie =
        new charts.Series<SerieChart, String>(
      id: "Costo Fijo Promedio",
      domainFn: (SerieChart consultor, _) => consultor.month,
      measureFn: (SerieChart consultor, _) => consultor.netEarning,
      data: series,
      colorFn: (_, __) => charts.MaterialPalette.black,
    )..setAttribute(charts.rendererIdKey, 'customLine');
    return serie;
  }
}

class SerieChart {
  String noUsuario;
  double netEarning;
  String month;

  SerieChart(this.noUsuario, this.netEarning, this.month);
}
