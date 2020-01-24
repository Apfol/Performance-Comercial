import 'package:comercial_performance/pages/consultores.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Performance Comercial',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
          backgroundColor: Color(0xfff0f0f0),
          body: ConsultoresList(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('Relatorio'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.show_chart),
                title: new Text('Gráfico'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart), title: Text('Pizza'))
            ],
          )),
    );
  }
}
