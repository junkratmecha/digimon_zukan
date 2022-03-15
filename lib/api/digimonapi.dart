import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/digimon.dart';
import '../const/digimonapi.dart';

Future<Digimon> fetchDigimon(int id) async {
  final res = await http.get(Uri.parse('$DigimonApiRoute/show/$id'));
  if (res.statusCode == 200) {
    return Digimon.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to Load Digimon');
  }
}