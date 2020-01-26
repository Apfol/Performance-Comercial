import 'dart:convert';
import 'package:comercial_performance/entities/fixed-cost.dart';
import 'package:comercial_performance/entities/report.dart';
import 'package:http/http.dart' as http;
import 'package:comercial_performance/entities/consultor.dart';

const String BASE_API = "https://amphibological-addi.000webhostapp.com/";

Future<Consultor> fetchConsultor() async {
  final response = await http.get(BASE_API + "get-cao-usuario.php");

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Consultor.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load consultor');
  }
}

Future<List<Consultor>> fetchConsultores() async {
  List<Consultor> consultores;
  final response = await http.get(BASE_API + "get-consultores.php");
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    var data = json.decode(response.body);
    var rest = data["consultores"] as List;
    consultores =
        rest.map<Consultor>((json) => Consultor.fromJson(json)).toList();
    return consultores;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load consultores');
  }
}

Future<List<Report>> fetchReports() async {
  List<Report> reports;

  var url = BASE_API + "get-reports.php";

  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    var data = json.decode(response.body);
    var rest = data["reports"] as List;
    reports = rest.map<Report>((json) => Report.fromJson(json)).toList();
    return reports;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load reports');
  }
}
