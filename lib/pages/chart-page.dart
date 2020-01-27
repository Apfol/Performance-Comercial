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
              setOrdinalConsultores(widget.consultores);
              List<charts.Series<SerieConsultor, String>> chartData =
                  createChartData(widget.consultores);
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: charts.BarChart(
                        chartData,
                        animate: false,
                        barGroupingType: charts.BarGroupingType.grouped,
                        behaviors: [
                          new charts.SeriesLegend(
                              position: charts.BehaviorPosition.bottom,
                              horizontalFirst: false)
                        ],
                        customSeriesRenderers: [
                          new charts.LineRendererConfig(
                              // ID used to link series to this renderer.
                              customRendererId: 'customLine')
                        ],
                      ),
                    ),
                  ),
                ],
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

  setOrdinalConsultores(Set<Consultor> consultores) {
    for (var c in consultores) {
      for (var mr in c.monthlyReports) {
        c.serieConsultores.add(new SerieConsultor(c.noUsuario, mr.netEarning,
            mr.month.split(" ")[0].substring(0, 3)));
      }
    }
  }

  List<charts.Series<SerieConsultor, String>> createChartData(
      Set<Consultor> consultores) {
    List<charts.Series<SerieConsultor, String>> chartData = new List();
    for (var c in consultores) {
      chartData.add(
        new charts.Series<SerieConsultor, String>(
          id: c.noUsuario,
          domainFn: (SerieConsultor consultor, _) => consultor.month,
          measureFn: (SerieConsultor consultor, _) => consultor.netEarning,
          data: c.serieConsultores,
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

  charts.Series<SerieConsultor, String> getFixedCostAvgSerie(
      Set<Consultor> consultores) {
    double fixedCost = 0;

    for (var c in consultores) {
      for (var mr in c.monthlyReports) {
        fixedCost += mr.fixedCost;
      }
    }

    fixedCost = fixedCost / consultores.length;

    List<SerieConsultor> series = new List();

    series.add(new SerieConsultor("avg", fixedCost, "Ene"));
    series.add(new SerieConsultor("avg", fixedCost, "Dec"));

    charts.Series<SerieConsultor, String> serie =
        new charts.Series<SerieConsultor, String>(
      id: "Costo Fijo Promedio",
      domainFn: (SerieConsultor consultor, _) => consultor.month,
      measureFn: (SerieConsultor consultor, _) => consultor.netEarning,
      data: series,
      colorFn: (_, __) => charts.MaterialPalette.black,
    )..setAttribute(charts.rendererIdKey, 'customLine');
    return serie;
  }
}

class SerieConsultor {
  String noUsuario;
  double netEarning;
  String month;

  SerieConsultor(this.noUsuario, this.netEarning, this.month);
}
