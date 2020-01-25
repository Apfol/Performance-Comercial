import 'package:comercial_performance/entities/consultor.dart';
import 'package:comercial_performance/requests/requests.dart';
import 'package:comercial_performance/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);

  @override
  void initState() {
    super.initState();
    consultores = fetchConsultores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.info),
                label: 'Relatorio',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => print('FIRST CHILD')),
            SpeedDialChild(
              child: Icon(Icons.show_chart),
              label: 'Gráfico',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('SECOND CHILD'),
            ),
            SpeedDialChild(
              child: Icon(Icons.pie_chart),
              label: 'Torta',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('THIRD CHILD'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 145),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
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
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Consultores",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 110,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: TextField(
                          // controller: TextEditingController(text: locations[0]),
                          cursorColor: Theme.of(context).primaryColor,
                          style: dropdownMenuItem,
                          decoration: InputDecoration(
                              hintText: "Buscar consultor",
                              hintStyle: TextStyle(
                                  color: Colors.black38, fontSize: 16),
                              prefixIcon: Material(
                                elevation: 0.0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                child: Icon(Icons.search),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 13)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
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
                        color: primary,
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
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(consultores[index].noEmail,
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        color: secondary,
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
                              color: primary, fontSize: 13, letterSpacing: .3)),
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
