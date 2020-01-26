import 'package:comercial_performance/entities/consultor.dart';
import 'package:comercial_performance/entities/fixed-cost.dart';
import 'package:comercial_performance/entities/monthly-report.dart';
import 'package:comercial_performance/entities/report.dart';
import 'package:comercial_performance/requests/requests.dart';
import 'package:comercial_performance/utils/rowType.dart';
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
    reports = fetchReports();
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
              getConsultorReports(snapshot.data, widget.consultores);
              setMonthyReportsConsultorsChecked(widget.consultores);
              return ListView.builder(
                itemCount: widget.consultores.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildList(context, index, widget.consultores);
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

  Widget buildList(
      BuildContext context, int index, Set<Consultor> consultores) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      consultores.elementAt(index).noUsuario,
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
                Text(
                  "Ganancias Netas",
                  style: TextStyle(
                      color: utils.primaryColor,
                      fontSize: 14,
                      letterSpacing: .3),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  utils.currencyFormat.format(
                      getTotalNetEarnings(consultores.elementAt(index))),
                  style: TextStyle(
                      color: utils.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .3),
                ),
                SizedBox(
                  height: 13,
                ),
                Column(
                    children: consultores
                        .elementAt(index)
                        .monthlyReports
                        .map((monthlyReport) => MonthlyRow(
                              monthlyReport: monthlyReport,
                              rowType: RowType.netEarning,
                            ))
                        .toList()),
                Divider(
                  height: 40,
                  thickness: 2,
                ),
                Text(
                  "Comisión",
                  style: TextStyle(
                      color: utils.primaryColor,
                      fontSize: 14,
                      letterSpacing: .3),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  utils.currencyFormat
                      .format(getTotalCommission(consultores.elementAt(index))),
                  style: TextStyle(
                      color: utils.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .3),
                ),
                SizedBox(
                  height: 13,
                ),
                Column(
                    children: consultores
                        .elementAt(index)
                        .monthlyReports
                        .map((monthlyReport) => MonthlyRow(
                              monthlyReport: monthlyReport,
                              rowType: RowType.commission,
                            ))
                        .toList()),
                Divider(
                  height: 40,
                  thickness: 2,
                ),
                Text(
                  "Ganancia",
                  style: TextStyle(
                      color: utils.primaryColor,
                      fontSize: 14,
                      letterSpacing: .3),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  utils.currencyFormat
                      .format(getTotalProfit(consultores.elementAt(index))),
                  style: TextStyle(
                      color: utils.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .3),
                ),
                SizedBox(
                  height: 13,
                ),
                Column(
                    children: consultores
                        .elementAt(index)
                        .monthlyReports
                        .map((monthlyReport) => MonthlyRow(
                              monthlyReport: monthlyReport,
                              rowType: RowType.profit,
                            ))
                        .toList()),
                Divider(
                  height: 40,
                  thickness: 2,
                ),
                Text(
                  "Costo Fijo",
                  style: TextStyle(
                      color: utils.primaryColor,
                      fontSize: 14,
                      letterSpacing: .3),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  utils.currencyFormat.format(consultores
                      .elementAt(index)
                      .monthlyReports
                      .first
                      .fixedCost),
                  style: TextStyle(
                      color: utils.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .3),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  double getTotalNetEarnings(Consultor consultor) {
    double totalNetEarnings = 0;
    for (var mr in consultor.monthlyReports) {
      totalNetEarnings += mr.netEarning;
    }
    return totalNetEarnings;
  }

  double getTotalCommission(Consultor consultor) {
    double totalCommission = 0;
    for (var mr in consultor.monthlyReports) {
      totalCommission += mr.commission;
    }
    return totalCommission;
  }

  double getTotalProfit(Consultor consultor) {
    double totalProfit = 0;
    for (var mr in consultor.monthlyReports) {
      totalProfit += mr.profit;
    }
    return totalProfit;
  }
}

class MonthlyRow extends StatelessWidget {
  final MonthlyReport monthlyReport;
  final RowType rowType;

  MonthlyRow({
    this.monthlyReport,
    this.rowType,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget number;

    switch (rowType) {
      case RowType.netEarning:
        number = Text(
          utils.currencyFormat.format(monthlyReport.netEarning),
          style: TextStyle(
              color: utils.primaryColor, fontSize: 16, letterSpacing: .3),
        );
        break;
      case RowType.commission:
        number = Text(
          utils.currencyFormat.format(monthlyReport.commission),
          style: TextStyle(
              color: utils.primaryColor, fontSize: 16, letterSpacing: .3),
        );
        break;
      case RowType.profit:
        number = Text(
          utils.currencyFormat.format(monthlyReport.profit),
          style: TextStyle(
              color: utils.primaryColor, fontSize: 16, letterSpacing: .3),
        );
        break;
      default:
    }

    return Container(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                monthlyReport.month,
                style: TextStyle(
                    color: utils.primaryColor, fontSize: 16, letterSpacing: .3),
              ),
              number
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 4,
          )
        ],
      ),
    );
  }
}
