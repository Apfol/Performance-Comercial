import 'package:comercial_performance/entities/consultor.dart';
import 'package:comercial_performance/pages/chart-page.dart';
import 'package:comercial_performance/pages/pie-chart-page.dart';
import 'package:comercial_performance/pages/report-page.dart';
import 'package:comercial_performance/requests/requests.dart';
import 'package:comercial_performance/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConsultoresList extends StatefulWidget {
  ConsultoresList({Key key}) : super(key: key);

  _ConsultoresListState createState() => _ConsultoresListState();
}

class _ConsultoresListState extends State<ConsultoresList> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  Future<List<Consultor>> consultores;
  Set<Consultor> consultoresChecked = new Set();

  var isSomeConsultorChecked = false;

  @override
  void initState() {
    super.initState();
    consultores = fetchConsultores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultores"),
        backgroundColor: utils.primaryColor,
      ),
      floatingActionButton: Visibility(
        visible: consultoresChecked.isNotEmpty,
        child: SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          visible: true,
          // If true user is forced to close dial manually
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          heroTag: 'speed-dial-hero-tag',
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.info),
                label: 'Informe',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportPage(
                              consultores: consultoresChecked,
                            )))),
            SpeedDialChild(
              child: Icon(FontAwesomeIcons.solidChartBar),
              label: 'Gráfico',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChartPage(
                            consultores: consultoresChecked,
                          ))),
            ),
            SpeedDialChild(
              child: Icon(Icons.pie_chart),
              label: 'Torta',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PieChartPage(
                            consultores: consultoresChecked,
                          ))),
            ),
          ],
        ),
      ),
      body: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: FutureBuilder(
              future: consultores,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildList(context, index, snapshot.data);
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return Container(
                    padding: EdgeInsets.all(100),
                    child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }

  changeborderAndCheckbox(List<Consultor> consultores, int index) {
    if (consultores[index].isChecked == false) {
      consultores[index].isChecked = true;
      consultoresChecked.add(consultores[index]);
    } else {
      consultores[index].isChecked = false;
      consultoresChecked.remove(consultores[index]);
    }
    consultores[index].borderColor == Colors.white
        ? consultores[index].borderColor = Colors.black
        : consultores[index].borderColor = Colors.white;
  }

  Widget buildList(
      BuildContext context, int index, List<Consultor> consultores) {
    return GestureDetector(
      onTap: () {
        setState(() {
          changeborderAndCheckbox(consultores, index);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: consultores[index].borderColor),
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
                    consultores[index].noUsuario,
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
                      Text(consultores[index].noEmail,
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
                      Text(
                          "Fecha de admisión: " +
                              utils.dateFormat
                                  .format(consultores[index].dtAdmissaoEmpresa),
                          style: TextStyle(
                              color: utils.primaryColor,
                              fontSize: 13,
                              letterSpacing: .3)),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Checkbox(
                value: consultores[index].isChecked,
                onChanged: (bool value) {
                  setState(() {
                    changeborderAndCheckbox(consultores, index);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
