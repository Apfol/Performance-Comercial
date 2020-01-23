import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:comercial_performance/entities/consultor.dart';

String BASE_API = "https://amphibological-addi.000webhostapp.com/";

Future<Consultor> fetchConsultor() async {
  final response = await http.get(BASE_API + "get-cao-usuario.php");

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Consultor.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
