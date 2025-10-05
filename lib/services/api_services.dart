// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/planet_model.dart';

class ApiService {
  // URL dasar untuk API NASA Exoplanet Archive
  // Kita akan mengambil nama planet, radius, massa, jarak, dan temperatur bintangnya
  static const String _baseUrl =
      'https://exoplanetarchive.ipac.caltech.edu/TAP/sync';

  // Fungsi untuk mengambil data planet
  Future<List<Planet>> fetchPlanets() async {
    // Query untuk memilih kolom yang kita inginkan dari tabel 'pscomppars'
    // dan membatasinya hanya 50 data agar tidak terlalu berat
    final query =
        'select+pl_name,pl_rade,pl_masse,sy_dist,st_teff+from+pscomppars+order+by+sy_dist+asc&format=json';

    final response = await http.get(Uri.parse('$_baseUrl?query=$query'));

    // Error yang sering terjadi adalah karena respons dari server tidak berhasil (bukan status code 200)
    // atau format data JSON tidak sesuai dengan yang diharapkan.
    if (response.statusCode == 200) {
      // Jika berhasil, decode JSON dan ubah menjadi List<Planet>
      List<dynamic> data = json.decode(response.body);
      
      // Hapus data yang nama planetnya kosong (terkadang ada di API)
      data.removeWhere((item) => item['pl_name'] == null);

      return data.map((json) => Planet.fromJson(json)).toList();
    } else {
      // Jika gagal, lemparkan error. Ini akan membantu Anda mengetahui apa penyebab masalahnya.
      throw Exception('Gagal memuat data planet dari API. Status code: ${response.statusCode}');
    }
  }
}