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
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  consultores.elementAt(index).noUsuario,
                  style: TextStyle(
                      color: utils.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      color: utils.secondaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                        utils.dateFormat.format(
                            consultores.elementAt(index).dtAdmissaoEmpresa),
                        style: TextStyle(
                            color: utils.primaryColor,
                            fontSize: 13,
                            letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      color: utils.secondaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Fecha de admisión: ",
                        style: TextStyle(
                            color: utils.primaryColor,
                            fontSize: 13,
                            letterSpacing: .3)),
                  ],
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
}
