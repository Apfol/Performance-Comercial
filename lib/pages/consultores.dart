import 'package:comercial_performance/entities/consultor.dart';
import 'package:comercial_performance/requests/requests.dart';
import 'package:comercial_performance/utils/utils.dart';
import 'package:flutter/material.dart';

class ConsultoresList extends StatefulWidget {
  ConsultoresList({Key key}) : super(key: key);
  static final String path = "lib/src/pages/lists/list2.dart";

  _ConsultoresListState createState() => _ConsultoresListState();
}

class _ConsultoresListState extends State<ConsultoresList> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  Future<List<Consultor>> consultores;

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
    return SingleChildScrollView(
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
                    return Container(
                      padding: EdgeInsets.only(bottom: 56),
                      child: Scaffold(
                        floatingActionButton: Visibility(
                          visible: isSomeConsultorChecked,
                          child: FloatingActionButton.extended(
                            onPressed: () {},
                            label: Text("Relatorio"),
                            icon: Icon(Icons.info),
                          ),
                        ),
                        body: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return buildList(context, index, snapshot.data);
                            }),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
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
                            hintStyle:
                                TextStyle(color: Colors.black38, fontSize: 16),
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
    );
  }

  bool checkConsultoresChecked(List<Consultor> consultores) {
    for (var c in consultores) {
      if (c.isChecked) {
        return true;
      }
    }
    return false;
  }

  changeborderAndCheckbox(List<Consultor> consultores, int index) {
    consultores[index].isChecked == false
        ? consultores[index].isChecked = true
        : consultores[index].isChecked = false;
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
          isSomeConsultorChecked = checkConsultoresChecked(consultores);
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
                              dateFormat
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
                    isSomeConsultorChecked =
                        checkConsultoresChecked(consultores);
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
