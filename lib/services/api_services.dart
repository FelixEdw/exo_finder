// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/planet_model.dart';

class ApiService {
  static const String _baseUrl =
      'https://exoplanetarchive.ipac.caltech.edu/TAP/sync';


  Future<List<Planet>> fetchPlanets() async {
    final query =
        'select+pl_name,pl_rade,pl_masse,sy_dist,st_teff+from+pscomppars+order+by+sy_dist+asc&format=json';
    final response = await http.get(Uri.parse('$_baseUrl?query=$query'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      data.removeWhere((item) => item['pl_name'] == null);
      return data.map((json) => Planet.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data planet dari API. Status code: ${response.statusCode}');
    }
  }
}