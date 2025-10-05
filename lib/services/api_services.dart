// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/planet_model.dart';

class ApiService {
  static const String _baseUrl = 'https://exoplanetarchive.ipac.caltech.edu/TAP/sync';

  // Tambahkan parameter offset dan limit
  Future<List<Planet>> fetchPlanets({int offset = 0, int limit = 50}) async {
    // Tambahkan TOP (untuk SQL Server) atau LIMIT (untuk database lain) ke query
    // API ini tampaknya tidak mendukung OFFSET, jadi kita gunakan TOP dan akan handle di client
    // Untuk API yang lebih baik, Anda akan menggunakan OFFSET di query SQL
    final query = 'select+TOP+${offset + limit}+pl_name,pl_rade,pl_masse,sy_dist,st_teff+from+pscomppars+order+by+sy_dist+asc&format=json';
    
    final response = await http.get(Uri.parse('$_baseUrl?query=$query'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      data.removeWhere((item) => item['pl_name'] == null);
      
      List<Planet> planets = data.map((json) => Planet.fromJson(json)).toList();

      // Hanya tambahkan Bumi pada halaman pertama
      if (offset == 0 && !planets.any((p) => p.name == 'Earth')) {
        planets.insert(0, Planet(
          name: 'Earth',
          radius: 1.0,
          mass: 1.0,
          distanceFromEarth: 0.0,
          stellarTemperature: 5778,
          habitability: 'Habitable',
          composition: 'Rocky',
        ));
      }

      // Ambil bagian data yang sesuai dengan "halaman"
      if (planets.length > offset) {
          return planets.sublist(offset);
      }
      
      return []; // Return list kosong jika offset melebihi data

    } else {
      throw Exception('Failed to load planet data from API. Status code: ${response.statusCode}');
    }
  }
}